# STARTING_VALUES = [65, 8921].freeze
STARTING_VALUES = [591, 393].freeze
FACTORS = [16_807, 48_271].freeze
DIVISOR = 2_147_483_647
N = 4 * 10**7
M = 5 * 10**6

def part1(starting_values, factors)
  starting_values.zip(factors)
                 .map { |a, b| generate_all(a, b) }
                 .transpose
                 .count { |a, b| match?(a, b) }
end

def part2(starting_values, factors, mods = [4, 8])
  starting_values.zip(factors, mods)
                 .map { |a, b, c| generate_all2(a, b, c) }
                 .transpose
                 .count { |a, b| match?(a, b) }
end

def generate_all2(v, factor, mod)
  a = []
  loop do
    v = generate(v, factor)
    a.push(v) if v % mod == 0
    return a if a.length == M
  end
end

def generate_all(starting_value, factor)
  N.times
   .reduce([starting_value]) { |a, _e| a.push(generate(a.last, factor)) }
   .drop(1)
end

def generate(prev, factor)
  prev * factor % DIVISOR
end

def match?(a, b)
  a % 2**16 == b % 2**16
end

if __FILE__ == $PROGRAM_NAME
  p part1(STARTING_VALUES, FACTORS)
  p part2(STARTING_VALUES, FACTORS)
end
