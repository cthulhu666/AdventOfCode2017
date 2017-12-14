import qualified Data.Vector as V

walk :: (Int -> V.Vector Int -> V.Vector Int) -> Int -> Int -> V.Vector Int -> Int
walk inc i a xs
    | i >= length xs = a
    | otherwise = walk (inc) (i + xs V.! i) (a + 1) (inc i xs)

inc :: Int -> V.Vector Int -> V.Vector Int
inc i xs = (V.take i xs) V.++ (V.singleton (xs V.! i + 1)) V.++ (V.drop (i + 1) xs)

--inc2 :: Int -> V.Vector Int -> V.Vector Int
--inc2 i xs
--    | step >= 3 = (V.take i xs) V.++ V.singleton (xs V.! i - 1) V.++ (V.drop (i + 1) xs)
--    | otherwise = (V.take i xs) V.++ V.singleton (xs V.! i + 1) V.++ (V.drop (i + 1) xs)
--    where step = xs V.! i

inc2 :: Int -> V.Vector Int -> V.Vector Int
inc2 i xs
    | step >= 3 = fst t V.++ V.singleton (xs V.! i - 1) V.++ V.tail (snd t)
    | otherwise = fst t V.++ V.singleton (xs V.! i + 1) V.++ V.tail (snd t)
    where step = xs V.! i
          t = V.splitAt i xs

main = do
   content <- readFile "day5.txt"
   let s = V.fromList [read x :: Int | x <- lines content]
   print (walk inc 0 0 s)
   print (walk inc2 0 0 s)
