
def bracket_matches?(open_bracket, close_bracket)
  case open_bracket
  when '<'
    close_bracket == '>'
  when '('
    close_bracket == ')'
  when '{'
    close_bracket == '}'
  when '['
    close_bracket == ']'
  end
end

def find_score(invalid_chars)
  score_map = {
    ")": 3,
    "]": 57,
    "}": 1197,
    ">": 25137
  }

  invalid_chars.sum do |char|
    score_map[:"#{char}"]
  end
end

def balance_brackets(lines)
  queue = []
  invalid_chars = []

  open_brackets = '([{<'.split('')

  lines.each do |line_chars|
    line_chars.each do |char|
      if open_brackets.include?(char)
        queue.push(char)
      elsif !bracket_matches?(queue.pop, char)
        invalid_chars << char
        break
      end
    end
  end

  p invalid_chars
  puts find_score(invalid_chars)
end

lines = File.readlines("input.txt").map { |line| line.chomp.split('') }
balance_brackets(lines)
