walk :: Int -> Int -> [Int] -> Int
walk i a xs
    | i >= length xs = a
    | otherwise = walk (i + xs !! i) (a + 1) (inc i xs)

inc :: Int -> [Int] -> [Int]
inc i xs = take i xs ++ [xs !! i + 1] ++ drop (i + 1) xs

main = do
   content <- readFile "day5.txt"
   let s = [read x :: Int | x <- lines content]
   print (walk 0 0 s)
