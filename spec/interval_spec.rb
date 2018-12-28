require 'spec_helper'
require 'gb_work_day/interval'
require 'active_support/time'


describe GBWorkDay::Interval do
  it 'properly calculates work days for interval for a 5 days week' do
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

  it 'properly calculates work days for interval for a 6 days week' do
    week = GBWorkDay::WorkWeek.new(6)
    monday = Date.today.beginning_of_week
    expect(GBWorkDay::Interval.new(monday - 1.day, monday, week: week).duration.work_days).to eq 0
    expect(GBWorkDay::Interval.new(monday - 2.day, monday, week: week).duration.work_days).to eq 1
    expect(GBWorkDay::Interval.new(monday, monday + 1.day, week: week).duration.work_days).to eq 1
    expect(GBWorkDay::Interval.new(monday, monday + 6.day, week: week).duration.work_days).to eq 6
    expect(GBWorkDay::Interval.new(monday, monday + 7.day, week: week).duration.work_days).to eq 6
    expect(GBWorkDay::Interval.new(monday, monday + 12.day, week: week).duration.work_days).to eq 11
  end

  it 'properly calculates work days for interval for a 7 days week' do
    week = GBWorkDay::WorkWeek.new(7)
    monday = Date.today.beginning_of_week
    expect(GBWorkDay::Interval.new(monday - 1.day, monday, week: week).duration.work_days).to eq 1
    expect(GBWorkDay::Interval.new(monday - 2.day, monday, week: week).duration.work_days).to eq 2
    expect(GBWorkDay::Interval.new(monday, monday + 1.day, week: week).duration.work_days).to eq 1
    expect(GBWorkDay::Interval.new(monday, monday + 6.day, week: week).duration.work_days).to eq 6
    expect(GBWorkDay::Interval.new(monday, monday + 7.day, week: week).duration.work_days).to eq 7
    expect(GBWorkDay::Interval.new(monday, monday + 12.day, week: week).duration.work_days).to eq 12
  end
end