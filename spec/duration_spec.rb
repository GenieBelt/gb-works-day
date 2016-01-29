require 'spec_helper'
require 'gb_work_day/duration'
require 'active_support/time'

describe GBWorkDay::Duration do

  it 'should add durations' do
    expect(GBWorkDay::Duration.new(1) + GBWorkDay::Duration.new(1)).to eq GBWorkDay::Duration.new(2)
    expect(GBWorkDay::Duration.new(1) + 1).to eq GBWorkDay::Duration.new(2)
  end

  it 'should subtract durations' do
    expect(GBWorkDay::Duration.new(10) - GBWorkDay::Duration.new(7)).to eq GBWorkDay::Duration.new(3)
    expect(GBWorkDay::Duration.new(10) - 3).to eq GBWorkDay::Duration.new(7)
  end

  it 'should negate durations' do
    expect(-GBWorkDay::Duration.new(7)).to eq GBWorkDay::Duration.new(-7)
  end

  it 'should respond to is_a?' do
    expect(GBWorkDay::Duration.new(1).is_a? GBWorkDay::Duration).to be_truthy
    expect(GBWorkDay::Duration.new(1).is_a? Numeric).to be_truthy
  end

  it 'should respond to instance_of?' do
    expect(GBWorkDay::Duration.new(1).instance_of? GBWorkDay::Duration).to be_truthy
    expect(GBWorkDay::Duration.new(1).instance_of? Fixnum).to be_truthy
  end

  it 'should respond do equality signs' do
    expect(GBWorkDay::Duration.new(1) == GBWorkDay::Duration.new(1)).to be_truthy
    expect(GBWorkDay::Duration.new(1) == GBWorkDay::Duration.new(2)).to be_falsey
    expect(GBWorkDay::Duration.new(1) == 1).to be_truthy
    expect(GBWorkDay::Duration.new(1) == 2).to be_falsey

    week = GBWorkDay::WorkWeek.new(3, 3)
    expect(GBWorkDay::Duration.new(1, week) == GBWorkDay::Duration.new(1)).to be_falsey
    expect(GBWorkDay::Duration.new(1, week) == GBWorkDay::Duration.new(2)).to be_falsey

    expect(GBWorkDay::Duration.new(1).eql? GBWorkDay::Duration.new(1)).to be_truthy
    expect(GBWorkDay::Duration.new(1).eql? GBWorkDay::Duration.new(2)).to be_falsey
  end

  it 'should return number of sec for to_s' do
    expect(GBWorkDay::Duration.new(1).to_s).to eq '86400'
  end


  it 'should respond to_i' do
    expect(GBWorkDay::Duration.new(1).to_i).to eq 86400
    expect(GBWorkDay::Duration.new(1).to_i(:days)).to eq 1
  end

  it 'should respond to inspect' do
    expect(GBWorkDay::Duration.new(1).inspect).to be_kind_of String
  end

  it 'should calculate proper time for future' do
    week = GBWorkDay::WorkWeek.new(5, 1)
    monday = Time.now.beginning_of_week

    expect(GBWorkDay::Duration.new(1, week).since(monday)).to eq monday + 1.day
    expect(GBWorkDay::Duration.new(-1, week).since(monday)).to eq monday - 3.days
    expect(GBWorkDay::Duration.new(3, week).since(monday)).to eq monday + 3.days
    expect(GBWorkDay::Duration.new(5, week).since(monday)).to eq monday + 7.days
    expect(GBWorkDay::Duration.new(6, week).since(monday)).to eq monday + 8.days
    expect(GBWorkDay::Duration.new(16, week).since(monday)).to eq monday + 22.days
  end

  it 'should calculate proper date for future' do
    week = GBWorkDay::WorkWeek.new(5, 1)
    monday = Date.today.beginning_of_week

    expect(GBWorkDay::Duration.new(1, week).since(monday)).to eq monday + 1.day
    expect(GBWorkDay::Duration.new(-1, week).since(monday)).to eq monday - 3.days
    expect(GBWorkDay::Duration.new(3, week).since(monday)).to eq monday + 3.days
    expect(GBWorkDay::Duration.new(5, week).since(monday)).to eq monday + 7.days
    expect(GBWorkDay::Duration.new(6, week).since(monday)).to eq monday + 8.days
    expect(GBWorkDay::Duration.new(16, week).since(monday)).to eq monday + 22.days
  end

  it 'should calculate proper time for past' do
    week = GBWorkDay::WorkWeek.new(5, 1)
    monday = Time.now.beginning_of_week

    expect(GBWorkDay::Duration.new(1, week).until(monday)).to eq monday - 3.days
    expect(GBWorkDay::Duration.new(-1, week).until(monday)).to eq monday + 1.days
    expect(GBWorkDay::Duration.new(3, week).until(monday)).to eq monday - 5.days
    expect(GBWorkDay::Duration.new(6, week).until(monday)).to eq monday - 10.days
    expect(GBWorkDay::Duration.new(16, week).until(monday)).to eq monday - 24.days
  end

  it 'should calculate proper date for past' do
    week = GBWorkDay::WorkWeek.new(5, 1)
    monday = Date.today.beginning_of_week

    expect(GBWorkDay::Duration.new(1, week).until(monday)).to eq monday - 3.days
    expect(GBWorkDay::Duration.new(-1, week).until(monday)).to eq monday + 1.days
    expect(GBWorkDay::Duration.new(3, week).until(monday)).to eq monday - 5.days
    expect(GBWorkDay::Duration.new(6, week).until(monday)).to eq monday - 10.days
    expect(GBWorkDay::Duration.new(16, week).until(monday)).to eq monday - 24.days
  end
end