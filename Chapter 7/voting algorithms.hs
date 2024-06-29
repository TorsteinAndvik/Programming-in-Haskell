import Data.List

-- First past the post
count :: Eq a => a -> [a] -> Int
count x = length . filter (== x) 

rmdups :: Eq a => [a] -> [a]
rmdups [] = []
rmdups (x:xs) = x : filter (/= x) (rmdups xs)

result :: Ord a => [a] -> [(Int, a)]
result vs = sort [(count v vs, v) | v <- rmdups vs]

winner :: Ord a => [a] -> a
winner = snd . last . result


-- Alternative vote

rmempty :: Eq a => [[a]] -> [[a]]
rmempty = filter (/= [])

elim :: Eq a => a -> [[a]] -> [[a]]
elim x = map (filter (/= x))

rank :: Ord a => [[a]] -> [a]
rank = map snd . result . map head

winner' :: Ord a => [[a]] -> a
winner' bs = case rank (rmempty bs) of
                [c]    -> c
                (c:cs) -> winner' (elim c bs)

{-
ballots = [["Red", "Green"], ["Blue"], ["Green", "Red", "Blue"], ["Blue", "Green", "Red"], ["Green"]]
> winner' ballots

= case rank rmempty [["Red", "Green"], ["Blue"], ["Green", "Red", "Blue"], ["Blue", "Green", "Red"], ["Green"]]) 
  case rank [["Red", "Green"], ["Blue"], ["Green", "Red", "Blue"], ["Blue", "Green", "Red"], ["Green"]]) 
  case ["Red", "Blue", "Green"]
    -> winner' (elim "Red" [["Red", "Green"], ["Blue"], ["Green", "Red", "Blue"], ["Blue", "Green", "Red"], ["Green"]])
    -> winner' [["Green"], ["Blue"], ["Green", "Blue"], ["Blue", "Green"], ["Green"]]

= case rank rmempty [["Green"], ["Blue"], ["Green", "Blue"], ["Blue", "Green"], ["Green"]]
  case rank [["Green"], ["Blue"], ["Green", "Blue"], ["Blue", "Green"], ["Green"]]
  case ["Blue", "Green"]
    -> winner' (elim "Blue", [["Green"], ["Blue"], ["Green", "Blue"], ["Blue", "Green"], ["Green"]])
    -> winner' [["Green"], [], ["Green"], ["Green"], ["Green"]]

= case rank rmempty [["Green"], [], ["Green"], ["Green"], ["Green"]]
  case rank [["Green"], ["Green"], ["Green"], ["Green"]]
  case ["Green"]
    -> Green
-}                

