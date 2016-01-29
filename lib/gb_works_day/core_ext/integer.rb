require 'gb_works_day/duration'
class Integer
  def working_days(week=nil)
    GBWorksDay::Duration.new(self, week)
  end

  alias working_day working_days
end