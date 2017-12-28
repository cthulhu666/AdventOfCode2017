N = 394
MAX = 2017

def part1(n)
  pos = 0
  buf = 1.upto(MAX).reduce([0]) do |a, i|
    pos = (pos + n) % a.length + 1
    a.insert(pos, i)
    a
  end
  i = buf.index(MAX)
  buf[i + 1]
end

if __FILE__ == $PROGRAM_NAME
  p part1(N)
end
