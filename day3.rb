def corners(d)
  n = (1 + 2 * d)
  max = n * n
  3.times.reduce([max]) do |a, _|
    a << a.last - (n - 1)
  end
end

# That's not a general solution :P

N = 361_527
r = (N**0.5 / 2.0).floor

corners = corners(r)

mid = (corners[0] + r)

y = N - mid
x = r

puts x + y
