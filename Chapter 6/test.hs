
-- 1. factorial function with guard for negative numbers

fac :: Int -> Int
fac 0 = 1
fac n | n > 0 = n * fac (n - 1)

-- 2. sumdown function
sumdown :: Int -> Int 
sumdown 0         = 0
sumdown n | n > 0 = n + sumdown (n - 1)

-- 3. Exponentiation function.
-- replaced (^) with expo for testing.
expo :: Int -> Int -> Int
expo n 0 = 1
expo m n = m * expo m (n - 1)


-- 4 euclid's algorithm for integers >=
euclid :: Int -> Int -> Int
euclid m 0             = m
euclid 0 n             = n
euclid m n | m < n     = euclid m (n - m)
           | n < m     = euclid n (m - n)
           | otherwise = m

euclid' :: Int -> Int -> Int
euclid' x y | x == y = x
            | x < y  = euclid' x (y - x)
            | x > y  = euclid' (x - y) y



-- 7. Merge function 
merge :: Ord a => [a] -> [a] -> [a]
merge xs [] = xs
merge [] xs = xs 
merge (x:xs) (y:ys) | x <= y = x : merge xs (y:ys)
                    | x > y  = y : merge (x:xs) ys

-- 8. msort function
halve :: [a] -> ([a], [a])
halve xs = (first,last)
    where
        halfsize = length xs `div` 2
        first = take halfsize xs
        last  = drop halfsize xs

msort :: Ord a => [a] -> [a]
msort []  = []
msort [x] = [x]
msort xs  = merge (msort left) (msort right)
    where
        (left, right) = halve xs

