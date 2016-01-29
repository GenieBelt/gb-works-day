require 'spec_helper'
require 'gb_working_day/helpers/date'
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
    expect((wednesday - GBWorkingDay::Date.from_date(monday))).to be_kind_of Rational
  end
end