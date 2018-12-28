require 'spec_helper'
require 'gb_work_day/work_week'
require 'active_support/time'

describe GBWorkDay::WorkWeek do

  context 'work days' do
    it 'should calculates work days for 7 days work and start on monday' do
      week = GBWorkDay::WorkWeek.new(7)
      expect(week.work_days).to eq [1,2,3,4,5,6,7]
    end
    it 'should calculates work days for 5 days work week and start on monday' do
      week = GBWorkDay::WorkWeek.new(5)
      expect(week.work_days).to eq [1,2,3,4,5]
    end
  end

  context 'free days' do
    it 'should calculates free days for 7 days work' do
      week = GBWorkDay::WorkWeek.new(7)
      expect(week.free_days).to eq []
    end

    it 'should calculates free days for 5 days work week and start on monday' do
      week = GBWorkDay::WorkWeek.new(5)
      expect(week.free_days).to eq [6,7]
    end
  end

  it 'should respond to work_day? if day is a Time' do
    week = GBWorkDay::WorkWeek.new(5)
    expect(week.work_days).to eq [1,2,3,4,5]
    monday = Time.now.beginning_of_week

    expect(week.work_day? monday).to eq true

    expect(week.work_day? monday + 1.day).to eq true
    expect(week.work_day? monday + 2.days).to eq true
    expect(week.work_day? monday + 3.days).to eq true
    expect(week.work_day? monday + 4.days).to eq true
    expect(week.work_day? monday + 5.days).to eq false
    expect(week.work_day? monday + 6.days).to eq false
  end

  it 'should respond to work_day? if day is a Date' do
    week = GBWorkDay::WorkWeek.new(5)
    expect(week.work_days).to eq [1,2,3,4,5]
    monday = Date.today.beginning_of_week

    expect(week.work_day? monday).to eq true           #mondey
    expect(week.work_day? monday + 1.day).to eq true   #tuesday
    expect(week.work_day? monday + 2.days).to eq true  #wednesday
    expect(week.work_day? monday + 3.days).to eq true  #thursday
    expect(week.work_day? monday + 4.days).to eq true  #friday
    expect(week.work_day? monday + 5.days).to eq false #saturday
    expect(week.work_day? monday + 6.days).to eq false #sunday
  end

  it 'should respond to free_day? if day is a Time' do
    week = GBWorkDay::WorkWeek.new(5)
    expect(week.free_days).to eq [6,7]
    monday = Time.now.beginning_of_week

    expect(week.free_day? monday).to eq false
    expect(week.free_day? monday + 1.day).to eq false
    expect(week.free_day? monday + 2.days).to eq false
    expect(week.free_day? monday + 3.days).to eq false
    expect(week.free_day? monday + 4.days).to eq false
    expect(week.free_day? monday + 5.days).to eq true
    expect(week.free_day? monday + 6.days).to eq true
  end

  it 'should respond to free_day? if day is a Date' do
    week = GBWorkDay::WorkWeek.new(5)
    expect(week.free_days).to eq [6,7]
    monday = Date.today.beginning_of_week

    expect(week.free_day? monday).to eq false
    expect(week.free_day? monday + 1.day).to eq false
    expect(week.free_day? monday + 2.days).to eq false
    expect(week.free_day? monday + 3.days).to eq false
    expect(week.free_day? monday + 4.days).to eq false
    expect(week.free_day? monday + 5.days).to eq true
    expect(week.free_day? monday + 6.days).to eq true
  end
end