
def min_position_diff(lines)
  move_costs = Hash.new { |h, k| h[k] = {} }
  total_costs = {}
  move_sequence_sums = {}

  positions = lines.first.split(',').map(&:to_i).sort
  positions.each do |position|
    total_position_cost = 0

    other_positions = positions.reject { |other_position| other_position == position }
    other_positions.each do |other_position|

      unless move_costs[position][other_position]
        num_steps = (position - other_position).abs

        move_sequence_sums[num_steps] = (1..num_steps).sum unless move_sequence_sums[num_steps]
        num_steps_cost = move_sequence_sums[num_steps]

        move_costs[position][other_position] = num_steps_cost
      end

      stored_cost = move_costs[position][other_position]
      total_position_cost += stored_cost
    end

    total_costs[position] = total_position_cost
  end

  puts total_costs.values.min
end

lines = File.readlines("input.txt").map(&:chomp)
min_position_diff(lines)
