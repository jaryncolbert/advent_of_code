
def get_top(x_index, lines)
  lines[0][x_index]
end

def get_bottom(x_index, lines)
  lines[2][x_index]
end

def get_left(x_index, lines)
  x_index == 0 ? 9 : lines[1][x_index - 1]
end

def get_right(x_index, lines)
  x_index == lines.length - 1 ? 9 : lines[1][x_index + 1]
end

def get_value(x_index, lines)
  lines[1][x_index]
end

def min_among_neighbors(x_index, lines)
  value = get_value(x_index, lines).to_i
  return value if value == 0
  return -1 if value == 9

  top, bottom = get_top(x_index, lines).to_i, get_bottom(x_index, lines).to_i
  left, right = get_left(x_index, lines).to_i, get_right(x_index, lines).to_i

  value < top && value < bottom && value < left && value < right ? value : -1
end

def height_map(lines)
  low_points = []
  min_count = 0

  # Add "blank" line of 9s as first line so we can always run compare fns on second input line
  max_x = lines[0].length
  blank_line = [Array.new(max_x, 9)]
  lines = blank_line + lines

  start_index = 0
  loop do
    group = lines.slice(start_index, 3)
    break if !group || group.empty?

    # Add "blank" line of 9s as last lines so we can always run compare fns on second input line
    if group.length == 2
      group += blank_line
    elsif group.length == 1
      group += blank_line + blank_line
    end

    (0..max_x - 1).each do |x_index|
      height_if_min = min_among_neighbors(x_index, group)

      if height_if_min >= 0
        low_points << height_if_min + 1
        min_count += height_if_min + 1
      end
    end

    start_index += 1
  end

  p low_points
  puts min_count
end

lines = File.readlines("test.txt").map(&:chomp).map { |line| line.split('') }
height_map(lines.take(5))

# 522 too high