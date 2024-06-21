import Data.Char 

-- 1. sum of squares function
squares :: Integer -> Integer
squares n = sum [x^2 | x <- [1..n]]

-- 2. coordinate grid function
grid :: Int -> Int -> [(Int, Int)]
grid m n = [(m, n) | m <- [0..m], n <- [0..n]]

-- 3. square function
square :: Int -> [(Int, Int)]
square n = [(x, y) | (x, y) <- grid n n, x /= y]

-- 4. replicate function
replicate' :: Int -> a -> [a]
replicate' n a = [a | i <- [1..n]]

-- 5. pythagoran triples function
pyths :: Int -> [(Int, Int, Int)]
pyths n = [(x, y, z) | x <- [2..n], 
                       y <- [2..n], 
                       z <- [2..n], 
                       x^2 + y^2 == z^2]

-- 6. perfects function                       
factors :: Int -> [Int]
factors n = [x | x <- [1 .. n], n `mod` x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum (factors x) - x == x]

-- 7. re-expressed list comprehension  
lcExample :: [(Integer, Integer)]
lcExample = [(x, y) | x <- [1, 2], y <- [3, 4]]

lcExample2 :: [(Integer, Integer)]
lcExample2 = concat [[(x, y) | y <- [3, 4]] | x <- [1, 2]]

-- 8. positions function

positions :: Eq a => a -> [a] -> [Int]
positions x xs = [i | (x', i) <- zip xs [0..], x == x']

find :: Eq a => a-> [(a, b)] -> [b]
find k t = [v | (k', v) <- t, k' == k]

positions' :: Eq a => a -> [a] -> [Int]
positions' x xs = find x (zip xs [0..])

-- 9. scalarproduct function

scalarproduct :: [Int] -> [Int] -> Int
scalarproduct xs ys = sum [x * y | (x, y) <- zip xs ys]

-- 10. Ceasar cipher with support for upper case letters

let2int :: Char -> Int
let2int c | isLower c = ord c - ord 'a'
          | otherwise = ord c - ord 'A'

int2uclet :: Int -> Char
int2uclet n = chr (ord 'A' + n)

int2lclet :: Int -> Char
int2lclet n = chr (ord 'a' + n)

shift :: Int -> Char -> Char
shift n c | isUpper c = int2uclet ((let2int c + n) `mod` 26)
          | isLower c = int2lclet ((let2int c + n) `mod` 26)
          | otherwise = c

encode :: Int -> String -> String
encode n xs = [shift n x | x <- xs]

