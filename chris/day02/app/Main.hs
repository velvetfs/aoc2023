module Main where


main :: IO ()
main = do
  content <- readFile "in/1.in"
  let ls = lines content
  let illegalGames = map createGameData ls
  let result = foldl (\acc x -> acc + indexIfIllegal x) 0 illegalGames
  print result

data Game = Game
  { index :: Int,
    red   :: Int,
    green :: Int,
    blue  :: Int
  }
  deriving (Show)

indexIfIllegal :: (Int, String) -> Int
indexIfIllegal (i, "[]") = i
indexIfIllegal (_, _)    = 0

createGameData :: String -> (Int, String)
createGameData ln = (read $ gameIndex, show $ illegalGames)
  where
    (gamePrelude, rest) = break (':'==) ln
    gameIndex = drop 5 gamePrelude
    subGames = drop 2 rest
    s = splitSubGames subGames
    ss = map subSubGames s
    plies = map (map splitPly) ss
    illegalGames = filter (any plyIsIllegal) plies

splitSubGames :: String -> [String]
splitSubGames [] = []
splitSubGames ln
  | null rest = [subGame]
  | otherwise = subGame : splitSubGames (drop 2 rest)
  where
    (subGame, rest) = break (';'==) ln

subSubGames :: String -> [String]
subSubGames [] = []
subSubGames ln
  | null rest = [subSubGame]
  | otherwise = subSubGame : subSubGames (drop 2 rest)
  where
    (subSubGame, rest) = break (','==) ln

splitPly :: String -> (Int, String)
splitPly ln = (read $ ply, drop 1 rest)
  where
    (ply, rest) = break (' '==) ln

plyIsIllegal :: (Int, String) -> Bool
plyIsIllegal (c, color) = c > maxColor color

getGameIndex :: String -> String
getGameIndex = drop 5 . takeWhile (/= ':')

getNextColor :: String -> String
getNextColor = takeWhile (/= ';')

isNumber :: Char -> Bool
isNumber c = c `elem` ['0' .. '9']

isJust :: Maybe a -> Bool
isJust (Just _) = True
isJust Nothing  = False

isColor :: String -> Bool
isColor c = c `elem` ["red", "green", "blue"]

maxColor :: String -> Int
maxColor "red"   = 12
maxColor "green" = 13
maxColor "blue"  = 14
maxColor _       = error "Invalid color"
