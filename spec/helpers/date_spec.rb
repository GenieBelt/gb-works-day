require 'spec_helper'
require 'gb_working_day/helpers/date'
require 'gb_working_day/core_ext/date'
require 'active_support/time'

describe GBWorkingDay::Date do

  it 'should be a subclass of date' do
    expect(GBWorkingDay::Date.today).to be_kind_of ::Date
  end

  it 'should be able to make a copy form other date instance' do
    old_date = ::Date.today
    expect(GBWorkingDay::Date.from_date old_date).to be_kind_of GBWorkingDay::Date
    expect(GBWorkingDay::Date.from_date old_date).to eq old_date
  end

  it 'should return work day duration on subtraction' do
    monday = Date.today.beginning_of_week
    wednesday = monday + 2.days
    expect(GBWorkingDay::Date.from_date(wednesday) - monday).to be_kind_of GBWorkingDay::Duration
    expect(GBWorkingDay::Date.from_date(wednesday) - GBWorkingDay::Date.from_date(monday)).to be_kind_of GBWorkingDay::Duration
    expect(GBWorkingDay::Date.from_date(monday) - 1).to be_kind_of Date
    expect((wednesday - GBWorkingDay::Date.from_date(monday))).to be_kind_of GBWorkingDay::Duration
  end

  it 'should use set week for work? method' do
    week = GBWorkingDay::WorkingWeek.new(3,3)
    monday = Date.today.beginning_of_week
    wednesday = monday + 2.days
    expect(GBWorkingDay::Date.from_date(monday, week).work?).to be_falsey
    expect(GBWorkingDay::Date.from_date(wednesday, week).work?).to be_truthy
  end

  it 'should use set week for free? method' do
    week = GBWorkingDay::WorkingWeek.new(3,3)
    monday = Date.today.beginning_of_week
    wednesday = monday + 2.days
    expect(GBWorkingDay::Date.from_date(monday, week).free?).to be_truthy
    expect(GBWorkingDay::Date.from_date(wednesday, week).free?).to be_falsey
  end

  it 'should use set week for next_work_day? method' do
    week = GBWorkingDay::WorkingWeek.new(3,3)
    monday = Date.today.beginning_of_week
    wednesday = monday + 2.days
    expect(GBWorkingDay::Date.from_date(monday, week).next_work_day).to eq wednesday
    expect(GBWorkingDay::Date.from_date(wednesday, week).next_work_day).to eq (wednesday + 1.day)
  end

  context 'class methods' do
    it 'should return GBWorkingDay::Date on today' do
      expect(GBWorkingDay::Date.today).to be_kind_of GBWorkingDay::Date
    end
  end
end