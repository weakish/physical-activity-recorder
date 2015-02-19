# physical-activity-recorder

[![Gem Version](https://badge.fury.io/rb/physical-activity-recorder.svg)](http://badge.fury.io/rb/physical-activity-recorder)

`physical-activity-recorder` is a command line tool to record and plan physical activity.

## Installation

### Command line

Install via `gem`:

    ; gem install physical-activity-recorder

You may add `sudo` before the above command to install it globally.

You can also clone this repo and run `rake install`.

### Library

Although `physical-activity-recorder` is a command line tool,
you can also use it as a library.

Add this line to your application's Gemfile:

```ruby
gem 'physical-activity-recorder'
```

And then execute:

    $ bundle


## Command line usage

### tl;tr

```sh
; physical-activity-recorder help
Usage:
            physical-activity-recorder moderate_minutes [vigorous_minutes, notes]
            physical-activity-recorder query
```

### Walkthrough

You do half an hour of running:

```sh
; physical-activity-recorder 0 30 'running'
Soft: YYYY-MM-DD; Hard: YYYY-MM-DD
```

That is, it is best to exercise again before *Soft*.
If you are a bit lazy, you can postpone it to before *Hard*.

[United States Department of Agriculture](http://www.choosemyplate.gov/physical-activity/amount.html)
recommends at least 2 hours and 30 minutes of moderate activity each week,
and suggests 5 or more hours activity per week
can provide even more health benefits.
*Soft* and *Hard* are roughly calculated based on this.
(There may be some slight differences for implement simplicity.)

With vigorous activities, you get similar health benefits in half the time it takes you with moderate ones.

There is a simple rule to distinguish moderate and vigorous activity:

- When you do moderate activity, you cannot sing.
- When you do vigorous activity, you cannot speak.

See [What is Physical Activity?](http://www.choosemyplate.gov/physical-activity/what.html)
for examples of moderate and vigorous activity.


Say, next day you do 2 hours of walking briskly:

```sh
; physical-activity-recorder 120 0 'walking'
Soft: YYYY-MM-DD; Hard: YYYY-MM-DD
```

You can omit notes if you only want to record time:

```sh
; physical-activity-recorder 120
```

This will extend *Soft* and *Hard*.

Be aware:

1.  If you exercise less than 10 minutes, it will be recorded but *Soft* and *Hard* will not be extended.
    You'd better exercise more than 10 minutes at a time.
2.  *Soft* and *Hard* won't exceed 7 days from now.
    Dedicating several days to exercises does not mean you need no exercise for several weeks.
    Also, for example, you have stopped exercising for one month since you are in the hospital, it does not make sense to make up that month afterwards.

You can query *Soft* and *Hard* via

```sh
; physical-activity-recorder query
```

or if you are lazy:

```sh
; physical-activity-recorder q
```

Exercising records are stored in:

1. `PHYSICAL_ACTIVITY_RECORDS` if this environment varibale is set
2. `physical-activity-recorder` under `$XDG_CONFIG_HOME` or `~/.config` otherwise

The data store format is [Daybreak](http://propublica.github.io/daybreak/).

## Library usage

```ruby
require `physical-activity-recorder`
Physical_activity_recorder.func [arguments]
```

func is one of the following:

- `record`
- `add_to_records`
- `plan`


See [documentation](http://www.rubydoc.info/gems/physical-activity-recorder/) for more information.

### Testing

We use [RubyDoctest](http://rubygems.org/gems/rubydoctest) for testing.
(Note that before my pull requests get merged, you need to use [my branch](https://github.com/weakish/rubydoctest/).)

There is a rake task for it:

```sh
rake test
```

## Contributing

1. Fork it ( https://github.com/weakish/physical-activity-recorder/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Signing commits with gpg is optional, but preferred.
