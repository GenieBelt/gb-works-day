require 'spec_helper'
require 'gb_work_day/interval'
require 'active_support/time'


describe GBWorkDay::Interval do
  it 'properly calculate work days for interval' do
    week = GBWorkDay::WorkWeek.new(5)
    monday = Date.today.beginning_of_week
    expect(GBWorkDay::Interval.new(monday - 1.day, monday, week: week).duration.work_days).to eq 0
    expect(GBWorkDay::Interval.new(monday - 2.day, monday, week: week).duration.work_days).to eq 0
    expect(GBWorkDay::Interval.new(monday + 1.day, monday, week: week).duration.work_days).to eq -1
    expect(GBWorkDay::Interval.new(monday, monday + 1.day, week: week).duration.work_days).to eq 1
    expect(GBWorkDay::Interval.new(monday, monday + 5.day, week: week).duration.work_days).to eq 5
    expect(GBWorkDay::Interval.new(monday, monday + 7.day, week: week).duration.work_days).to eq 5
    expect(GBWorkDay::Interval.new(monday, monday + 12.day, week: week).duration.work_days).to eq 10
    expect(GBWorkDay::Interval.new(monday, monday + 14.day, week: week).duration.work_days).to eq 10
  end
end