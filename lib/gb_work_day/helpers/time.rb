require 'gb_work_day/interval'
module GBWorkDay
  class Time < ::Time
    attr_accessor :work_week

    def -(other)
      if other.is_a?(::Time) || other.is_a?(::Date)
        Interval.new(self, other, week: work_week).work_days
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
