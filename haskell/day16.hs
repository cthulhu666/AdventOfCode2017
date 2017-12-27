import qualified Data.Text as T
import Data.List

-- TODO: use more proper data structure, [(Char, Int)] perhaps?
-- dancers = zip ['a'..'p'] [0..]
dancers = ['a'..'p']

dance :: String -> [String -> String] -> String
dance xs [] = xs
dance xs (f:ys) = dance (f xs) ys

parse :: T.Text -> String -> String
parse s
    | cmd == 's' = spin arg
    | cmd == 'x' = exchange arg
    | cmd == 'p' = partner arg
    | otherwise = fail "Unknown move"
    where cmd = T.head s
          arg = T.tail s

spin :: T.Text -> String -> String
spin x xs =
    snd ys ++ fst ys
    where ys = splitAt n xs
          n = (length xs) - (atoi x)

exchange :: T.Text -> String -> String
exchange x xs = swap i j xs
    where [i, j] = [atoi s | s <- T.split (=='/') x]

partner :: T.Text -> String -> String
partner p xs = swap i j xs
    where [Just i, Just j] = [ elemIndex e xs | e <- [ T.head s | s <- T.split (=='/') p ]]

-- https://stackoverflow.com/questions/30551033/swap-two-elements-in-a-list-by-its-indices
swap f s xs = zipWith (\x y ->
    if x == f then xs !! s
    else if x == s then xs !! f
    else y) [0..] xs

atoi :: T.Text -> Int
atoi s = read . T.unpack $ s

main = do
   content <- readFile "day16.txt"
   let moves = map parse . map T.strip . T.split (==',') . T.pack $ content
   print $ dance dancers moves
