require 'set'

A = ('a'..'p').to_a.freeze
N = 1_000_000_000

def part1(arr, moves)
  dance(arr, moves).join
end

def part2(arr, moves)
  n, a = detect_cycle(arr, moves)
  a[N % n - 1].join
end

def detect_cycle(arr, moves)
  s = Set.new
  cache = []
  n = 0
  loop do
    arr = dance(arr, moves)
    return n, cache unless s.add?(arr)
    cache[n] = arr
    n += 1
  end
end

def dance(arr, moves)
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
  i1 = a.index(p1)
  i2 = a.index(p2)
  exchange(i1, i2, a)
end

if __FILE__ == $PROGRAM_NAME
  moves = File.read('day16.txt').split(',').map(&method(:parse))
  p part1(A, moves)
  p part2(A, moves)
end
