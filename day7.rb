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

p find_most_bottom(load_data)
