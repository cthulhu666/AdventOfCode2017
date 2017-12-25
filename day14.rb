INPUT = 'nbysizxe'.freeze
# INPUT = 'flqrgnkx'.freeze

# taken from day 10
module KnotHash
  SUFFIX = [17, 31, 73, 47, 23].freeze

  def self.calculate(input)
    i = 0
    skip = 0
    l = 0.upto(255).to_a
    64.times do
      l, i, skip = run(l, input + SUFFIX, i, skip)
    end
    dense = l.each_slice(16).map do |e|
      e.reduce(:^)
    end
    dense.map { |e| format('%.2x', e) }.join
  end

  private

  def self.run(l, m, i = 0, skip = 0)
    return [l, i, skip] if m.empty?
    len = m.first
    run(reverse(l, i, len), m.drop(1), (i + len + skip) % 256, skip + 1)
  end

  def self.reverse(list, i, len)
    shifted = list.cycle.lazy.drop(i).take(list.length).to_a
    reversed = shifted.take(len).reverse + shifted.drop(len)
    reversed.cycle.lazy.drop(list.length - i).take(list.length).to_a
  end
end

def part1(input)
  0.upto(127).map { |e| [input, '-', e].join }
   .map { |e| KnotHash.calculate(e.bytes) }
   .map { |e| format('%.4b', e.hex) }.join.count("1")
end

if __FILE__ == $PROGRAM_NAME
  p part1(INPUT)
end
