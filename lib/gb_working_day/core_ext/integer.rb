require 'gb_working_day/duration'
class Integer
  def working_days(week=nil)
    GBWorkingDay::Duration.new(self, week)
  end
end