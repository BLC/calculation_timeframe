require 'spec_helper'

module CalculationTimeframe
  describe Timeframe do
    before do
      Timecop.freeze
    end

    after do
      Timecop.return
    end

    describe "forward" do
      it "should cover the next 5 days" do
        Timeframe.new(:days, 5).forward.to_a.should == [Time.now, Time.now.advance(:days => 5)]
      end

      it "should cover the next 3 months" do
        Timeframe.new(:months, 3).forward.to_a.should == [Time.now, Time.now.advance(:months => 3)]
      end
    end
  end
end
