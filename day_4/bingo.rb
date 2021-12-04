# frozen_string_literal: true

class BoardNumber
  attr_accessor :row, :col, :number, :called

  def initialize(number, row, col)
    @number = number
    @row = row
    @col = col
    @called = false
  end
end

class Board
  attr_accessor :winning_number, :winning_index

  def initialize(rows)
    @board_numbers = {}
    @called_rows = {}
    @called_cols = {}
    @winning_number = nil
    @winning_index = nil
    init_board(rows)
  end

  def init_board(rows)
    rows.each_with_index do |row, row_index|
      row.split(/ +/).each_with_index do |number, col_index|
        number = number.chomp.to_i
        @board_numbers[number] = BoardNumber.new(number, row_index, col_index)
      end
    end
  end

  def call_number(number, index)
    # puts "Call #{number} at i #{index}"
    board_number = @board_numbers[number]
    board_number.called = true

    @called_rows[board_number.row] = [] if @called_rows[board_number.row].nil?
    @called_cols[board_number.col] = [] if @called_cols[board_number.col].nil?
    @called_rows[board_number.row] << board_number.number
    @called_cols[board_number.col] << board_number.number

    # puts "Called rows #{@called_rows}, called cols #{@called_cols}"
    @winning_number = number if @called_rows[board_number.row].length == 5 || @called_cols[board_number.col].length == 5
    @winning_index = index
  end

  def sum_uncalled_nums
    @board_numbers.values.reject(&:called).sum(&:number)
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

      if board.winning_number
        winning_boards << board
        break
      end
    end
  end

  winning_boards
end

def find_winning_board(winning_boards)
  winning_board = winning_boards.min_by(&:winning_index)
  uncalled_numbers_sum = winning_board.sum_uncalled_nums
  winning_number = winning_board.winning_number
  result = winning_number * uncalled_numbers_sum
  puts "Winning Num: #{winning_number}, Board Sum: #{uncalled_numbers_sum}, Mult: #{result}"

  result
end

def play_bingo
  lines = File.readlines("test.txt").map(&:chomp)
  winning_boards = call_boards_and_return_winners(lines)
  find_winning_board(winning_boards)
end

play_bingo
