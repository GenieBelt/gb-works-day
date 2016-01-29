require 'gb_work_day/duration'
class Integer
  def work_days(week=nil)
    GBWorkDay::Duration.new(self, week)
  end

  alias work_day work_days
end