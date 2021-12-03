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

binary_lines = File.readlines("test.txt").map(&:chomp)
consumption(binary_lines)

