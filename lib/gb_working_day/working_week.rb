module GBWorkingDay
  class WorkingWeek
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
      work_days.include? day.wday
    end

    # Check if given day is a work day
    # @param day [Time, Date]
    def free_day?(day)
      free_days.include? day.wday
    end
  end
end
