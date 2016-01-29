require 'gb_works_day/duration'
require 'gb_works_day/helpers/time'
class Time
  def plus_with_work_duration(other)
    if GBWorksDay::Duration === other
      other.since(self)
    else
      plus_without_work_duration(other)
    end
  end
  alias_method :plus_without_work_duration, :+
  alias_method :+, :plus_with_work_duration

  def minus_with_work_duration(other)
    if GBWorksDay::Duration === other
      plus_with_work_duration(-other)
    elsif GBWorksDay::Time === other
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
    self + GBWorksDay::Duration.new(1, default_week)
  end

  # Get time object for calculating working days
  #
  # @param week [GBWorksDay::WorkWeek] if not set, it will use week set globally. For more check {GBWorkingDay::WorkWeek#current}
  def work_time(week=nil)
    GBWorksDay::Time.from_time self, week
  end
  alias_method :to_work, :work_time
  alias_method :to_work_time, :work_time

  private

  # @return [GBWorksDay::WorkWeek]
  def default_week
    GBWorksDay::WorkWeek.current
  end
end