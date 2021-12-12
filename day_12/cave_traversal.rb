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

  p graph_nodes.values
  graph_nodes['start']
end

def is_uppercase?(value)
  value.upcase == value
end

def traverse_graph(start_node, visited_nodes)
  return visited_nodes if start_node.value == 'end'

  neighbors = start_node.neighbors
  unvisited_neighbors = neighbors.select do |node|
    is_uppercase?(node.value) || !visited_nodes.include?(node.value)
  end
  return unvisited_neighbors if unvisited_neighbors.empty?

  unvisited_neighbors.map do |node|
    traverse_graph(node, visited_nodes << start_node)
  end

end

def find_possible_paths(lines)
  start_node = build_graph(lines)
  #p traverse_graph(start_node, [])
end


lines = File.readlines("test_1.txt").map(&:chomp)
find_possible_paths(lines)
