require 'spec_helper'

module CalculationTimeframe
  describe CalculationTimeframe do
    before do
      Timecop.freeze
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
    end
  end
end
