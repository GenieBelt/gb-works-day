require 'gb_work_day/interval'
module GBWorkDay
  class Date < ::Date
    attr_accessor :work_week

    def -(other)
      if other.is_a?(::Date) || other.is_a?(::Time)
        Interval.new(self, other, week: self.work_week).working_days
      else
        super
      end
    end

    private

    # @return [GBWorkDay::WorkWeek]
    def default_week
      self.work_week || GBWorkDay::WorkWeek.current
    end

    class << self
      # Create {GBWorkingDay::Date} object from a given Date object.
      # Copy constructor.
      #
      # @param date [Date]
      def from_date(date, work_week = nil)
        new_date = self.jd(date.jd)
        new_date.work_week = work_week if work_week
        new_date
      end
    end
  end
end
