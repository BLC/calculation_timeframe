require 'spec_helper'

module CalculationTimeframe
  describe CalculationTimeframe do
    before do
      Timecop.freeze Time.now
    end

    after do
      Timecop.return
    end

    describe "from_string" do
      it "should recognize 1dy" do
        expect(CalculationTimeframe.from_string("1dy").to_a).to eq([Time.now.advance(days: -1), Time.now])
      end

      it "should recognize 20dy" do
        expect(CalculationTimeframe.from_string("20dy").to_a).to eq([Time.now.advance(days: -20), Time.now])
      end

      it "should recognize 3mo" do
        expect(CalculationTimeframe.from_string("3mo").to_a).to eq([Time.now.advance(months: -3), Time.now])
      end

      it "should recognize 2wk" do
        expect(CalculationTimeframe.from_string("2wk").to_a).to eq([Time.now.advance(weeks: -2), Time.now])
      end

      it "should recognize 3yr" do
        expect(CalculationTimeframe.from_string("3yr").to_a).to eq([Time.now.advance(years: -3), Time.now])
      end

      it "should recognize last day" do
        last_day = Time.now.advance(days: -1)
        expect(CalculationTimeframe.from_string('last_dy').to_a).to eq([last_day.beginning_of_day, last_day.end_of_day])
      end

      it "should recognize last week" do
        last_week = Time.now.advance(weeks: -1)
        expect(CalculationTimeframe.from_string('last_wk').to_a).to eq([last_week.beginning_of_week, last_week.end_of_week])
      end

      it "should recognize last month" do
        last_month = Time.now.advance(months: -1)
        expect(CalculationTimeframe.from_string('prev_mo').to_a).to eq([last_month.beginning_of_month, last_month.end_of_month])
      end

      it "should recognize last year" do
        last_year = Time.now.advance(years: -1)
        expect(CalculationTimeframe.from_string('last_yr').to_a).to eq([last_year.beginning_of_year, last_year.end_of_year])
      end

      it "should recognize YYYYQX" do
        expect(CalculationTimeframe.from_string("2008Q1").to_a.map(&:to_date)).to eq(["2008-1-1".to_date, "2008-3-31".to_date])
        expect(CalculationTimeframe.from_string("2008Q2").to_a.map(&:to_date)).to eq(["2008-4-1".to_date, "2008-6-30".to_date])
        expect(CalculationTimeframe.from_string("2008Q3").to_a.map(&:to_date)).to eq(["2008-7-1".to_date, "2008-9-30".to_date])
        expect(CalculationTimeframe.from_string("2008Q4").to_a.map(&:to_date)).to eq(["2008-10-1".to_date, "2008-12-31".to_date])
      end

      it "should place quarter end times at the end of the day" do
        expect(CalculationTimeframe.from_string("2008Q1").to_a[1]).to eq("2008-3-31".to_date.end_of_day)
      end

      it "should recognize ytd" do
        expect(CalculationTimeframe.from_string("ytd").to_a).to eq([Time.now.beginning_of_year, Time.now])
      end
    end
  end
end
