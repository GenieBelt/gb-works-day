require 'gb_work_day/duration'
require 'gb_work_day/helpers/date'
class Date
  def plus_with_work_duration(other)
    if GBWorkDay::Duration === other
      other.since(self)
    else
      plus_without_work_duration(other)
    end
  end
  alias_method :plus_without_work_duration, :+
  alias_method :+, :plus_with_work_duration

  def minus_with_work_duration(other)
    if GBWorkDay::Duration === other
      plus_with_work_duration(- other)
    elsif GBWorkDay::Date === other
      - (other - self)
    else
      minus_without_work_duration(other)
    end
  end
  alias_method :minus_without_work_duration, :-
  alias_method :-, :minus_with_work_duration

  # Check if it is a work day.
  # @return [boolean]
  def work?(week = default_week)
    week.work_day? self
  end

  # Check if it is a work day.
  # @return [boolean]
  def free?(week = default_week)
    week.free_day? self
  end

  # Return next working day
  # @return [Time]
  def next_work_day(week = default_week)
    if week.free_day? self
      self.beginning_of_week + 7.days
    else
      self + GBWorkDay::Duration.new(1, week)
    end
  end

  # Return previous working day
  # @return [Time]
  def previous_work_day(week = default_week)
    if week.free_day? self
      next_work_day(week) - (week.free_days_per_week + 1).days
    else
      self - GBWorkDay::Duration.new(1, week)
    end
  end

  # Get date object for calculating working days
  #
  # @param week [GBWorkDay::WorkWeek] if not set, it will use week set globally. For more check {GBWorkingDay::WorkWeek#current}
  def work_date(week = nil)
    GBWorkDay::Date.from_date self, week
  end
  alias_method :to_work, :work_date
  alias_method :to_work_date, :work_date

  private

  # @return [GBWorkDay::WorkWeek]
  def default_week
    GBWorkDay::WorkWeek.current
  end
end