class LanternFish
  attr_accessor :timer, :children

  def initialize(timer)
    @timer = timer
  end

  def simulate_day
    spawn_child = false

    if @timer.positive?
      @timer -= 1
    else
      @timer = 6
      spawn_child = true
    end

    spawn_child
  end

  def to_s
    @timer.to_s
  end
end

def initialize_pool(fish_timers)
  fish_timers.map { |fish_timer| LanternFish.new(fish_timer) }
end

def simulate_fish(lines, num_days) # lol... this is crazy slow for part 2
  return if lines.count > 1

  fish_input = lines[0].split(',').map(&:to_i)
  fish_pool = initialize_pool(fish_input)

  num_days.times do
    new_fish = []

    fish_pool.each do |fish|
      spawn = fish.simulate_day
      new_fish << LanternFish.new(8) if spawn
    end

    fish_pool.concat(new_fish)
  end

  # puts fish_pool.join(', ')
  puts fish_pool.length
end

def initialize_fish_counts(fish_timers)
  fish_timer_counts = Array.new(9, 0)

  fish_timers.each do |timer|
    fish_timer_counts[timer] += 1
  end

  fish_timer_counts
end

def track_fish_counts(lines, num_days)
  return if lines.count > 1

  fish_input = lines[0].split(',').map(&:to_i)
  fish_timer_counts = initialize_fish_counts(fish_input)

  num_days.times do
    # puts "Counts: #{fish_timer_counts}"
    spawn_count = fish_timer_counts[0]
    # puts "Spawned #{spawn_count}"
    fish_timer_counts.rotate!(1)

    fish_timer_counts[6] += spawn_count
    fish_timer_counts[8] = spawn_count.positive? ? spawn_count : 0

    # puts "After rotation & spawn: #{fish_timer_counts}"
  end

  puts fish_timer_counts.sum
end

lines = File.readlines("input.txt").map(&:chomp)

track_fish_counts(lines, 256)
