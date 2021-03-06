require 'spec_helper'
require 'gb_work_day/core_ext/time'
require 'gb_work_day/core_ext/integer'
require 'active_support/time'

describe 'Time extensions' do
  before(:all) { GBWorkDay::WorkWeek.current = GBWorkDay::WorkWeek.new(5) }
  after(:all)  { GBWorkDay::WorkWeek.current = GBWorkDay::WorkWeek.new() }

  it 'should respond to work?' do
    expect(Time.now.beginning_of_week.work?).to be_truthy
    expect(Time.now.end_of_week.work?).to be_falsey
  end

  it 'should respond to free?' do
    expect(Time.now.beginning_of_week.free?).to be_falsey
    expect(Time.now.end_of_week.free?).to be_truthy
  end

  it 'should respond to work_time' do
    time = Time.now
    expect(time.work_time).to be_kind_of GBWorkDay::Time
    expect(time.work_time).to eq time
  end

  it 'should respond to to_work_time' do
    time = Time.now
    expect(time.to_work_time).to be_kind_of GBWorkDay::Time
    expect(time.to_work_time).to eq time
  end

  it 'should respond to to_work' do
    time = Time.now
    expect(time.to_work).to be_kind_of GBWorkDay::Time
    expect(time.to_work).to eq time
  end

  it 'should properly subtract work times' do
    expect(Time.now - (Time.now + 1.day).to_work_time).to be_a_kind_of GBWorkDay::Duration
  end

  it 'should return next_work_day' do
    monday = Time.now.beginning_of_week
    friday = monday + 4.days
    sunday = Time.now.end_of_week
    expect(monday.next_work_day). to eq (monday + 1.day)
    expect(friday.next_work_day). to eq (friday + 3.day)
    expect(sunday.next_work_day). to eq (sunday + 1.day)
  end

  it 'should properly subtract work duration' do
    monday = Time.now.beginning_of_week
    wednesday = monday + 2.days
    expect(monday - 1.work_day).to eq (monday - 3.days)
    expect(wednesday - 2.work_day).to eq (wednesday - 2.days)
  end

  it 'should properly add work duration' do
    monday = Time.now.beginning_of_week
    sunday = monday - 1.day
    wednesday = monday + 2.days
    friday = monday + 4.days
    expect(sunday + 1.work_day).to eq (monday + 1.days)
    expect(sunday + 1.work_day - 1.work_day).to eq monday
    expect(monday + 1.work_day).to eq (monday + 1.days)
    expect(friday + 1.work_day).to eq (friday + 3.days)
    expect(wednesday + 2.work_day).to eq (wednesday + 2.days)
  end
end