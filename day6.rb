# NOTE: run with `RUBY_THREAD_VM_STACK_SIZE=5000000000`

BANKS = "14	0	15 12	11 11	3	5	1	6	8	4	9	1	8	4".split.map(&:to_i).freeze

def redistribute(banks, count, history)
  return count if history.include?(banks)
  n, idx = most_blocks(banks)
  redistribute(move(banks.dup, n, idx), count + 1, history + [banks])
end

def move(banks, n, idx)
  from = idx
  to = idx
  n.times do
    to = next_idx(banks.length, to)
    banks[from] -= 1
    banks[to] += 1
  end
  banks
end

def most_blocks(banks)
  banks.each_with_index.sort_by(&method(:comparator)).last
end

def comparator(pair)
  pair.first + 1.0 / (pair.last + 1.0)
end

def next_idx(len, idx)
  return idx + 1 if idx + 1 < len
  return 0
end

puts redistribute(BANKS, 0, [])
