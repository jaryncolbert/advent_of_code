# frozen_string_literal: true

class BoardNumber
  attr_accessor :row, :col, :number, :called

  def initialize(number, row, col)
    @number = number
    @row = row
    @col = col
    @called = false
  end

  def to_s
    number.to_s
  end
end

class Board
  attr_accessor :winning_number, :winning_index

  def initialize(rows)
    @board_numbers = Hash.new { |h, k| h[k] = [] }
    @called_rows =  Hash.new { |h, k| h[k] = [] }
    @called_cols =  Hash.new { |h, k| h[k] = [] }
    @winning_number = nil
    @winning_index = nil
    init_board(rows)
  end

  def to_s
    winner_message = @winning_number ? "Winner with #{winning_number} at #{winning_index}" : ''
    called_number_str = called_numbers.map(&:to_s)
    uncalled_number_str = uncalled_numbers.map(&:to_s)

    "#{winner_message}\nCalled: #{called_number_str}\nUncalled:  #{uncalled_number_str}"
  end

  def init_board(rows)
    rows.each_with_index do |row, row_index|
      row.split(' ').each_with_index do |number, col_index|
        number = number.chomp.to_i
        @board_numbers[number] = BoardNumber.new(number, row_index, col_index)
      end
    end
  end

  def call_number(number, index)
    # puts "Call #{number} at i #{index}"
    return unless @board_numbers.key?(number)

    board_number = @board_numbers[number]
    board_number.called = true

    @called_rows[board_number.row] << board_number.number
    @called_cols[board_number.col] << board_number.number

    # puts "Called rows #{@called_rows}, called cols #{@called_cols}"
    return unless @called_rows[board_number.row].length == 5 || @called_cols[board_number.col].length == 5

    @winning_number = number
    @winning_index = index
  end

  def sum_uncalled_numbers
    uncalled_numbers.sum(&:number)
  end

  private

  def called_numbers
    @board_numbers.values.select(&:called)
  end

  def uncalled_numbers
    @board_numbers.values.reject(&:called)
  end
end

def call_boards_and_return_winners(lines)
  called_numbers = lines.slice!(0).split(',')
  winning_boards = []

  lines.each_slice(6) do |board_lines|
    board_lines.slice!(0) # Skip empty first line
    board = Board.new(board_lines)

    called_numbers.each_with_index do |number, call_index|
      board.call_number(number.to_i, call_index)

      unless board.winning_number.nil?
        winning_boards << board
        break
      end
    end
  end

  winning_boards
end

def find_winning_board(winning_boards)
  winning_board = winning_boards.min_by(&:winning_index)
  uncalled_numbers_sum = winning_board.sum_uncalled_numbers
  winning_number = winning_board.winning_number
  result = winning_number * uncalled_numbers_sum
  puts "Winning Num: #{winning_number}, Board Sum: #{uncalled_numbers_sum}, Mult: #{result}"

  result
end

def play_bingo
  lines = File.readlines("input.txt").map(&:chomp)
  winning_boards = call_boards_and_return_winners(lines)
  find_winning_board(winning_boards)
end

play_bingo

# 35217 too high
