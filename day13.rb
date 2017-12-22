State = Struct.new(:scanner_positions, :my_position) do
  def caught?
    scanner_positions.fetch(my_position, nil)&.peek == 0
  end
end

def parse_line(s)
  s.split(':').map(&:strip).map(&:to_i)
end

def walk(h, state)
  0.upto(h.keys.last).reduce(0) do |a, _i|
    a += severity(h, state)
    step!(state)
    a
  end
end

def severity(h, state)
  return 0 unless state.caught?
  h[state.my_position] * state.my_position
end

def step!(state)
  state.scanner_positions.values.each(&:next)
  state.my_position += 1
end

def new_state(h)
  State.new(h.map { |k, v| [k, cycle(v)] }.to_h, 0)
end

def cycle(depth)
  up = 0.upto(depth - 1).to_a
  down = up.drop(1).reverse.drop(1)
  up.concat(down).cycle
end

if __FILE__ == $PROGRAM_NAME
  depths = File.readlines('day13.txt').map(&:strip).map(&method(:parse_line)).to_h
  p walk(depths, new_state(depths))
end
