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

def life_support_rating(binary_lines)
  bit_hash = {}

  binary_lines.each do |line|
    line.split('').each_with_index do |char, index|
      if bit_hash[index].nil?
        bit_hash[index] = [
          { value: 0, count: 0, binary_nums: [] },
          { value: 1, count: 0, binary_nums: [] }
        ]
      end

      if char == '0'
        bit_hash[index][0][:count] += 1
        bit_hash[index][0][:binary_nums] << line
      else
        bit_hash[index][1][:count] += 1
        bit_hash[index][1][:binary_nums] << line
      end
    end
  end

  curr_index = 0
  loop do
    relevant_values = bit_hash[curr_index].map do |index0, index1|
      index0[:count] > index1[:count] ? index0[:binary_nums] : index1[:binary_nums]
    end.flatten

    break if relevant_values.length == 1

    curr_index += 1
  end


  # puts "Bit String: #{bit_string}, Bin: #{gamma}, inverse: #{epsilon}, Consumption: #{gamma * epsilon}"
  puts "Bit Hash: #{bit_hash}"
end

def ones_complement(input_string)
  input_string.to_i(2) ^ ((1 << input_string.length) - 1)
end

binary_lines = File.readlines("test.txt").map(&:chomp)
#consumption(binary_lines)
life_support_rating(binary_lines)

