module GBWorkDay
  class WorkWeek
    attr_reader :work_days_per_week, :free_days_per_week, :work_days, :free_days, :week_start

    # @param work_days [#to_i] Amount of working days in a week. Default value is 7.
    # @param week_start [#to_i] Number of a week day, when work starts. Default value is 1 corresponding to Monday
    def initialize(work_days=7, week_start=1)
      work_days = work_days.to_i
      week_start = week_start.to_i
      raise ArgumentError, 'Work days have to be between 0 and 7!' unless work_days >= 0 && work_days <= 7
      @work_days_per_week = work_days
      @week_start = week_start % 7
      @free_days_per_week = 7 - @work_days_per_week
      @work_days = []
      @work_days_per_week.times do
        day = week_start % 7
        @work_days << (day != 0 ? day : 7)
        week_start += 1
      end
      @work_days.sort!
      @free_days = (1..7).to_a - @work_days
    end

    # Check if given day is a work day
    # @param day [Time, Date]
    def work_day?(day)
      week_day = day.wday
      week_day = 7 if week_day == 0
      work_days.include? week_day
    end

    # Check if given day is a work day
    # @param day [Time, Date]
    def free_day?(day)
      week_day = day.wday
      week_day = 7 if week_day == 0
      free_days.include? week_day
    end

    def ==(other) # :nodoc:
      work_days_per_week == other.work_days_per_week && week_start == other.week_start
    end

    def eql?(other) # :nodoc:
      work_days_per_week.eql?(other.work_days_per_week) && week_start.eql?(other.week_start)
    end

    class << self
      def current
        Thread.current[:working_week] ||= self.new
      end

      def current=(new_week)
        Thread.current[:working_week] = new_week if WorkWeek === new_week
      end
    end
  end
end
