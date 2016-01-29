require 'spec_helper'
require 'gb_working_day/helpers/time'
require 'active_support/time'

describe GBWorkingDay::Time do

  it 'should be a subclass of time' do
    expect(GBWorkingDay::Time.now).to be_kind_of ::Time
  end

  it 'should be able to make a copy form other time instance' do
    old_time = ::Time.now
    expect(GBWorkingDay::Time.from_time old_time).to be_kind_of GBWorkingDay::Time
    expect(GBWorkingDay::Time.from_time old_time).to eq old_time
  end

  it 'should return work day duration on subtraction' do
    monday = Time.now.beginning_of_week
    wednesday = monday + 2.days
    expect(GBWorkingDay::Time.from_time(wednesday) - monday).to be_kind_of GBWorkingDay::Duration
    expect(GBWorkingDay::Time.from_time(wednesday) - GBWorkingDay::Time.from_time(monday)).to be_kind_of GBWorkingDay::Duration
    expect(GBWorkingDay::Time.from_time(wednesday) - 100).to be_kind_of Time
    expect(wednesday - GBWorkingDay::Time.from_time(monday)).to eq 172800.0
  end
end