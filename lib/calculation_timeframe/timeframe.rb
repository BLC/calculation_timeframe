module CalculationTimeframe
  class Timeframe
    def initialize(time_period, amount, offset=0, start_time=Time.now, end_time=nil)
      @current_time = start_time
      @end_time = end_time
      @time_period = time_period
      @amount = amount
      @offset = offset
      @forward = false
    end

    def [](index)
      index == 0 ? start_time : end_time
    end

    def start_time
      if @forward
        @current_time.advance(@time_period => @offset)
      else
        @current_time.advance(@time_period => -1 * (@offset + @amount))
      end
    end

    def end_time
      return @end_time if @end_time
      if @forward
        @current_time.advance(@time_period => (@offset + @amount))
      else
        @current_time.advance(@time_period => -1 * @offset)
      end
    end

    def to_a
      [start_time, end_time]
    end

    def forward
      @forward = true
      self
    end

    def to_s
      start_key = "#{start_time.year}-#{start_time.month}-#{start_time.day}"
      end_key = "#{end_time.year}-#{end_time.month}-#{end_time.day}"

      "#{start_key}:#{end_key}"
    end
  end
end
