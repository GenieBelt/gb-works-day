require 'gb_working_day/duration'
require 'gb_working_day/helpers/time'
class Time
  def plus_with_work_duration(other)
    if GBWorkingDay::Duration === other
      other.since(self)
    else
      plus_without_work_duration(other)
    end
  end
  alias_method :plus_without_work_duration, :+
  alias_method :+, :plus_with_work_duration

  def minus_with_work_duration(other)
    if GBWorkingDay::Duration === other
      plus_with_work_duration(-other)
    elsif GBWorkingDay::Time === other
      other - self
    else
      minus_without_work_duration(other)
    end
  end
  alias_method :minus_without_work_duration, :-
  alias_method :-, :minus_with_work_duration


  # Check if it is a work day.
  # @return [boolean]
  def work?
    default_week.work_day? self
  end

  # Check if it is a work day.
  # @return [boolean]
  def free?
    default_week.free_day? self
  end

  # Return next working day
  # @return [Time]
  def next_work_day
    self + GBWorkingDay::Duration.new(1, default_week)
  end

  # Get time object for calculating working days
  #
  # @param week [GBWorkingDay::WorkingWeek] if not set, it will use week set globally. For more check {GBWorkingDay::WorkingWeek#current}
  def work_time(week=nil)
    GBWorkingDay::Time.from_time self, week
  end
  alias_method :to_work, :work_time
  alias_method :to_work_time, :work_time

  private

  # @return [GBWorkingDay::WorkingWeek]
  def default_week
    GBWorkingDay::WorkingWeek.current
  end
end