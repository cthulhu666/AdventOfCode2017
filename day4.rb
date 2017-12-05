def valid?(password)
  password.size == without_anagrams(password.uniq).size
end

def without_anagrams(words)
  words.reject do |word|
    (words - [word]).any? { |w| anagram?(w, word) }
  end
end

def anagram?(w1, w2)
  w1.chars.permutation.include?(w2.chars)
end

data = File.new("day4.txt").readlines().map { |s| s.split(" ").map(&:strip) }
puts data.map(&method(:valid?)).count(true)

