require 'spec_helper'
require 'gb_works_day/helpers/time'
require 'gb_works_day/core_ext/time'
require 'active_support/time'

describe GBWorksDay::Time do

  it 'should be a subclass of time' do
    expect(GBWorksDay::Time.now).to be_kind_of ::Time
  end

  it 'should be able to make a copy form other time instance' do
    old_time = ::Time.now
    expect(GBWorksDay::Time.from_time old_time).to be_kind_of GBWorksDay::Time
    expect(GBWorksDay::Time.from_time old_time).to eq old_time
  end

  it 'should return work day duration on subtraction' do
    monday = Time.now.beginning_of_week
    wednesday = monday + 2.days
    expect(GBWorksDay::Time.from_time(wednesday) - monday).to be_kind_of GBWorksDay::Duration
    expect(GBWorksDay::Time.from_time(wednesday) - GBWorksDay::Time.from_time(monday)).to be_kind_of GBWorksDay::Duration
    expect(GBWorksDay::Time.from_time(wednesday) - 100).to be_kind_of Time
    expect(wednesday - GBWorksDay::Time.from_time(monday)).to be_a_kind_of GBWorksDay::Duration
  end

  it 'should use set week for work? method' do
    week = GBWorksDay::WorkWeek.new(3, 3)
    monday = Time.now.beginning_of_week
    wednesday = monday + 2.days
    expect(GBWorksDay::Time.from_time(monday, week).work?).to be_falsey
    expect(GBWorksDay::Time.from_time(wednesday, week).work?).to be_truthy
  end

  it 'should use set week for free? method' do
    week = GBWorksDay::WorkWeek.new(3, 3)
    monday = Time.now.beginning_of_week
    wednesday = monday + 2.days
    expect(GBWorksDay::Time.from_time(monday, week).free?).to be_truthy
    expect(GBWorksDay::Time.from_time(wednesday, week).free?).to be_falsey
  end

  it 'should use set week for next_work_day? method' do
    week = GBWorksDay::WorkWeek.new(3, 3)
    monday = Time.now.beginning_of_week
    wednesday = monday + 2.days
    expect(GBWorksDay::Time.from_time(monday, week).next_work_day).to eq wednesday
    expect(GBWorksDay::Time.from_time(wednesday, week).next_work_day).to eq (wednesday + 1.day)
  end
end