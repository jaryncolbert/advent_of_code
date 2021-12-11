
def sort_chars(value)
  value.split('').sort.join('')
end

def char_arr(string)
  string.split('')
end

def map_digits(digit_values)
  mapped_digits = {}
  num_to_digit_map = {}
  five_seg_nums = []
  six_seg_nums = []

  digit_values.each do |value|
    sorted_value = sort_chars(value)

    case value.length
    when 2
      mapped_digits[sorted_value] = 1
      num_to_digit_map[1] = char_arr(sorted_value)
    when 3
      mapped_digits[sorted_value] = 7
    when 4
      mapped_digits[sorted_value] = 4
      num_to_digit_map[4] = char_arr(sorted_value)
    when 5
      five_seg_nums << sorted_value
    when 6
      six_seg_nums << sorted_value
    when 7
      mapped_digits[sorted_value] = 8
    end
  end

  # The candidates for c, f, b, and d
  c,f = num_to_digit_map[1]
  b,d = num_to_digit_map[4] - num_to_digit_map[1]

  # 0 is the only 6-segment number that doesn't have both the b and d segment
  # 6 is the only 6-segment number that doesn't have both the c and f segment
  # Remaining 6-segment number should be 9
  six_seg_nums.each do |num|
    num_array = char_arr(num)

    if !(num_array.include?(b) && num_array.include?(d))
      mapped_digits[num] = 0
    elsif !(num_array.include?(c) && num_array.include?(f))
      mapped_digits[num] = 6
    else
      mapped_digits[num] = 9
    end
  end

  # 3 is the only 5-segment number that has both the c and f segment
  # 5 is the only 5-segment number that has both the b and d segment
  # Remaining 5-segment number should be 2
  five_seg_nums.each do |num|
    num_array = char_arr(num)

    if num_array.include?(b) && num_array.include?(d)
      mapped_digits[num] = 5
    elsif num_array.include?(c) && num_array.include?(f)
      mapped_digits[num] = 3
    else
      mapped_digits[num] = 2
    end
  end

  mapped_digits
end

def count_unique_digits(lines)
  # unique_lengths = [2, 3, 4, 7]
  # count_unique = 0
  output_sum = 0

  lines.each do |line|
    digit_values, output_values = line.split(' | ')
    mapped_digits = map_digits(digit_values.split(' '))

    output_values.split(' ').each_with_index do |value, index|
      digit = mapped_digits[sort_chars(value)]
      output_sum += digit.to_i * 10**(3 - index)
    end

    # target_counts = output_values.filter { |value| unique_lengths.include?(value.length) }.count
    # count_unique += target_counts
  end

  puts output_sum
end

lines = File.readlines("input.txt").map(&:chomp)
count_unique_digits(lines)
