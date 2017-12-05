def valid?(password)
  password.size == password.uniq.size
end

data = File.new("day4.txt").readlines().map { |s| s.split(" ").map(&:strip) }
puts data.map(&method(:valid?)).count(true)

