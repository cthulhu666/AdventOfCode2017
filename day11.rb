# https://www.redblobgames.com/grids/hexagons/#coordinates-axial
DIRS = {
    'n' => [0, -1],
    'ne' => [1, -1],
    'se' => [1, 0],
    's' => [0, 1],
    'sw' => [-1, 1],
    'nw' => [-1, 0]
}

def to_coords
  ->(s) { DIRS.fetch(s) }
end

def add
  ->(a, b) { [a.first + b.first, a.last + b.last] }
end

def add2
  ->(a, b) { a << [a.last.first + b.first, a.last.last + b.last] }
end

def part1(path)
  path.reduce([0, 0], &add).max
end

def part2(path)
  path.reduce([[0, 0]], &add2).sort_by(&:max).last.max
end

if __FILE__ == $PROGRAM_NAME
  path = File.read('day11.txt').strip.split(',').map(&to_coords)
  p part1(path)
  p part2(path)
end
