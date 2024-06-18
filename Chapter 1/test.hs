
--  3. Product function
product' :: Num a => [a] -> a
product' [] = 1
product' (n:ns) = n * product' ns

-- 4. Reversed sort function
rqsort :: Ord a => [a] -> [a]
rqsort [] = []
rqsort (x:xs) = rqsort larger ++ [x] ++ rqsort smaller
    where 
        smaller = [a | a <- xs, a <= x]
        larger  = [a | a <- xs, a > x]

-- 5. Replaced <= with < in smaller = [a | a <- xs, a <= x]
qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = qsort smaller ++ [x] ++ qsort larger
    where 
        smaller = [a | a <- xs, a < x]
        larger  = [a | a <- xs, a > x]