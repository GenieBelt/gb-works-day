require 'gb_working_day/interval'
module GBWorkingDay
  class Date < ::Date
    def -(other)
      if other.is_a? Date
        other - Interval.new(self, other).working_days
      else
        super
      end
    end
  end
end
