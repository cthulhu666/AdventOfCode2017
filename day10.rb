def run(l, m, i = 0, skip = 0)
  return [l, i, skip] if m.empty?
  len = m.first
  run(reverse(l, i, len), m.drop(1), (i + len + skip) % 256, skip + 1)
end

def reverse(list, i, len)
  shifted = list.cycle.lazy.drop(i).take(list.length).to_a
  reversed = shifted.take(len).reverse + shifted.drop(len)
  reversed.cycle.lazy.drop(list.length - i).take(list.length).to_a
end

INPUT = "147,37,249,1,31,2,226,0,161,71,254,243,183,255,30,70".freeze

SUFFIX = [17, 31, 73, 47, 23].freeze

def part1(input)
  run(0.upto(255).to_a, input).first.take(2).reduce(:*)
end

def part2(input)
  i, skip = 0, 0
  l = 0.upto(255).to_a
  64.times do
    l, i, skip = run(l, input.dup, i, skip)
  end
  dense = l.each_slice(16).map do |e|
    e.reduce(:^)
  end
  dense.map { |e| format('%.2x', e) }.join
end

if __FILE__ == $PROGRAM_NAME
  p part1(INPUT.split(',').map(&:to_i))
  p part2(INPUT.bytes + SUFFIX)
end
