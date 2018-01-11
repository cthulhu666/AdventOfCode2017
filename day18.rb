module Instructions
  extend self
  def set(x, y, registers)
    raise ArgumentError, x unless x.is_a?(String)
    val = y.is_a?(Integer) ? y : registers[y]
    registers[x] = val
    registers
  end

  def add(x, y, registers)
    raise ArgumentError unless x.is_a?(String)
    val = y.is_a?(Integer) ? y : registers[y]
    registers[x] += val
    registers
  end

  def mul(reg, val, registers)
    raise ArgumentError unless reg.is_a?(String)
    raise ArgumentError unless val.is_a?(Integer)
    registers[reg] *= val
    registers
  end

  def mod(x, y, registers)
    raise ArgumentError unless x.is_a?(String)
    val = y.is_a?(Integer) ? y : registers[y]
    registers[x] %= val
    registers
  end

  # jgz X Y jumps with an offset of the value of Y,
  # but only if the value of X is greater than zero.
  # (An offset of 2 skips the next instruction,
  # an offset of -1 jumps to the previous instruction, and so on.)
  def jgz(x, y, registers)
    xx = x.is_a?(Integer) ? x : registers[x]
    yy = y.is_a?(Integer) ? y : registers[y]
    registers['PC'] += yy if xx > 0
    raise 'Illegal jump' if yy == 0 && xx > 0
    registers
  end

  def snd(reg, registers)
    registers['SND'] = registers[reg]
    registers
  end

  def rcv(reg, registers)
    registers['RET'] = registers['SND'] if registers[reg] != 0
    registers
  end
end

module Instructions2
  extend Instructions
  extend self

  def snd(x, registers)
    val = x.is_a?(Integer) ? x : registers[x]
    registers['SND'] = val
    registers['SND_COUNT'] += 1
    registers
  end

  def rcv(reg, registers)
    raise ArgumentError unless reg.is_a?(String)
    if registers['RCV'].empty?
      registers['WAIT'] = true
    else
      registers[reg] = registers['RCV'].shift
      registers['WAIT'] = false
    end
    registers
  end
end

def parse(mod, s)
  name, arg1, arg2 = *s
  f = mod.method(name)
  g = case f.arity
      when 2
        f.curry.call(coerce(arg1))
      when 3
        f.curry.call(coerce(arg1), coerce(arg2))
      end
  [g, s]
end

def coerce(value)
  case value
  when /[a-z]+/
    value
  when /[0-9]+/
    value.to_i
  else
    raise ArgumentError, value
  end
end

def part1(instructions)
  registers = Hash.new { |h, k| h[k] = 0 }
  loop do
    idx = registers['PC']
    i = instructions[idx]
    break if i.nil?
    i.first.call(registers)
    return registers['RET'] if registers['RET'] != 0
    registers['PC'] += 1 if registers['PC'] == idx
  end
  registers
end

def part2(instructions)
  registersA = Hash.new { |h, k| h[k] = 0 }.tap { |h| h['p'] = 0 }
  registersB = Hash.new { |h, k| h[k] = 0 }.tap { |h| h['p'] = 1 }

  registers = [registersA, registersB]
  registers.each do |h|
    h['SND'] = nil
    h['RCV'] = []
    h['WAIT'] = false
  end

  clock = 0

  loop do
    break if registers.all? { |r| r['WAIT'] }
    registers.each_with_index do |r, n|
      next if rand < 0.05
      idx = r['PC']
      i = instructions[idx]
      i.first.call(r)
      if r['SND']
        registers.dig(1 - n, 'RCV').push(r['SND'])
        r['SND'] = nil
      end
      r['PC'] += 1 if r['PC'] == idx && !r['WAIT']
    end
    clock += 1
  end

  registersB['SND_COUNT']
end

if __FILE__ == $PROGRAM_NAME
  instructions = File.readlines('day18.txt').map(&:strip).map(&:split)
  p part1(instructions.map { |i| parse(Instructions, i) })
  p part2(instructions.map { |i| parse(Instructions2, i) })
end
