# frozen_string_literal: true

def count_increasing(depths)
  count_increased = 0
  previous_depth = 0

  depths.each do |depth|
    count_increased += 1 if previous_depth.positive? && depth > previous_depth

    previous_depth = depth
  end

  puts count_increased
end

def count_sliding_windows(depths)
  count_increased = 0
  previous_sum = 0
  start_index = 0

  loop do
    group = depths.slice(start_index, 3)
    break if !group || group.length < 3

    group_sum = group.sum
    count_increased += 1 if previous_sum.positive? && group_sum > previous_sum

    start_index += 1
    previous_sum = group_sum
  end

  puts count_increased
end

depths = File.readlines("input.txt").map(&:to_i)
count_sliding_windows(depths)
