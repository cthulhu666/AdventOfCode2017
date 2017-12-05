def checksum(rows, f)
  rows.reduce(0, &f)
end

def row_diff(sum, row)
  sorted = row.sort
  sum + (sorted[0] - sorted[-1]).abs
end

def evenly_divisible(sum, row)
  pair = row.permutation(2).find { |arr| arr.first % arr.last == 0 }.sort
  sum + pair.last / pair.first
end

data = File.new('day2.txt').readlines.map { |s| s.split(' ').map(&:strip).map(&:to_i) }

puts checksum(data, method(:row_diff))
puts checksum(data, method(:evenly_divisible))
