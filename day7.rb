Prog = Struct.new(:name, :weight, :others)

def load_data
  File.new('day7.txt').readlines.map(&:strip).map(&method(:parse_line))
end

def parse_line(s)
  a, b = *s.split('->')
  name, weight = *a.scan(/^([a-z]+)\s\((\d+)\)/).flatten
  others = b&.split(',')&.map(&:strip)
  Prog.new(name, weight.to_i, others)
end

def find_most_bottom(arr)
  a = arr.reduce([]) { |a, e| a << e.others }.flatten.compact.uniq
  arr.reject { |e| a.include?(e.name) }
end

def build_inventory(data)
  data.map { |e| [e.name, e] }.to_h
end

Node = Struct.new(:value, :parent, :children)

def build_tree(val, parent, inventory)
  if val.others.nil?
    return Node.new(val, parent)
  end
  children = val.others.map { |e| inventory[e] }.map { |e| build_tree(e, nil, inventory) }
  Node.new(val, parent, children).tap do |n|
    n.children.each { |c| c.parent = n }
  end
end

def tree_weight(node)
  return node.value.weight if is_leaf?(node)
  node.children.reduce(node.value.weight) { |a, e| a + tree_weight(e) }
end

def is_leaf?(node)
  node.children.nil?
end

# TODO: cache sub-tree weights
def walk_tree(node)
  return if is_leaf?(node)
  sorted_weights = node.children.map { |e| [e, tree_weight(e)] }.sort_by(&:last)
  if sorted_weights.map(&:last).uniq.length == 1
    # oops, I'm the fat boy
    return node
  end
  return walk_tree(sorted_weights.last.first)
end

data = load_data
root = find_most_bottom(data)
fail 'Boohoo' if root.length != 1
puts "Part I answer is: #{root.first.name}"

tree_root = build_tree(root.first, nil, build_inventory(data))

# puts "Weight of the entire tower is: #{tree_weight(tree_root)}"

fatty_boy = walk_tree(tree_root)
puts "#{fatty_boy.value.name} is a fatty boy"

weights = fatty_boy.parent.children.map { |e| tree_weight(e) }
diff = weights.max - weights.min

puts "Part II answer is: #{fatty_boy.value.weight - diff}"
