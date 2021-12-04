# frozen_string_literal: true

def bingo

end

lines = File.readlines("test.txt").map(&:chomp)
bingo(lines)
