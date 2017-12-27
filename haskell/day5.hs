import qualified Data.Vector.Unboxed as V

walk :: (Int -> V.Vector Int -> V.Vector Int) -> Int -> Int -> V.Vector Int -> Int
walk inc i a xs
    | i >= V.length xs = a
    | otherwise = walk (inc) (i + xs V.! i) (a + 1) (inc i xs)

inc :: Int -> V.Vector Int -> V.Vector Int
inc i xs = V.update xs $ V.fromList [(i, xs V.! i + 1)]

inc2 :: Int -> V.Vector Int -> V.Vector Int
inc2 i xs
    | step >= 3 = V.update xs $ V.fromList [(i, xs V.! i - 1)]
    | otherwise = V.update xs $ V.fromList [(i, xs V.! i + 1)]
    where step = xs V.! i

main = do
   content <- readFile "day5.txt"
   let s = V.fromList [read x :: Int | x <- lines content]
   print (walk inc 0 0 s)
   print (walk inc2 0 0 s)
