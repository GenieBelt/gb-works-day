require 'spec_helper'
require 'gb_works_day/interval'
require 'active_support/time'


describe GBWorksDay::Interval do
  it 'properly calculate work days for interval' do
    week = GBWorksDay::WorkWeek.new(5)
    monday = Date.today.beginning_of_week
    expect(GBWorksDay::Interval.new(monday - 1.day, monday, week: week).duration.work_days).to eq 0
    expect(GBWorksDay::Interval.new(monday - 2.day, monday, week: week).duration.work_days).to eq 0
    expect(GBWorksDay::Interval.new(monday + 1.day, monday, week: week).duration.work_days).to eq -1
    expect(GBWorksDay::Interval.new(monday, monday + 1.day, week: week).duration.work_days).to eq 1
    expect(GBWorksDay::Interval.new(monday, monday + 5.day, week: week).duration.work_days).to eq 5
    expect(GBWorksDay::Interval.new(monday, monday + 7.day, week: week).duration.work_days).to eq 5
    expect(GBWorksDay::Interval.new(monday, monday + 12.day, week: week).duration.work_days).to eq 10
    expect(GBWorksDay::Interval.new(monday, monday + 14.day, week: week).duration.work_days).to eq 10
  end
end