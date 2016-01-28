require 'spec_helper'
require 'gb_working_day/duration'
require 'active_support/time'

describe GBWorkingDay::Duration do

  it 'should add durations' do
    expect(GBWorkingDay::Duration.new(1) + GBWorkingDay::Duration.new(1)).to eq GBWorkingDay::Duration.new(2)
    expect(GBWorkingDay::Duration.new(1) + 1).to eq GBWorkingDay::Duration.new(2)
  end

  it 'should subtract durations' do
    expect(GBWorkingDay::Duration.new(10) - GBWorkingDay::Duration.new(7)).to eq GBWorkingDay::Duration.new(3)
    expect(GBWorkingDay::Duration.new(10) - 3).to eq GBWorkingDay::Duration.new(7)
  end

  it 'should negate durations' do
    expect(-GBWorkingDay::Duration.new(7)).to eq GBWorkingDay::Duration.new(-7)
  end

  it 'should respond to is_a?' do
    expect(GBWorkingDay::Duration.new(1).is_a? GBWorkingDay::Duration).to be_truthy
    expect(GBWorkingDay::Duration.new(1).is_a? Numeric).to be_truthy
  end

  it 'should respond to instance_of?' do
    expect(GBWorkingDay::Duration.new(1).instance_of? GBWorkingDay::Duration).to be_truthy
    expect(GBWorkingDay::Duration.new(1).instance_of? Fixnum).to be_truthy
  end

  it 'should respond do equality signs' do
    expect(GBWorkingDay::Duration.new(1) == GBWorkingDay::Duration.new(1)).to be_truthy
    expect(GBWorkingDay::Duration.new(1) == GBWorkingDay::Duration.new(2)).to be_falsey

    week = GBWorkingDay::WorkingWeek.new(3,3)
    expect(GBWorkingDay::Duration.new(1, week) == GBWorkingDay::Duration.new(1)).to be_falsey
    expect(GBWorkingDay::Duration.new(1, week) == GBWorkingDay::Duration.new(2)).to be_falsey

    expect(GBWorkingDay::Duration.new(1).eql? GBWorkingDay::Duration.new(1)).to be_truthy
    expect(GBWorkingDay::Duration.new(1).eql? GBWorkingDay::Duration.new(2)).to be_falsey
  end

  it 'should return number of sec for to_s' do
    expect(GBWorkingDay::Duration.new(1).to_s).to eq '86400'
  end


  it 'should respond to_i' do
    expect(GBWorkingDay::Duration.new(1).to_i).to eq 86400
    expect(GBWorkingDay::Duration.new(1).to_i(:days)).to eq 1
  end

  it 'should respond to inspect' do
    expect(GBWorkingDay::Duration.new(1).inspect).to be_kind_of String
  end

  it 'should calculate proper time for future' do
    week = GBWorkingDay::WorkingWeek.new(5,1)
    monday = Time.now.beginning_of_week

    expect(GBWorkingDay::Duration.new(1, week).since(monday)).to eq monday + 1.day
    expect(GBWorkingDay::Duration.new(3, week).since(monday)).to eq monday + 3.days
    expect(GBWorkingDay::Duration.new(5, week).since(monday)).to eq monday + 7.days
    expect(GBWorkingDay::Duration.new(6, week).since(monday)).to eq monday + 8.days
    expect(GBWorkingDay::Duration.new(16, week).since(monday)).to eq monday + 22.days
  end

  it 'should calculate proper time for ago' do
    week = GBWorkingDay::WorkingWeek.new(5,1)
    monday = Time.now.beginning_of_week

    expect(GBWorkingDay::Duration.new(1, week).until(monday)).to eq monday - 3.days
    expect(GBWorkingDay::Duration.new(3, week).until(monday)).to eq monday - 5.days
    expect(GBWorkingDay::Duration.new(6, week).until(monday)).to eq monday - 10.days
    expect(GBWorkingDay::Duration.new(16, week).until(monday)).to eq monday - 24.days
  end
end