INPUT = File.readlines('day8.txt').map(&:strip)

Line = Struct.new(:register, :func, :value, :condition)
Condition = Struct.new(:register, :func, :value)

def parse_line(s)
  a = s.split
  Line.new(a[0], a[1], a[2].to_i, Condition.new(a[4], a[5], a[6].to_i))
end

def execute_code!(code, registers, max_values)
  code.each do |e|
    execute!(e, registers) if eval_condition(e.condition, registers)
    update_max_values!(registers, max_values)
  end
end

def eval_condition(cond, registers)
  reg_value = registers[cond.register]
  reg_value.public_send(cond.func, cond.value)
end

def execute!(line, registers)
  reg_val = registers[line.register]
  new_val = Instructions.method(line.func).call(reg_val, line.value)
  registers[line.register] = new_val
end

def update_max_values!(registers, max_values)
  registers.each do |k, v|
    max_values[k] = [v, max_values[k]].max
  end
end

module Instructions
  def self.inc(a, b)
    a + b
  end

  def self.dec(a, b)
    a - b
  end
end

registers = Hash.new { 0 }
max_values = Hash.new { 0 }

execute_code!(INPUT.map(&method(:parse_line)), registers, max_values)

p registers.sort_by(&:last).last
p max_values.sort_by(&:last).last
