N = 361_527

DIRS = [[1, 0], [0, 1], [-1, 0], [0, -1]].freeze

ALL_DIRS = DIRS + [
  [1, 1],
  [-1, -1],
  [1, -1],
  [-1, 1]
].freeze

# we go like this: R U  LL DD  RRR UUU  LLLL DDDD  ...
def gen
  DIRS.cycle.each_with_index.lazy.flat_map do |dir, i|
    n = (i / 2) + 1
    [dir] * n
  end
end

the_map = Hash.new { 0 }
the_map[[0, 0]] = 1

current = [1, 0]

solution = gen.drop(1).first(100).each do |e|
  sum = ALL_DIRS.reduce(0) do |a, dir|
    xy = [current.first + dir.first, current.last + dir.last]
    a + the_map[xy]
  end
  the_map[current] = sum
  current = [current.first + e.first, current.last + e.last]
  break sum if sum > N
end

puts solution
