require 'gb_work_day/duration'
class Integer
  def working_days(week=nil)
    GBWorkDay::Duration.new(self, week)
  end

  alias working_day working_days
end