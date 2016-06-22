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
    if default_week.free_day? self
      next_day = self
      while default_week.free_day? next_day
        next_day += 1
      end
      next_day
    else
      self + GBWorkDay::Duration.new(1, default_week)
    end
  end

  # Return previous working day
  # @return [Time]
  def previous_work_day
    if default_week.free_day? self
      previous_day = self
      while default_week.free_day? previous_day
        previous_day -= 1
      end
      previous_day
    else
      self - GBWorkDay::Duration.new(1, default_week)
    end
  end

  # Get date object for calculating working days
  #
  # @param week [GBWorkDay::WorkWeek] if not set, it will use week set globally. For more check {GBWorkingDay::WorkWeek#current}
  def work_date(week=nil)
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