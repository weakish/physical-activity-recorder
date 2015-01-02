require 'physical-activity-recorder/version'
require 'time-lord'

# Record and plan physical activity.
# Usage:
# ```ruby
# require `physical-activity-recorder`
# Physical_activity_recorder.func [arguments]
# ```


module Physical_activity_recorder

  # @doctest prepare time
  #   >> time = Time.at(1000000000)
  #   => 2001-09-09 09:46:40 +0800

  module_function

  # Record physical activity.
  #
  # @param [Time]
  # @param [Fixnum]
  # @param [Fixnum]
  # @param [String]
  # @return [{String => (Fixnum, Fixnum, String)}]
  #
  # @doctest record
  #   >> record = Physical_activity_recorder.method(:record)
  #   >> record_1 = record[time, 50]
  #   => {"2001-09-09" =>[50, 0, ""]}
  #   >> record_2 = record[time, 180, 10]
  #   => {"2001-09-09"=>[180, 10, ""]}
  #   >> record_3 = record[time, 0, 2, 'running']
  #   => {"2001-09-09"=>[0, 2, "running"]}
   
  def record(activity_time=Time.now, moderate_minutes=0, vigorous_minutes=0, activity_notes='')
    {activity_time.strftime('%F') => [moderate_minutes, vigorous_minutes, activity_notes]}
  end


  # Add record.
  #
  # @param [{String => (Fixnum, Fixnum, String)}]
  # @param [{String => (Fixnum, Fixnum, String)}]
  # @return [void]
  #
  # @doctest prepare records
  #   >> records = {"2001-01-01" =>[1, 2, ""]}
  #   => {"2001-01-01"=>[1, 2, ""]}
  #   >> add_to_records = Physical_activity_recorder.method(:add_to_records)
  #
  # @doctest do not add empty records
  #   >> add_to_records[{"2011-01-01" =>[0, 0, "empty"]}, records]; records
  #   => {"2001-01-01"=>[1, 2, ""]}
  #
  # @doctest add new record (nonexist date)
  #   >> add_to_records[record_1, records]; records
  #   => {"2001-01-01"=>[1, 2, ""], "2001-09-09"=>[50, 0, ""]}
  #
  # @doctest add new record (exist date)
  #   >> add_to_records[record_2, records]; records
  #   => {"2001-01-01"=>[1, 2, ""], "2001-09-09"=>[230, 10, ""]}
  #   >> add_to_records[record_3, records]; records
  #   => {"2001-01-01"=>[1, 2, ""], "2001-09-09"=>[230, 12, "running"]}

  def add_to_records(new_record, records)
    activity_time = new_record.keys[0]
    if records.key?(activity_time)
      old = records[activity_time]
      new = (0..2).map do |i|
        old[i] + new_record[activity_time][i]
      end
      records[activity_time] = new
    # do not add empty records
    elsif new_record[activity_time].first(2).reduce(:+) == 0
      records
    else
      records[activity_time] = new_record[activity_time]
    end
  end


  # Plan physical activity
  #
  # @param [Time]
  # @param [Time]
  # @param [Time]
  # @param [Fixnum]
  # @param [Fixnum]
  # @return [{Symbol => Time}]
  #
  # @doctest first plan
  #   >> time = Time.at(1000000000)
  #   => 2001-09-09 09:46:40 +0800
  #   >> plan = Physical_activity_recorder.method(:plan)
  #   >> ends = plan[time, time, time, 30, 0]
  #   => {:soft=>2001-09-10 00:46:40 +0800, :hard=>2001-09-10 15:46:40 +0800}
  #
  # @doctest second plan
  #   >> plan[time, ends[:soft], ends[:hard], 180, 0]
  #   => {:soft=>2001-09-13 18:46:40 +0800, :hard=>2001-09-16 09:46:40 +0800}
  # @doctest plan within 7 days
  #   >> plan[time, time, time, 2000, 0]
  #   => {:soft=>2001-09-16 09:46:40 +0800, :hard=>2001-09-16 09:46:40 +0800}
  #   >> plan[time, time, time, 3000, 3000]
  #   => {:soft=>2001-09-16 09:46:40 +0800, :hard=>2001-09-16 09:46:40 +0800}

  def plan(current_time=Time.now, current_soft_end=Time.now, current_hard_end=Time.now, moderate_minutes=0, vigorous_minutes=0)
    # Activity should be done for at least 10 minutes at a time.
    if moderate_minutes + vigorous_minutes < 10
      hard_end = current_hard_end
      soft_end = current_soft_end
    else
      # With vigorous activities, you get similar health benefits in half the time it takes you with moderate ones.
      increment_time = moderate_minutes + vigorous_minutes * 2
      # United States Department of Agriculture recommends at least 2 hours and 30 minutes each week
      # of aerobic physical activity at a moderate level.
      # 2 hours and 30 minutes is 150 (2 * 60 + 30) minutes per week,
      # and we set the hard end based on 168 (24 * 7) minutes per week, i.e. 1 minute for 1 hour.
      # I chose 168 for implement simplicity.
      hard_end = current_hard_end + increment_time.hours

      # United States Department of Agriculture suggests
      # 5 or more hours activity per week can provide even more health benefits.
      # 5 hours is  300 (5 * 60) minutes per week,
      # and we set the soft end based on 336 (24 * 7 * 2) minutes per week, i.e. 2 minutes for 1 hour.
      # Again, I chose 336 for  implement simplicity.
      soft_end = current_soft_end + (increment_time / 2).to_i.hours
    end

    # soft end and hard end should not exceed 7 days (1 week).
    result = {soft: soft_end, hard: hard_end}
    result.each do |k, v|
      result[k] = if v  - current_time < 7.days
            v
          else
            current_time + 7.days
          end
    end
    result
  end
end
