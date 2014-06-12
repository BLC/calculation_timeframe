# CalculationTimeframe

Converts timeframe strings such as "1wk", "3mo", "prev_yr", etc, into timeframe objects.

## Installation

Add this line to your application's Gemfile:

    gem 'calculation_timeframe'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install calculation_timeframe

## Usage

```ruby
 > timeframe = CalculationTimeframe.from_string("ytd")
=> 2014-1-1:2014-6-12
 > timeframe.start_time
=> 2014-01-01 00:00:00
 > timeframe.end_time
=> 2014-6-12 14:23:20
```

Supported formats
* x[dy/wk/mo/yr] - x number of days/weeks/etc ago
* prev_[dy/wk/mo/yr] - spans the last day/week/etc
* ytd - year to date
* YYYYQ[1-4] - spans a quarter of the year, ie 2010Q3
