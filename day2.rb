def checksum(rows)
  rows.reduce(0, &method(:row_diff))
end

def row_diff(sum, row)
  sorted = row.sort
  sum + (sorted[0] - sorted[-1]).abs
end

data = File.new("day2.txt").readlines().map { |s| s.split(" ").map(&:strip).map(&:to_i) }
puts checksum(data)
