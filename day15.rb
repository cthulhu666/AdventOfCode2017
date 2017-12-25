# STARTING_VALUES = [65, 8921].freeze
STARTING_VALUES = [591, 393].freeze
FACTORS = [16_807, 48_271].freeze
DIVISOR = 2_147_483_647
N = 4 * 10**7

def part1(starting_values, factors)
  starting_values.zip(factors)
                 .map { |a, b| generate_all(a, b) }
                 .transpose
                 .count { |a, b| match?(a, b) }
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
  a % 2**16 == b % 2 **16
end

if __FILE__ == $PROGRAM_NAME
  p part1(STARTING_VALUES, FACTORS)
end
