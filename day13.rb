def parse_line(s)
  s.split(':').map(&:strip).map(&:to_i)
end

def walk(h)
  f = init_firewall(h)
  0.upto(h.keys.last).reduce(0) do |a, i|
    a + severity(f, i)
  end
end

def severity(f, i)
  positions = scanner_positions(f, i)
  return 0 unless caught?(positions, i)
  i * (f[i].max + 1)
end

def caught?(p, i)
  p[i] == 0
end

def cycle(depth)
  up = 0.upto(depth - 1).to_a
  down = up.drop(1).reverse.drop(1)
  up.concat(down)
end

def safe?(f, delay)
  0.upto(f.keys.last).detect { |i| scanner_position(f, i, delay) == 0 }.nil?
end

def scanner_position(f, i, delay)
  v = f[i]
  return -1 if v.nil?
  v[(i + delay) % v.length]
end

def init_firewall(depths)
  depths.map { |k, v| [k, cycle(v)] }.to_h
end

def scanner_positions(f, i)
  f.map { |k, v| [k, v[i % v.length]] }.to_h
end

def part1(depths)
  walk(depths)
end

def part2(depths)
  f = init_firewall(depths)
  0.upto(Float::INFINITY).detect do |i|
    safe?(f, i)
  end
end

if __FILE__ == $PROGRAM_NAME
  depths = File.readlines('day13.txt').map(&:strip).map(&method(:parse_line)).to_h
  p part1(depths)
  p part2(depths)
end
