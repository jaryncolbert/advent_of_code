def min_position_diff(lines)
  move_costs = Hash.new { |h, k| h[k] = {} }
  total_costs = {}

  positions = lines.first.split(',').map(&:to_i).sort
  positions.each do |position|
    total_position_cost = 0

    other_positions = positions.reject { |other_position| other_position == position }
    other_positions.each do |other_position|
      stored_cost = move_costs[position][other_position]
      cost = stored_cost || (position - other_position).abs
      total_position_cost += cost

      move_costs[position][other_position] = cost unless stored_cost
    end

    total_costs[position] = total_position_cost
  end

  puts total_costs.values.min
end

lines = File.readlines("input.txt").map(&:chomp)
min_position_diff(lines)
