require 'gb_works_day/duration'
require 'gb_works_day/helpers/date'
class Date
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
      plus_with_work_duration(- other)
    elsif GBWorksDay::Date === other
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

  # Get date object for calculating working days
  #
  # @param week [GBWorksDay::WorkWeek] if not set, it will use week set globally. For more check {GBWorkingDay::WorkWeek#current}
  def work_date(week=nil)
    GBWorksDay::Date.from_date self, week
  end
  alias_method :to_work, :work_date
  alias_method :to_work_date, :work_date

  private

  # @return [GBWorksDay::WorkWeek]
  def default_week
    GBWorksDay::WorkWeek.current
  end
end