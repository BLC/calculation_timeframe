require 'calculation_timeframe/version'
require 'active_support'
require 'active_support/core_ext'
require 'calculation_timeframe/timeframe'

module CalculationTimeframe
  SUPPORTED_TIME_FRAMES = {
    "dy" => :days,
    "wk" => :weeks,
    "mo" => :months,
    "yr" => :years
  }

  OTHER_TIME_FRAMES = {
    /ytd/ => :year_to_date,
    /[0-9,_]+Q[0-9,_]+$/ => :extract_quarter,
    /(prev|last)_*/ => :extract_last_timeframe
  }

  OFFSETS = {
    "prev" => 1,
    "last" => 1
  }

  class << self
    def from_string(input_string)
      found_tf = find_timeframe(input_string)
      if found_tf
        return send(found_tf, input_string) if found_tf.is_a?(Symbol)
        return extract_timeframe(found_tf, input_string)
      end

      raise UnsupportedTimeframe
    end

    def extract_timeframe(tf, input)
      amount = input[ /\d*(?:\.\d+)?/ ]
      amount = amount.empty? ? 1 : amount.to_i
      offset = extract_offset(input)
      Timeframe.new(SUPPORTED_TIME_FRAMES[tf], amount, offset)
    end

    def extract_offset(input)
      OFFSETS.each do |key, v|
        return v if (input =~ /#{key}/i) != nil
      end
      0
    end

    def find_timeframe(input)
      SUPPORTED_TIME_FRAMES.each do |tf, v|
        return tf if (input =~ /[0-9]+#{tf}$/) != nil
      end

      OTHER_TIME_FRAMES.each do |tf, v|
        return v if (input =~ tf) != nil
      end

      nil
    end

    def year_to_date(input)
      Timeframe.new(:days, 0, 0, Time.now.beginning_of_year, Time.now)
    end

    def extract_quarter(input)
      year, quarter = input.scan(/[0-9]+/).map(&:to_i)
      Timeframe.new(:days, 0, 0, Time.new(year).advance(months: 3 * (quarter - 1)),
        Time.new(year).advance(months: 3 * quarter, days: -1).end_of_day)
    end

    def extract_last_timeframe(input)
      found_tf = nil
      SUPPORTED_TIME_FRAMES.each do |tf, v|
        found_tf = tf if (input =~ /#{tf}$/) != nil
        break if found_tf
      end
      raise UnsupportedTimeframe if found_tf.nil?

      date_shift = {}.tap { |d| d[SUPPORTED_TIME_FRAMES[found_tf]] = -1 }
      date_type = case found_tf
        when "dy"
          :day
        when "wk"
          :week
        when "mo"
          :month
        when "yr"
          :year
        end

      start_date = Time.now.advance(date_shift).send("beginning_of_#{date_type}")
      end_date = start_date.send("end_of_#{date_type}")

      Timeframe.new(SUPPORTED_TIME_FRAMES[found_tf], 0, 0, start_date, end_date)
    end
  end

  class UnsupportedTimeframe < StandardError; end
end
