module Main where

data CategoryMap = CategoryMap {
  name        :: String,
  rangeStart  :: Int,
  domainStart :: Int,
  len         :: Int
} deriving (Show)

main :: IO ()
main = do
  part1

part1 :: IO ()
part1 = do
  content <- readFile "in/ex1.in"
  let ls = lines content
  let (seeds, rest) = splitSeeds ls
  let result = splitInts (rest !! 2)
  print result

splitSeeds :: [String] -> (Maybe String, [String])
splitSeeds []     = (Nothing, [])
splitSeeds (x:xs) = (Just x, (drop 1 xs))

{-
 -categoryMapsFromStrings :: [String] -> CategoryMap
 -categoryMapsFromStrings []  = []
 -categoryMapsFromStrings [_] = []
 -categoryMapsFromStrings (x:xs)
 -}

splitInts :: String -> Maybe (Int, Int, Int)
splitInts [] = Nothing
splitInts [_] = Nothing
splitInts s = Just (a, b, head c)
  where (a:b:c) = map read (split (== ' ') s)

split :: (a -> Bool) -> [a] -> [[a]]
split _ [] = []
split p xs
  | null left = []
  | otherwise = left : split p right
  where
    stripped = dropWhile p xs
    (left, right) = break p stripped

{-
 -categoryMapsFromStrings :: [String] -> [CategoryMap]
 -categoryMapsFromStrings []   = []
 -categoryMapsFromStrings [_]  = []
 -categoryMapsFromStrings rows = takeWhile (\s -> s /= []) rows
 -}
