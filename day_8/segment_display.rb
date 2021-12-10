

def count_unique_digits(lines)
  count_unique = 0
  unique_lengths = [2, 3, 4, 7]

  lines.each do |line|
    output_values = line.split(' | ')[1].split(' ')
    target_counts = output_values.filter { |value| unique_lengths.include?(value.length) }.count
    count_unique += target_counts
  end

  puts count_unique
end

lines = File.readlines("input.txt").map(&:chomp)
count_unique_digits(lines)
