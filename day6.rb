# NOTE: run with `RUBY_THREAD_VM_STACK_SIZE=5000000000`

BANKS = "14\t0\t15\t12\t11\t11\t3\t5\t1\t6\t8\t4\t9\t1\t8\t4".split.map(&:to_i).freeze

def redistribute(banks, count, history)
  return count if history.include?(banks)
  n, idx = most_blocks(banks)
  redistribute(move(banks.dup, n, idx), count + 1, history + [banks])
end

def redistribute2(banks, count, history)
  return history if history.any? { |_k, v| v > 2 }
  n, idx = most_blocks(banks)
  redistribute2(move(banks.dup, n, idx), count + 1,
                append_history(history, banks))
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
  0
end

def append_history(history, banks)
  history[banks] ||= 0
  history[banks] += 1
  history
end

puts redistribute(BANKS, 0, [])

h = redistribute2(BANKS, 0, {})
puts h.count { |_k, v| v > 1 }
