require 'gb_working_day/working_week'
module GbWorkingDay
  class Interval
    attr_reader :start_time, :end_time

    # @param start_time [Time, Date]
    # @param end_time [Time, Date]
    # @param params [Hash]
    # @option params [Fixnum] :work_days number of work days in a week, default is 7
    # @option params [Fixnum] :week_start first working day in a week as number. Default value is 1 corresponding to Monday.
    def initialize(start_time, end_time, params=Hash.new)
      @start_time = start_time
      @end_time = end_time
      revert if @start_time > @end_time
      work_days = params.fetch(:work_days, 7)
      week_start = params.fetch(:week_start, 1)
      @working_week = WorkingWeek.new work_days, week_start
    end

    # @return [Integer] Number of working days in a given period
    def working_days
      date = @start_time
      working_days = 0
      while date < end_time
        working_days += 1 if @working_week.work_day?(date)
        date += 1.day
      end
    end

    def endpoints
      [start_time, end_time]
    end

    private

    def revert
      new_end_time = @start_time
      @start_time = @end_time
      @end_time = new_end_time
    end
  end
end
