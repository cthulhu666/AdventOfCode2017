require 'set'

def parse_line(line)
  a, b = *line.split('<->').map(&:strip)
  [a, b.split(',').map(&:strip)]
end

def create_map(data)
  data.to_h
end

def connections(map, key, visited = Set.new)
  direct_connections = Set.new(map.fetch(key))
  to_visit = direct_connections - visited
  return visited + direct_connections if to_visit.empty?
  visited + direct_connections + to_visit.reduce(Set.new) { |a, e| a + connections(map, e, visited + [e])}
end

def part1(m)
  connections(m, '0').size
end

def part2(m)
  all = m.keys.map do |k|
    connections(m, k).sort
  end
  all.uniq.size
end

if __FILE__ == $PROGRAM_NAME
  data = File.readlines('day12.txt').map(&:strip).map(&method(:parse_line))
  p part1(create_map(data))
  p part2(create_map(data))
end
