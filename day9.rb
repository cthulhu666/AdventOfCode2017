def find_groups(stream, trash_can = [])
  return [] if stream.empty?
  case stream[0]
  when '<'
    find_groups(drop_garbage(stream.drop(1), trash_can), trash_can)
  when '{'
    ['{'] + find_groups(stream.drop(1), trash_can)
  when '}'
    ['}'] + find_groups(stream.drop(1), trash_can)
  else
    find_groups(stream.drop(1), trash_can)
  end
end

# yes, it relies on a side effect, eat it.
def drop_garbage(stream, trash_can = [])
  case s = stream[0]
  when '!'
    drop_garbage(stream.drop(2), trash_can)
  when '>'
    stream.drop(1)
  else
    drop_garbage(stream.drop(1), trash_can.push(s))
  end
end

def count_score(groups, lvl = 0)
  return [] if groups.empty?
  case groups[0]
  when '{'
    count_score(groups.drop(1), lvl + 1)
  when '}'
    [lvl] + count_score(groups.drop(1), lvl - 1)
  end
end

def validate_groups!(g)
  a = g.count('{')
  b = g.count('}')
  raise "Unbalanced curly braces: #{a} {} #{b}" if a != b
end

def part1(stream)
  g = find_groups(stream)
  validate_groups!(g)
  count_score(g).sum
end

def part2(stream)
  trash_can = []
  g = find_groups(stream, trash_can)
  validate_groups!(g)
  trash_can.length
end

if __FILE__ == $PROGRAM_NAME
  stream = File.read('day9.txt').strip.chars.freeze
  p part1(stream)
  p part2(stream)
end
