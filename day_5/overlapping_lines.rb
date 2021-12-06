# frozen_string_literal: true

class Coordinate
  attr_accessor :x, :y, :num_overlapping

  def initialize(x, y)
    @x = x
    @y = y
    @num_overlapping = 0
  end

  def to_s
    "(#{@x}, #{y})[#{@num_overlapping}]"
  end
end

def increment_overlap_counter(x_value, y_value, rows)
  # puts "X: #{x_value}, Y: #{y_value}"
  rows[x_value][y_value] = Coordinate.new(x_value, y_value) if rows[x_value][y_value].nil?

  # puts "Lookup coord: #{rows[x_value][y_value]}"
  rows[x_value][y_value].num_overlapping += 1
end

def count_overlapping(rows)
  coordinate_array = rows.values.map(&:values).flatten
  num_overlapping = coordinate_array.count do |coordinate|
    coordinate.num_overlapping >= 2
  end

  puts "Overlapping: #{num_overlapping}"
end

def find_overlapping_lines(lines)
  rows = Hash.new { |h, k| h[k] = {} }

  lines.each do |line|
    x1, y1, x2, y2 = line.split(' -> ').map { |coord| coord.split(',') }.flatten.map(&:to_i)

    # puts "Line: #{line}, Coord1 (#{x1}, #{y1}), Coord2 (#{x2}, #{y2})"
    if x1 == x2
      min_y, max_y = [y1, y2].minmax
      (min_y..max_y).to_a.each do |y_value|
        increment_overlap_counter(x1, y_value, rows)
      end

    elsif y1 == y2
      min_x, max_x = [x1, x2].minmax
      (min_x..max_x).to_a.each do |x_value|
        increment_overlap_counter(x_value, y1, rows)
      end

    else
      # puts "Line: #{line}, Coord1 (#{x1}, #{y1}), Coord2 (#{x2}, #{y2})"
      min_coord_by_x, max_coord_by_x = x1 < x2 ? [[x1, y1], [x2, y2]] : [[x2, y2], [x1, y1]]
      min_y, max_y = [y1, y2].minmax
      # puts "min_coord_by_x #{min_coord_by_x}, max_coord_by_x #{max_coord_by_x}"
      y_range = (min_y..max_y).to_a
      y_range.reverse! if min_coord_by_x[1] > max_coord_by_x[1]

      # puts "X Range: (#{(min_coord_by_x[0]..max_coord_by_x[0]).to_a}), Y Range: (#{y_range})"
      (min_coord_by_x[0]..max_coord_by_x[0]).to_a.each_with_index do |x_value, index|
        increment_overlap_counter(x_value, y_range[index], rows)
      end
    end
  end

  count_overlapping(rows)
end

lines = File.readlines("input.txt").map(&:chomp)
find_overlapping_lines(lines)

