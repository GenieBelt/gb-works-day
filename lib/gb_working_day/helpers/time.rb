require 'gb_working_day/interval'
module GBWorkingDay
  class Time < ::Time
    attr_accessor :work_week

    def -(other)
      if other.is_a?(::Time) || other.is_a?(::Date)
        Interval.new(self, other, week: work_week).working_days
      else
        super
      end
    end

    private

    # @return [GBWorkingDay::WorkingWeek]
    def default_week
      self.work_week || GBWorkingDay::WorkingWeek.current
    end

    class << self
      # Create {GBWorkingDay::Time} object from a given Time object.
      # Copy constructor.
      #
      # @param time [Time]
      def from_time(time, work_week=nil)
        new_time = self.at(time)
        new_time.work_week = work_week if work_week
        new_time
      end
    end
  end
end
