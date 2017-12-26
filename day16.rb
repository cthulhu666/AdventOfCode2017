def part1(arr, moves)
  moves.reduce(arr) { |a, f| f.call(a) }
end

def parse(s)
  case s[0]
    when 's'
      n = s.scan(/\d+/).first.to_i
      method(:spin).curry.call(n)
    when 'x'
      i1, i2 = s[1..-1].split('/').map(&:to_i)
      method(:exchange).curry.call(i1, i2)
    when 'p'
      p1, p2 = s[1..-1].split('/')
      method(:partner).curry.call(p1, p2)
  end
end

def spin(n, a)
  a.last(n) + a.first(a.length - n)
end

def exchange(p1, p2, arr)
  arr.dup.tap do |a|
    a[p1], a[p2] = a[p2], a[p1]
  end
end

def partner(p1, p2, a)
  i1, i2 = a.index(p1), a.index(p2)
  exchange(i1, i2, a)
end

if __FILE__ == $PROGRAM_NAME
  moves = File.read('day16.txt').split(',').map(&method(:parse))
  a = 'a'..'p'
  p part1(a.to_a.freeze, moves).join
end
