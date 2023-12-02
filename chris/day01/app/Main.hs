module Main where
import           Data.Maybe (fromMaybe)

main :: IO ()
main = do
  part2

part1 :: IO ()
part1 = do
  content <- readFile "in/ex2.in"
  let ls = lines content
  let nums = map (map parseMaybeInt) ls
  let firstAndLastNums = map concatFirstAndLast nums
  let result = sum (map read firstAndLastNums) :: Int
  print result

part2 :: IO ()
part2 = do
  content <- readFile "in/ex2.in"
  let ls = lines content
  let firstAndLastNums = map concatFirstAndLast' ls
  let result = sum firstAndLastNums :: Int
  print result

parseMaybeInt :: Char -> Maybe Int
parseMaybeInt s = case reads [s] of
  [(x, "")] -> Just x
  _         -> Nothing

firstNumber :: [Maybe Int] -> Int
firstNumber []             = error "No numbers found"
firstNumber (Nothing : xs) = firstNumber xs
firstNumber (Just x : _)   = x

lastNumber :: [Maybe Int] -> Int
lastNumber []             = error "No numbers found"
lastNumber [Just x]       = x
lastNumber (Nothing : xs) = lastNumber xs
lastNumber (x:next:xs)
  | isJust next = lastNumber (next:xs)
  | isJust x    = lastNumber (x:xs)
  | otherwise   = lastNumber (xs)

concatFirstAndLast :: [Maybe Int] -> String
concatFirstAndLast xs = show (firstNumber xs) ++ show (lastNumber xs)

isJust :: Maybe a -> Bool
isJust Nothing = False
isJust _       = True

parseWordInt :: String -> Maybe Int
parseWordInt "one"   = Just 1
parseWordInt "two"   = Just 2
parseWordInt "three" = Just 3
parseWordInt "four"  = Just 4
parseWordInt "five"  = Just 5
parseWordInt "six"   = Just 6
parseWordInt "seven" = Just 7
parseWordInt "eight" = Just 8
parseWordInt "nine"  = Just 9
parseWordInt _       = Nothing

parseFirstWordInt :: String -> Maybe Int
parseFirstWordInt [] = Nothing
parseFirstWordInt s
  | isJust (parseWordInt s) = parseWordInt s
  | isJust (parseFirstWordInt (init s)) = parseFirstWordInt (init s)
  | otherwise               = parseFirstWordInt (drop 1 s)

parseLastWordInt :: String -> Maybe Int
parseLastWordInt [] = Nothing
parseLastWordInt s
  | isJust (parseWordInt s) = parseWordInt s
  | isJust (parseLastWordInt (drop 1 s)) = parseLastWordInt (drop 1 s)
  | otherwise               = parseLastWordInt (init s)

firstNumber' :: String -> Maybe Int
firstNumber' [] = Nothing
firstNumber' (x:xs)
  | isJust (parseMaybeInt x) = parseMaybeInt x
  | isJust (parseFirstWordInt (x:xs)) = parseFirstWordInt (x:xs)
  | otherwise               = firstNumber' xs

lastNumber' :: String -> Maybe Int
lastNumber' [] = Nothing
lastNumber' s
  | isJust (parseMaybeInt (last s)) = parseMaybeInt (last s)
  | isJust (parseLastWordInt s) = parseLastWordInt s
  | otherwise               = lastNumber' (init s)


concatFirstAndLast' :: String -> Int
concatFirstAndLast' s = f + l
  where f = 10 * fromMaybe 0 (firstNumber' s)
        l = fromMaybe 0 (lastNumber' s)
