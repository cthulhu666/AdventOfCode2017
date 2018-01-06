import Data.List
import Data.List.Split (wordsBy)


-- TODO: use more proper data structure, [(Char, Int)] perhaps?
-- dancers = zip ['a'..'p'] [0..]
dancers = ['a'..'p']

dance :: String -> [String -> String] -> String
dance xs [] = xs
dance xs (f:ys) = dance (f xs) ys

parse :: String -> String -> String
parse (cmd:arg)
    | cmd == 's' = spin arg
    | cmd == 'x' = exchange arg
    | cmd == 'p' = partner arg
    | otherwise = fail "Unknown move"

spin :: String -> String -> String
spin x xs =
    snd ys ++ fst ys
    where ys = splitAt n xs
          n = length xs - atoi x

exchange :: String -> String -> String
exchange x xs = swap i j xs
    where [i, j] = [atoi s | s <- wordsBy (=='/') x]

partner :: String -> String -> String
partner p xs = swap i j xs
    where [Just i, Just j] = [ elemIndex e xs | e <- [ head s | s <- wordsBy (=='/') p ]]

-- https://stackoverflow.com/questions/30551033/swap-two-elements-in-a-list-by-its-indices
swap f s xs = zipWith (\x y ->
    if x == f then xs !! s
    else if x == s then xs !! f
    else y) [0..] xs

atoi :: String -> Int
atoi s = read s

main = do
   content <- readFile "day16.txt"
   let moves = map parse . wordsBy (==',') $ content
   print $ dance dancers moves
