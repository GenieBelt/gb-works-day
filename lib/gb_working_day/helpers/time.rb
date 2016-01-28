require 'gb_working_day/interval'
module GBWorkingDay
  class Time < ::Date
    def -(other)
      if other.is_a? Time
        other - Interval.new(self, other).working_days
      else
        super
      end
    end
  end
end
