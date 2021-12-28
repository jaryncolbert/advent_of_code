require 'set'

class Node
  attr_accessor :value, :neighbors

  def initialize(value)
    @value = value
    @neighbors = Set.new([])
  end

  def add_neighbor(node)
    @neighbors.add(node)
  end

  def inspect
    "#{@value}->[#{@neighbors.map(&:value).join(',')}]"
  end
end



def build_graph(lines)
  graph_nodes = {}

  lines.each do |line|
    first_value, second_value = line.split('-')

    graph_nodes[first_value] = Node.new(first_value) if graph_nodes[first_value].nil?
    graph_nodes[second_value] = Node.new(second_value) if graph_nodes[second_value].nil?

    first_node = graph_nodes[first_value]
    second_node = graph_nodes[second_value]

    first_node.add_neighbor(second_node)
    second_node.add_neighbor(first_node)
  end

  graph_nodes['start']
end

def is_uppercase?(value)
  value.upcase == value
end

def traverse_graph(start_node, visited_nodes)
  # puts "Traverse #{start_node.value}, Visited #{visited_nodes}"
  # puts "Returning 'end'" if start_node.value == 'end'
  if start_node.value == 'end'
    p visited_nodes + [start_node.value]
    return
  end

  neighbors = start_node.neighbors
  unvisited_neighbors = neighbors.select do |node|
    is_uppercase?(node.value) || !visited_nodes.include?(node.value)
  end
  # puts "Unvisited #{unvisited_neighbors}"
  return if unvisited_neighbors.empty?
  
  unvisited_neighbors.each do |node|
    # puts "Traverse #{node.value} from #{start_node.value}"
    traverse_graph(node, visited_nodes + [start_node.value])
  end
end

def find_possible_paths(lines)
  start_node = build_graph(lines)
  traverse_graph(start_node, [])
end


lines = File.readlines("test_1.txt").map(&:chomp)
find_possible_paths(lines)
