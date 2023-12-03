module Main where

main :: IO ()
main = do
  part1

part1 :: IO ()
part1 = do
  content <- readFile "in/ex1.in"
  let ls = lines content
  let result = map numberSequences ls
  print result

numberSequences :: String -> [String]
numberSequences s
  | null xs = []
  | otherwise = x : numberSequences xs
  where
    (x, xs) = breakOffNumber s

breakOffNumber :: String -> (String, String)
breakOffNumber [] = ([], [])
breakOffNumber (c:cs)
  | isNotNumber c = ([], cs)
  | otherwise      = let (prefix, suffix) = breakOffNumber cs in (c : prefix, suffix)


isNotNumber :: Char -> Bool
isNotNumber c = not (c `elem` ['0'..'9'])

nonSymbols :: [Char]
nonSymbols = ['0'..'9'] ++ ['.']

isSymbol :: Char -> Bool
isSymbol = not . notSymbol

notSymbol :: Char -> Bool
notSymbol c = elem c nonSymbols

indicesOfSymbols :: String -> [Int]
indicesOfSymbols s = map fst filtered
  where
    zipped = zip [1..] s
    filtered = filter (\(_, c) -> isSymbol c) zipped
