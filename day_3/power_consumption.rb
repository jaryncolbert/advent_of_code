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

def oxygen_generator(binary_lines)
  curr_index = 0
  filtered_lines = binary_lines

  loop do
    one_bit_nums = []
    zero_bit_nums = []

    filtered_lines.each do |line|
      curr_char = line[curr_index]
      curr_char == '0' ? zero_bit_nums << line : one_bit_nums << line
    end

    relevant_nums = one_bit_nums.length >= zero_bit_nums.length ? one_bit_nums : zero_bit_nums

    return relevant_nums.first if relevant_nums.length == 1

    filtered_lines = relevant_nums
    curr_index += 1
  end
end

binary_lines = File.readlines("input.txt").map(&:chomp)
#consumption(binary_lines)
oxygen_generator = life_support_rating(binary_lines)
co2_scrubber = ones_complement(oxygen_generator)
puts "Oxygen: #{oxygen_generator}, CO2: #{"100001111000"}"
puts "Oxygen: #{oxygen_generator.to_i(2)}, CO2: #{"100001111000".to_i(2)}, Multiplied: #{oxygen_generator.to_i(2) * co2_scrubber}"

