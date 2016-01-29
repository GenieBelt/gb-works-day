# GbWorkDay

Library to make calculation on work days.
Unlike others libraries like [`business_time`](https://github.com/bokmann/business_time), 
[`working_hours`](https://github.com/Intrepidd/working_hours), [`biz`](https://github.com/zendesk/biz)
it operates on whole days, not hours. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gb_work_day'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gb_work_day

## Usage

### Work week

Set default work week for current thread

```ruby
beginning_of_week = 1 #Monday 
work_days = 5 #wrokd days are Monday-Friday
GBWorkDay::WorkWeek.current = GBWorkWeek.new(work_days, beginning_of_week)
```

or if you want to setup per instance

```ruby
beginning_of_week = 1 #Monday 
work_days = 5 #wrokd days are Monday-Friday
week = GBWorkWeek.new(work_days, beginning_of_week)
my_date = Date.today.to_work_date(week)
```

or 

```ruby
beginning_of_week = 1 #Monday 
work_days = 5 #wrokd days are Monday-Friday
week = GBWorkWeek.new(work_days, beginning_of_week)
my_date = my_date
#some code here
my_date.week = week
```

### Date and Time operation

Check if today is a work day
 
```ruby
Date.today.work?
```

or

```ruby
Time.now.work?
```

Check if today is holiday

```ruby
Date.today.free?
```

or

```ruby
Time.now.free?
```

Get next working day

```ruby
Date.today.next_work_day
```

or

```ruby
Time.now.next_work_day
```


You can also make more complicated calculations

```ruby
delivery_date = Date.today + 10.work_days
```

or 

```ruby
amount_of_work = (start_date.to_work_date - end_date).work_days
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/gb_work_day/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Alternatives

* [`business_time`](https://github.com/bokmann/business_time)
* [`working_hours`](https://github.com/Intrepidd/working_hours)
* [`biz`](https://github.com/zendesk/biz)
