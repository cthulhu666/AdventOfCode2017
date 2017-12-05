# NOTE: run with `RUBY_THREAD_VM_STACK_SIZE=5000000000`

def walk(data, pos, count)
  offset = data[pos]
  return count if pos + offset >= data.size
  walk(inc(data, pos, offset), pos + offset, count + 1)
end

def inc(data, pos, offset)
  data.tap do |d|
    offset >= 3 ? d[pos] -= 1 : d[pos] += 1
  end
end


data = File.new("day5.txt").readlines().map(&:strip).map(&:to_i)

# data = [0, 3, 0, 1, -3]
puts walk(data, 0, 1)
