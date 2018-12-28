require 'gb_work_day/work_week'
require 'gb_work_day/duration'
require 'gb_work_day/core_ext/date'
require 'gb_work_day/core_ext/integer'

module GBWorkDay
  class Interval
    attr_reader :start_time, :end_time

    # @param start_time [Time, Date]
    # @param end_time [Time, Date]
    # @param params [Hash]
    # @option params [Fixnum] :work_days number of work days in a week, default is 7
    def initialize(start_time, end_time, params = Hash.new)
      @start_time = start_time
      @end_time = end_time
      @symbol = 1
      revert if @start_time > @end_time
      @working_week = params[:week]
      unless @working_week
        if params[:work_days]
          work_days = params.fetch(:work_days, 7)
          @working_week = WorkWeek.new work_days
        else
          @working_week = WorkWeek.current
        end
      end
      @work_start_time = next_work_day @start_time
      @work_end_time = next_work_day @end_time
    end

    # @return [Integer] Number of working days in a given period
    def work_days
      if @working_week.work_days_per_week == 7
        work_days = end_time.minus_without_work_duration(start_time).to_i
      else
        monday_before_start = @work_start_time.beginning_of_week
        monday_before_end   = @work_end_time.beginning_of_week

        full_week_days = monday_before_end.minus_without_work_duration(monday_before_start).to_i
        days_without_weekends = full_week_days - (full_week_days / 7) * @working_week.free_days_per_week
        partial_week_days = @work_end_time.wday - @work_start_time.wday

        work_days = days_without_weekends + partial_week_days
      end
      Duration.new(work_days * @symbol, @working_week)
    end

    alias_method :duration, :work_days

    def endpoints
      [start_time, end_time]
    end

    private

    def revert
      new_end_time = @start_time
      @start_time = @end_time
      @end_time = new_end_time
      @symbol *= -1
    end

    # Return next working day, or today if today is a working day
    # @param day [Date, Time]
    # @return [Date, Time]
    def next_work_day(day)
      if @working_week.free_day? day
        day.next_work_day(@working_week)
      else
        day
      end
    end
  end
end
