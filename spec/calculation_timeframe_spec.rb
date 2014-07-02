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
        CalculationTimeframe.from_string("1dy").to_a.should == [Time.now.advance(days: -1), Time.now]
      end

      it "should recognize 20dy" do
        CalculationTimeframe.from_string("20dy").to_a.should == [Time.now.advance(days: -20), Time.now]
      end

      it "should recognize 3mo" do
        CalculationTimeframe.from_string("3mo").to_a.should == [Time.now.advance(months: -3), Time.now]
      end

      it "should recognize 2wk" do
        CalculationTimeframe.from_string("2wk").to_a.should == [Time.now.advance(weeks: -2), Time.now]
      end

      it "should recognize 3yr" do
        CalculationTimeframe.from_string("3yr").to_a.should == [Time.now.advance(years: -3), Time.now]
      end

      it "should recognize last_month" do
        CalculationTimeframe.from_string("prev_mo").to_a.should == [Time.now.advance(months: -1).beginning_of_month, Time.now.beginning_of_month]
      end

      it "should recognize last_year" do
        CalculationTimeframe.from_string("last_yr").to_a.should == [Time.now.advance(years: -1).beginning_of_year, Time.now.beginning_of_year]
      end

      it "should recognize YYYYQX" do
        CalculationTimeframe.from_string("2008Q1").to_a.map(&:to_date).should == ["2008-1-1".to_date, "2008-3-31".to_date]
        CalculationTimeframe.from_string("2008Q2").to_a.map(&:to_date).should == ["2008-4-1".to_date, "2008-6-30".to_date]
        CalculationTimeframe.from_string("2008Q3").to_a.map(&:to_date).should == ["2008-7-1".to_date, "2008-9-30".to_date]
        CalculationTimeframe.from_string("2008Q4").to_a.map(&:to_date).should == ["2008-10-1".to_date, "2008-12-31".to_date]
      end

      it "should place quarter end times at the end of the day" do
        CalculationTimeframe.from_string("2008Q1").to_a[1].should == "2008-3-31".to_date.end_of_day
      end

      it "should recognize ytd" do
        CalculationTimeframe.from_string("ytd").to_a.should == [Time.now.beginning_of_year, Time.now]
      end
    end
  end
end
