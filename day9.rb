def find_groups(stream)
  return [] if stream.empty?
  case stream[0]
  when '<'
    find_groups(drop_garbage(stream))
  when '{'
    ['{'] + find_groups(stream.drop(1))
  when '}'
    ['}'] + find_groups(stream.drop(1))
  else
    find_groups(stream.drop(1))
  end
end

def drop_garbage(stream)
  case stream[0]
  when '!'
    return drop_garbage(stream.drop(2))
  when '>'
    return stream.drop(1)
  else
    return drop_garbage(stream.drop(1))
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

def part1(stream)
  g = find_groups(stream)
  a = g.count('{')
  b = g.count('}')
  raise "Unbalanced curly braces: #{a} {} #{b}" if a != b
  count_score(g).sum
end

if __FILE__ == $PROGRAM_NAME
  stream = File.read('day9.txt').strip.chars.freeze
  p part1(stream)

end
