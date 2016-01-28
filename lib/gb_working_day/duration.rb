require 'gb_working_day/working_week'
module GBWorkingDay
  class Duration
    SEC_IN_DAY = 86400
    include Comparable

    attr_accessor :work_days, :week
    def initialize(days, week=nil)
      @work_days = days
      @week = week || WorkingWeek.current
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
        other.work_days == work_days
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
      Duration === other && other.work_days.eql?(work_days)
    end

    def inspect #:nodoc:
      "#{self.work_days} working days in a working week: #{week}"
    end

    # Calculates a new Time or Date that is as far in the future
    # as this Duration represents.
    def since(time = ::Time.current)
      sum(1, time)
    end
    alias :from_now :since

    # Calculates a new Time or Date that is as far in the past
    # as this Duration represents.
    def ago(time = ::Time.current)
      sum(-1, time)
    end
    alias :until :ago

    private

    def sum(symbol, time)
      work_days_left = self.work_days
      while work_days_left > 0
        time += (symbol * SEC_IN_DAY)
        work_days_left -= 1 if @week.work_day? time
      end
      time
    end
  end
end
