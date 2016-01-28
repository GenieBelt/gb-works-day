require 'spec_helper'
require 'gb_working_day/working_week'
require 'active_support/time'

describe GBWorkingDay::WorkingWeek do

  context 'work days' do
    it 'should calculates work days for 7 days work and start on monday' do
      week = GBWorkingDay::WorkingWeek.new(7, 1)
      expect(week.work_days).to eq [1,2,3,4,5,6,7]
    end

    it 'should calculates work days for 7 days work and start on tuesday' do
      week = GBWorkingDay::WorkingWeek.new(7, 2)
      expect(week.work_days).to eq [1,2,3,4,5,6,7]
    end

    it 'should calculates work days for 5 days work week and start on monday' do
      week = GBWorkingDay::WorkingWeek.new(5, 1)
      expect(week.work_days).to eq [1,2,3,4,5]
    end

    it 'should calculates work days for 5 days work week and start on tuesday' do
      week = GBWorkingDay::WorkingWeek.new(5, 2)
      expect(week.work_days).to eq [2,3,4,5,6]
    end

    it 'should calculates work days for 5 days work week and start on thursday' do
      week = GBWorkingDay::WorkingWeek.new(5, 4)
      expect(week.work_days).to eq [1,4,5,6,7]
    end

    it 'should calculates work days for 3 days work week and start on wednesday' do
      week = GBWorkingDay::WorkingWeek.new(3, 3)
      expect(week.work_days).to eq [3,4,5]
    end
  end

  context 'free days' do
    it 'should calculates free days for 7 days work and start on any day' do
      week = GBWorkingDay::WorkingWeek.new(7, rand(6)+1)
      expect(week.free_days).to eq []
    end

    it 'should calculates free days for 5 days work week and start on monday' do
      week = GBWorkingDay::WorkingWeek.new(5, 1)
      expect(week.free_days).to eq [6,7]
    end

    it 'should calculates work days for 5 days work week and start on tuesday' do
      week = GBWorkingDay::WorkingWeek.new(5, 2)
      expect(week.free_days).to eq [1,7]
    end

    it 'should calculates work days for 5 days work week and start on thursday' do
      week = GBWorkingDay::WorkingWeek.new(5, 4)
      expect(week.free_days).to eq [2,3]
    end

    it 'should calculates work days for 3 days work week and start on wednesday' do
      week = GBWorkingDay::WorkingWeek.new(3, 3)
      expect(week.free_days).to eq [1,2,6,7]
    end
  end

  it 'should respond to work_day? if day is a Time' do
    week = GBWorkingDay::WorkingWeek.new(5, 1)
    expect(week.work_days).to eq [1,2,3,4,5]
    monday = Time.now.beginning_of_week
    expect(monday.monday?).to be_truthy

    expect(week.work_day? monday).to eq true

    expect(week.work_day? monday + 1.day).to eq true
    expect(week.work_day? monday + 2.days).to eq true
    expect(week.work_day? monday + 3.days).to eq true
    expect(week.work_day? monday + 4.days).to eq true
    expect(week.work_day? monday + 5.days).to eq false
    expect(week.work_day? monday + 6.days).to eq false
  end

  it 'should respond to work_day? if day is a Date' do
    week = GBWorkingDay::WorkingWeek.new(5, 1)
    expect(week.work_days).to eq [1,2,3,4,5]
    monday = Date.today.beginning_of_week
    expect(monday.monday?).to be_truthy

    expect(week.work_day? monday).to eq true
    expect(week.work_day? monday + 1.day).to eq true   #tuesday
    expect(week.work_day? monday + 2.days).to eq true  #wednesday
    expect(week.work_day? monday + 3.days).to eq true  #thursday
    expect(week.work_day? monday + 4.days).to eq true  #friday
    expect(week.work_day? monday + 5.days).to eq false #saturday
    expect(week.work_day? monday + 6.days).to eq false #sunday
  end

  it 'should respond to free_day? if day is a Time' do
    week = GBWorkingDay::WorkingWeek.new(5, 1)
    expect(week.free_days).to eq [6,7]
    monday = Time.now.beginning_of_week
    expect(monday.monday?).to be_truthy

    expect(week.work_day? monday).to eq false
    expect(week.work_day? monday + 1.day).to eq false
    expect(week.work_day? monday + 2.days).to eq false
    expect(week.work_day? monday + 3.days).to eq false
    expect(week.work_day? monday + 4.days).to eq false
    expect(week.work_day? monday + 5.days).to eq true
    expect(week.work_day? monday + 6.days).to eq true
  end

  it 'should respond to free_day? if day is a Date' do
    week = GBWorkingDay::WorkingWeek.new(5, 1)
    expect(week.free_days).to eq [6,7]
    monday = Date.today.beginning_of_week
    expect(monday.monday?).to be_truthy

    expect(week.work_day? monday).to eq false
    expect(week.work_day? monday + 1.day).to eq false
    expect(week.work_day? monday + 2.days).to eq false
    expect(week.work_day? monday + 3.days).to eq false
    expect(week.work_day? monday + 4.days).to eq false
    expect(week.work_day? monday + 5.days).to eq true
    expect(week.work_day? monday + 6.days).to eq true
  end
end