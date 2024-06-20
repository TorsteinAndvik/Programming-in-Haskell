import Distribution.Compat.Lens (_1)
-- 1. halve function
halve :: [a] -> ([a], [a])
halve xs = (take n xs, drop n xs)
    where
        n = length xs `div` 2

halve':: [a] -> ([a], [a])
halve' xs = splitAt n xs
    where
        n = length xs `div` 2

-- 2. third function
-- a. head and tail
third :: [a] -> a
third xs = head (tail (tail  xs))

-- b. list indexing !!
third' :: [a] -> a
third' xs = xs !! 2

-- c. pattern matching
third'' :: [a] -> a
third'' (_:_:x:_) = x

-- 3. safetail function
-- a. a conditional expression
safetail :: [a] -> [a]
safetail xs = if not (null xs) then tail xs else []

-- b. guarded equations
safetail' :: [a] -> [a]
safetail' xs | null xs   = []
             | otherwise = tail xs

-- c. pattern matching
safetail'' :: [a] -> [a]
safetail'' [] = []
safetail'' (_:xs) = xs

-- 4. Disjunction operator function
{-
(||) :: Bool -> Bool -> Bool
True  || True  = True
True  || False = True
False || True  = True
False || False = False
-}

{-
(||) :: Bool -> Bool -> Bool
True  || _ = True
False || b = b
-}

{-
(||) :: Bool -> Bool -> Bool
False || False = False
_     || _     = True
-}

{-
(||) :: Bool -> Bool -> Bool
b || c | b == c    = b
       | otherwise = True 
-}

-- 5. Logical conjunction definition
-- (&&) :: Bool -> Bool -> Bool
-- a && b = if a then (if b then True else False) else False

-- 6. Alternate definition logical conjunction
-- (&&) :: Bool -> Bool -> Bool
-- a && b = if a then b else False


-- 7. mult function as lambda
mult :: Integer -> Integer -> Integer -> Integer
mult = \x -> (\y -> (\z -> x * y * z))

-- 8. Luhn function 
luhnDouble :: Int -> Int
luhnDouble n | n * 2 > 9   = n * 2 - 9
             | otherwise = n * 2

luhn :: Int -> Int -> Int -> Int -> Bool
luhn a b c d = (luhnDouble a + b + luhnDouble c + d) `mod` 10 == 0


-- Alternative solution
luhnDouble' :: Int -> Int
luhnDouble' n = if a > 9 then a - 9 else a
    where 
        a = n * 2 

luhn' :: Int -> Int -> Int -> Int -> Bool
luhn' a b c d = luhnSum `mod` 10 == 0
    where 
        luhnSum = doubleA + b + doubleC + d
        doubleA = luhnDouble a
        doubleC = luhnDouble c