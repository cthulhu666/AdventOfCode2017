--startingValues = [65, 8921]
startingValues = [591, 393]
factors = [16807, 48271]
d = [4, 8]
divisor = 2147483647
round2to16 = round $ 2**16
numberOfPairs = round $ 4 * 10 ** 7
numberOfPairs2 = round $ 5 * 10 ** 6

part1 n = length [p | p <- take n pairs, match p]

part2 n = length [p | p <- take n pairs2, match p]

pairs = zip (xs !! 0) (xs !! 1)
    where xs = map gen ys
          ys = zip factors startingValues

pairs2 = zip (xs !! 0) (xs !! 1)
  where xs = map gen2 ys
        ys = zip3 factors startingValues d

gen (factor, startingValue) = iterate (next factor) startingValue

gen2 (factor, startingValue, d) = filter (\x -> rem x d == 0) xs
    where xs = gen (factor, startingValue)

next factor x = rem (x * factor) divisor

match (a, b) = rem a round2to16 == rem b round2to16

main = do
   print (part1 numberOfPairs)
   print (part2 numberOfPairs2)
