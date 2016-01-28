require 'spec_helper'
require 'gb_working_day/core_ext/integer'
require 'gb_working_day/duration'

describe 'Integer extensions' do

  it 'should respond working_days' do
    expect(2.working_days).to be_kind_of GBWorkingDay::Duration
    expect(2.working_days.work_days).to eq 2
    expect(2.working_days.week).to eq GBWorkingDay::WorkingWeek.current
  end

  it 'should respond working_day' do
    expect(1.working_day).to be_kind_of GBWorkingDay::Duration
    expect(1.working_day.work_days).to eq 1
    expect(1.working_day.week).to eq GBWorkingDay::WorkingWeek.current
  end

  it 'should setup proper week on working_days' do
    week = GBWorkingDay::WorkingWeek.new(5,1)
    expect(2.working_days(week).week).to eq week
  end

  it 'should be able to sum' do
    expect(1.working_day + 2).to eq 3.working_days
    expect(1.working_day + 2.working_day).to eq 3.working_days
  end
end