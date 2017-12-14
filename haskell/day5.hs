import qualified Data.Vector as V

walk :: Int -> Int -> V.Vector Int -> Int
walk i a xs
    | i >= length xs = a
    | otherwise = walk (i + xs V.! i) (a + 1) (inc i xs)

inc :: Int -> V.Vector Int -> V.Vector Int
inc i xs = (V.take i xs) V.++ (V.fromList [xs V.! i + 1]) V.++ (V.drop (i + 1) xs)

main = do
   content <- readFile "day5.txt"
   let s = V.fromList [read x :: Int | x <- lines content]
   print (walk 0 0 s)
