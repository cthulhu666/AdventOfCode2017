module Instructions
  extend self
  def set(reg, val, registers)
    registers[reg] = val
    registers
  end

  def set2(reg, reg2, registers)
    set(reg, registers[reg2], registers)
  end

  def add(reg, val, registers)
    registers[reg] += val
    registers
  end

  def add2(reg, reg2, registers)
    add(reg, registers[reg2], registers)
  end

  def mul(reg, val, registers)
    registers[reg] *= val
    registers
  end

  def mod(reg, val, registers)
    registers[reg] %= val
    registers
  end

  def mod2(reg, reg2, registers)
    mod(reg, registers[reg2], registers)
  end

  def jgz(reg, val, registers)
    registers['PC'] += val if registers[reg] > 0
    registers
  end

  def jgz2(reg, reg2, registers)
    jgz(reg, registers[reg2], registers)
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

def parse(s)
  case s[0]
  when 'set', 'add', 'mul', 'mod', 'jgz'
    instruction(s[0], s[1], s[2])
  when 'snd', 'rcv'
    Instructions.method(s[0]).curry.call(s[1])
  else
    raise "Unknown instruction: #{s}"
  end
end

def instruction(name, arg1, arg2)
  case arg2
  when /[a-z]+/
    Instructions.method("#{name}2").curry.call(arg1, arg2)
  when /[0-9]+/
    Instructions.method(name).curry.call(arg1, arg2.to_i)
  else
    raise ArgumentError, arg2
  end
end

def part1(instructions)
  registers = Hash.new { |h, k| h[k] = 0 }
  loop do
    idx = registers['PC']
    i = instructions[idx]
    break if i.nil?
    i.call(registers)
    return registers['RET'] if registers['RET'] != 0
    registers['PC'] += 1 if registers['PC'] == idx
  end
  registers
end

if __FILE__ == $PROGRAM_NAME
  instructions = File.readlines('day18.txt').map(&:strip).map(&:split).map(&method(:parse))
  p part1(instructions)
end
