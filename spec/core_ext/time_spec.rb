require 'spec_helper'
require 'gb_works_day/core_ext/time'
require 'gb_works_day/core_ext/integer'
require 'active_support/time'

describe 'Time extensions' do
  before(:all) { GBWorksDay::WorkWeek.current = GBWorksDay::WorkWeek.new(5) }
  after(:all)  { GBWorksDay::WorkWeek.current = GBWorksDay::WorkWeek.new() }

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
    expect(time.work_time).to be_kind_of GBWorksDay::Time
    expect(time.work_time).to eq time
  end

  it 'should respond to to_work_time' do
    time = Time.now
    expect(time.to_work_time).to be_kind_of GBWorksDay::Time
    expect(time.to_work_time).to eq time
  end

  it 'should respond to to_work' do
    time = Time.now
    expect(time.to_work).to be_kind_of GBWorksDay::Time
    expect(time.to_work).to eq time
  end

  it 'should properly subtract work times' do
    expect(Time.now - (Time.now + 1.day).to_work_time).to be_a_kind_of GBWorksDay::Duration
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
    expect(monday - 1.working_day).to eq (monday - 3.days)
    expect(wednesday - 2.working_day).to eq (wednesday - 2.days)
  end

  it 'should properly add work duration' do
    monday = Time.now.beginning_of_week
    wednesday = monday + 2.days
    friday = monday + 4.days
    expect(monday + 1.working_day).to eq (monday + 1.days)
    expect(friday + 1.working_day).to eq (friday + 3.days)
    expect(wednesday + 2.working_day).to eq (wednesday + 2.days)
  end
end