# frozen_string_literal: true

def consumption(binary_lines)

  bit_hash = {}

  binary_lines.each do |line|
    line.split('').each_with_index do |char, index|
      bit_hash[index] = [0, 0] if bit_hash[index].nil?

      if char == '0'
        bit_hash[index][0] += 1
      else
        bit_hash[index][1] += 1
      end
    end
  end

  bit_string = bit_hash.values.map do |index0, index1|
    index0 > index1 ? '0' : '1'
  end.join('')

  gamma = bit_string.to_i(2)
  epsilon = ones_complement(bit_string)

  puts "Bit String: #{bit_string}, Bin: #{gamma}, inverse: #{epsilon}, Consumption: #{gamma * epsilon}"
end

def ones_complement(input_string)
  input_string.to_i(2) ^ ((1 << input_string.length) - 1)
end

def process_binary_nums(binary_lines, keep_largest: true)
  curr_index = 0
  filtered_nums = binary_lines

  loop do
    one_bit_nums = []
    zero_bit_nums = []

    filtered_nums.each do |line|
      curr_char = line[curr_index]
      curr_char == '0' ? zero_bit_nums << line : one_bit_nums << line
    end

    relevant_nums = if (keep_largest && one_bit_nums.length >= zero_bit_nums.length) ||
                       (!keep_largest && one_bit_nums.length < zero_bit_nums.length)
                      one_bit_nums
                    else
                      zero_bit_nums
                    end

    return relevant_nums.first if relevant_nums.length == 1

    filtered_nums = relevant_nums
    curr_index += 1
  end
end

binary_lines = File.readlines("input.txt").map(&:chomp)
#consumption(binary_lines)
oxygen_generator = process_binary_nums(binary_lines)
co2_scrubber = process_binary_nums(binary_lines, keep_largest: false)
puts "Oxygen Bin: #{oxygen_generator}, CO2 Bin: #{co2_scrubber}"

oxygen_generator_dec = oxygen_generator.to_i(2)
co2_scrubber_dec = co2_scrubber.to_i(2)
puts "Oxygen Dec: #{oxygen_generator_dec}, CO2 Dec: #{co2_scrubber_dec}, Multiplied: #{oxygen_generator_dec * co2_scrubber_dec}"

