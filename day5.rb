# NOTE: run with `RUBY_THREAD_VM_STACK_SIZE=50000000`

def walk(data, pos, count)
  offset = data[pos]
  return count if pos + offset >= data.size
  walk(inc(data, pos), pos + offset, count + 1)
end

def inc(data, pos)
  data.tap do |d|
    d[pos] += 1
  end
end


data = File.new("day5.txt").readlines().map(&:strip).map(&:to_i)

puts walk(data, 0, 1)
