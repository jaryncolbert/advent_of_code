# frozen_string_literal: true

def parse_commands(commands)
  depth = 0
  horizontal_position = 0
  aim = 0

  commands.each do |command|
    direction, amount = command.split(' ')
    amount = amount.to_i

    case direction
    when 'forward'
      horizontal_position += amount
      depth += amount * aim
    when 'up'
      aim -= amount
    when 'down'
      aim += amount
    end
  end

  puts "Horiz: #{horizontal_position}, Depth: #{depth}, Multi: #{horizontal_position * depth}"
end

commands = File.readlines("input.txt")
parse_commands(commands)
