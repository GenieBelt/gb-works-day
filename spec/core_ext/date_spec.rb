require 'spec_helper'
require 'gb_work_day/core_ext/date'
require 'gb_work_day/core_ext/integer'
require 'active_support/time'

describe 'Date extensions' do
  before(:all) { GBWorkDay::WorkWeek.current = GBWorkDay::WorkWeek.new(5) }
  after(:all)  { GBWorkDay::WorkWeek.current = GBWorkDay::WorkWeek.new() }

  it 'should respond to work?' do
    expect(Date.today.beginning_of_week.work?).to be_truthy
    expect(Date.today.end_of_week.work?).to be_falsey
  end

  it 'should respond to free?' do
    expect(Date.today.beginning_of_week.free?).to be_falsey
    expect(Date.today.end_of_week.free?).to be_truthy
  end

  it 'should respond to work_date' do
    date = Date.today
    expect(date.work_date).to be_kind_of GBWorkDay::Date
    expect(date.work_date).to eq date
  end

  it 'should respond to to_work_date' do
    date = Date.today
    expect(date.to_work_date).to be_kind_of GBWorkDay::Date
    expect(date.to_work_date).to eq date
  end

  it 'should respond to to_work' do
    date = Date.today
    expect(date.to_work).to be_kind_of GBWorkDay::Date
    expect(date.to_work).to eq date
  end

  it 'should properly subtract work dates' do
    expect(Date.today - Date.tomorrow.to_work_date).to be_a_kind_of GBWorkDay::Duration
  end

  it 'should return next_work_day' do
    monday = Date.today.beginning_of_week
    friday = monday + 4.days
    sunday = Date.today.end_of_week
    expect(monday.next_work_day). to eq (monday + 1.day)
    expect(friday.next_work_day). to eq (friday + 3.day)
    expect(sunday.next_work_day). to eq (sunday + 1.day)
  end

  it 'should properly subtract work duration' do
    monday = Date.today.beginning_of_week
    wednesday = monday + 2.days
    expect(monday - 1.working_day).to eq (monday - 3.days)
    expect(wednesday - 2.working_day).to eq (wednesday - 2.days)
  end

  it 'should properly add work duration' do
    monday = Date.today.beginning_of_week
    wednesday = monday + 2.days
    friday = monday + 4.days
    expect(monday + 1.working_day).to eq (monday + 1.days)
    expect(friday + 1.working_day).to eq (friday + 3.days)
    expect(wednesday + 2.working_day).to eq (wednesday + 2.days)
  end
end