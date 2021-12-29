
def bracket_matches?(open_bracket, close_bracket)
  get_matching_bracket(open_bracket) == close_bracket
end

def get_matching_bracket(open_bracket)
  case open_bracket
  when '<'
    '>'
  when '('
    ')'
  when '{'
    '}'
  when '['
    ']'
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

def get_completion_scores(rem_open_brackets)
  score_map = {
    ")": 1,
    "]": 2,
    "}": 3,
    ">": 4
  }

  close_brackets = rem_open_brackets.map{ |open_bracket| get_matching_bracket(open_bracket) }

  score = 0
  close_brackets.each do |bracket|
    score = score * 5 + score_map[:"#{bracket}"]
  end

  score
end

def balance_brackets(lines)
  invalid_chars = []
  completion_chars = []

  open_brackets = '([{<'.split('')

  lines.each do |line_chars|
    queue = []
    invalid_sequence = false

    line_chars.each do |char|
      if open_brackets.include?(char)
        queue.push(char)
      elsif !bracket_matches?(queue.pop, char)
        invalid_chars << char
        invalid_sequence = true
        break
      end
    end

    if !invalid_sequence && !queue.empty?
      completion_chars << queue.reverse
      # puts "Completion chars #{completion_chars}"
    end
  end

  completion_scores = completion_chars.map { |completion| get_completion_scores(completion) }
  p completion_scores.sort!
  median_score = completion_scores[completion_scores.count / 2]
  puts "Median #{median_score}"
  # p invalid_chars
  # puts find_score(invalid_chars)
end

lines = File.readlines("input.txt").map { |line| line.chomp.split('') }
balance_brackets(lines)
