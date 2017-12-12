def run(l, m, i = 0, skip = 0)
  return l if m.empty?
  len = m.first
  run(reverse(l, i, len), m.drop(1), (i + len + skip) % 256, skip + 1)
end

def reverse(list, i, len)
  shifted = list.cycle.lazy.drop(i).take(list.length).to_a
  reversed = shifted.take(len).reverse + shifted.drop(len)
  reversed.cycle.lazy.drop(list.length - i).take(list.length).to_a
end

INPUT = [147, 37, 249, 1, 31, 2, 226, 0, 161, 71, 254, 243, 183, 255, 30, 70].freeze

if __FILE__ == $PROGRAM_NAME
  p run(0.upto(255).to_a, INPUT).take(2).reduce(:*)
end
