require 'gb_work_day/work_week'
module GBWorkDay
  class Duration
    SEC_IN_DAY = 86400
    include Comparable

    attr_accessor :work_days, :week
    def initialize(days, week=nil)
      @work_days = days
      @week = week || WorkWeek.current
    end

    def +(other) # :nodoc:
      if Duration === other
        Duration.new(work_days + other.work_days, week)
      else
        Duration.new(work_days + other, week)
      end
    end

    def -(other) # :nodoc:
      self + (-other)
    end

    def -@ # :nodoc:
      Duration.new(-work_days, week)
    end

    def is_a?(klass) # :nodoc:
      Duration == klass || work_days.is_a?(klass)
    end
    alias :kind_of? :is_a?

    def instance_of?(klass) # :nodoc:
      Duration == klass || work_days.instance_of?(klass)
    end

    def ==(other) # :nodoc:
      if Duration === other
        other.work_days == work_days && other.week == week
      else
        other == work_days
      end
    end

    # Returns the amount of seconds a duration covers as a string.
    # For more information check to_i method.
    #
    #   1.work_day.to_s # => "86400"
    def to_s
      to_i.to_s
    end

    # Returns the number of seconds that this Duration represents.
    def to_i(format = :seconds)
      if format == :days
        work_days
      else
        work_days * SEC_IN_DAY
      end
    end


    # Returns +true+ if +other+ is also a Duration instance, which has the
    # same parts as this one.
    def eql?(other)
      Duration === other && other.work_days.eql?(work_days) && other.week.eql?(week)
    end

    def inspect #:nodoc:
      "#{self.work_days} working days in a working week: #{week}"
    end

    # Calculates a new Time or Date that is as far in the future
    # as this Duration represents.
    # If time is a free day, it is calculated starting from the next work day
    def since(time = ::Time.current)
      self.work_days > 0 ? sum(time) : subtract(time)
    end
    alias :from_now :since

    # Calculates a new Time or Date that is as far in the past
    # as this Duration represents.
    # Time has to be a work day, it is calculated starting from the next work day
    def ago(time = ::Time.current)
      self.work_days > 0 ? subtract(time) : sum(time)
    end
    alias :until :ago

    def in_time_zone(zone)
      self
    end

    private

    def sum(time)
      time = next_work_day time
      distance_to_last_monday = (time.wday - 1) % 7
      weekends_count = (distance_to_last_monday + self.work_days.abs) / @week.work_days_per_week
      weekends_length = weekends_count * @week.free_days_per_week

      sum_normal_days(sum_normal_days(time, weekends_length), self.work_days.abs)
    end

    def subtract(time)
      time = next_work_day time
      distance_to_eof = distance_to_end_of_week(time)
      weekends_count = (distance_to_eof + self.work_days.abs) / @week.work_days_per_week
      weekends_length = weekends_count * @week.free_days_per_week

      sum_normal_days(sum_normal_days(time, -weekends_length), -self.work_days.abs)
    end

    # @param time [Date, Time]
    # @return distance_to_eof [Integer]
    def distance_to_end_of_week(time)
      (@week.work_days_per_week - time.wday) % (@week.work_days_per_week)
    end

    # Return next working day, or today if today is a working day
    # @param day [Date, Time]
    # @return [Date, Time]
    def next_work_day(day)
      if @week.free_day? day
        day.next_work_day(@week)
      else
        day
      end
    end

    # @param time [Date, Time]
    # @param days [Integer]
    def sum_normal_days(time, days)
      time + if time.is_a? ::Date
               days * 1
             else
               (days * SEC_IN_DAY)
             end
    end
  end
end
