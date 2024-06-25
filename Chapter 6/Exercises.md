# Chapter 6

## Exercise 1

How does the recursice version of the factorial function behave if applied to a negative arument such as (-1)? Modify the definition to prohibit negative arbuments by adding a guard to the recursive case.

    For the function to return a value, it must reach the base case `fac 0`. When n starts below 0, n - 1 will never be 0, thus the funciton will never return a value.

```haskell
-- Original function definition
fac :: Int -> Int
fac 0 = 1
fac n = n * fac (n-1)

-- With guard for negative numbers
fac :: Int -> Int
fac 0         = 1
fac n | n > 0 = n * fac (n - 1)
```

## Exercise 2

Define a recursive function `sumdown :: Int -> Int` that returns the sum of the nun-negative integers from a given value down to zero. For example `sumdown 3` should return the result 3 + 2 + 1 + 0 = 6

```haskell
sumdown :: Int -> Int
sumdown 0 = 0
sumdown n | n > 0 = n + sumdown (n - 1)
```

## Exercise 3

Define the exponentiation operator ^ for non-negative integers using the same pettern of recursion as the multiplication operator *, and show the expression 2^3 is evaluated using your definition.

```haskell
(^) :: Int -> Int -> Int
m ^ 0 = 1
m ^ n = m * (m ^ (n - 1))
```

**Evaluation of 2^3:**

      2 ^ 3
    = 2 * (2 ^ 2)
    = 2 * (2 * (2 ^ 1))
    = 2 * (2 * (2 * (2 ^ 0)))
    = 2 * (2 * (2 * (1)))
    = 2 * 2 * 2 * 1
    = 8

## Exercise 4

Define a recursive function `euclid :: Int -> Int -> Int` that implements euclid's algorithm for calculating the greatest common divisor of two non-negative integers: if the two numbers are equal, this number is the result; otherwise, the smaller number is subtracted from the lager, and the same process is then repeated. For example:

    > euclid 6 27
    3

```haskell
-- My solution
euclid :: Int -> Int -> Int
euclid m 0             = m
euclid 0 n             = n
euclid m n | m < n     = euclid m (n - m)
           | n < m     = euclid n (m - n)
           | otherwise = m

-- Solution from book can't handle zero as an argument. It will end in an infinite loop when either of arguments are zero.
euclid' :: Int -> Int -> Int
euclid' x y | x == y = x
           | x < y  = euclid x (y - x)
           | x > y  = euclid (x - y) y
```

## Exercise 5

Using the recursive definitions given in this chapter, show how length [1, 2, 3], drop 3 [1, 2, 3, 4, 5], and init [1, 2, 3] are evaluated.

### length

```haskell
length :: [a] -> Int
length []     = 0
length (_:xs) = 1 + length xs
```

    length [1, 2, 3]
    = (1 + length [2, 3])
    = (1 + (1 + length [3]))
    = (1 + (1 + (1 + length [])))
    = (1 + (1 + (1 + (0))))
    = 1 + 1 + 1 + 0
    = 3

### drop

```haskell
drop :: Int -> [a] -> [a]
drop 0 xs = xs
drop _ [] = []
drop n (_:xs) = drop (n - 1) xs
```

      drop 3 [1, 2, 3, 4, 5] -> drop (3 - 1) [2, 3, 4, 5]
    = drop 2 [2, 3, 4, 5]    -> drop (2 - 1) [3, 4, 5]
    = drop 1 [3, 4, 5]       -> drop (1 - 1) [4, 5]
    = drop 0 [4, 5]          -> [4, 5]
    = [4, 5]

### init

```haskell
init :: [a] -> [a]
init [_]    = []
init (x:xs) = x : init xs
```

      init [1, 2, 3]
    = 1: init [2, 3]
    = 1: 2: init [3]
    = 1: 2: []
    = [1, 2]

## Exercise 6

Without looking at the definitions from the standard prelude, define the following library functions on lists using recursion.

```haskell
-- a. Decide if all logical values in a list are True:
and :: [Bool] -> Bool
and []                 = True
and (b:bs) | not b     = False
           | otherwise = and bs
```

```haskell
-- b. Concatenate a list of lists:
concat :: [[a]] -> [a]
concat [] = []
concat [x:xs] = x ++ concat xs
```

```haskell
-- c. Produce a list with n identical elements:
replicate :: Int -> a -> [a]
replicate 0 _ = []
replicate n x = x : replicate (n - 1) x
```

```haskell
-- d. Select the n'th element of a list:
(!!) :: [a] -> Int -> a
(!!) (x:xs) 0 = x 
(!!) (x:xs) n = (!!) xs (n - 1)
```

```haskell
-- e. Decide if an element is a part of a list:
elem :: a -> [a] -> Bool
elem x []                 = False
elem x (y:ys) | x == y    = True
              | otherwise = elem x ys
```

## Exercise 7

Define a recursive function `merge:: Ord a => [a] -> [a] -> [a]` that merges two sorted lists to give a single sorted list. For example:

    > merge [2, 5, 6] [1, 3, 4]
    [1, 2, 3, 4, 5, 6]

```haskell
merge :: Ord a => [a] -> [a] -> [a]
merge xs [] = xs
merge [] xs = xs 
merge (x:xs) (y:ys) | x <= y    = x : merge xs (y:ys)
                    | otherwise = y : merge (x:xs) ys

```

## Exercise 8

Using merge, define a function `msort :: Ord a => [a] -> [a]` that implements merge sort, in which the empty list and singleton lists are already sorted, and any other list is sorted by merging together the two lists that result from sorting the two halves of the list separately.

Hint: First define a function `halve :: [a] -> ([a], [a])` that splits a list into two halves whose lengths differ by at most one.

```haskell
halve :: [a] -> ([a], [a])
halve xs = (first,last)
    where
        halfsize = length xs `div` 2
        first = take halfsize xs
        last  = drop halfsize xs

msort :: Ord a => [a] -> [a]
msort []  = []
msort [x] = [x]
msort xs  = merge start end
    where
        (start:end) <- halve xs
```

## Exercise 9

Using the five-step process, construct the library functions that:

### a. calculate the sum of a list of numbers

    Step 1: define the type
        sum :: [Int] -> Int

    Step 2: enumerate the cases
        sum []     =
        sum (n:ns) =

    Step 3: define the simple cases
        sum []     = 0
    
    Step 4: define the other cases
        sum (n:ns) = n + sum ns
        
    Step 5: generalise and simplify
        sum :: Num a => [a] -> a
        sum []     = 0
        sum (n:ns) = n + sum ns

### b. take a given number of elements from the start of a list

    Step 1: define the type
        take :: Int -> [a] -> [a]

    Step 2: enumerate the cases
        take 0 xs =
        take _ [] = 
        take n (x:xs) =

    Step 3: define the simple cases
        take 0 xs = []
        take _ [] = []

    Step 4: define the other cases
        take n (x:xs) = x : take (n - 1) xs

    Step 5: generalise and simplify
        take :: Int -> [a] -> [a]
        take 0 xs = []
        take _ [] = []
        take n (x:xs) = x : take (n - 1) xs

### c. select the last element of a non-empty list

    Step 1: define the type
        init :: [a] -> a

    Step 2: enumerate the cases
        init [a]   =
        init (_:a) =

    Step 3: define the simple cases
        init [a]   = a

    Step 4: define the other cases
        init (_:a) = init a
    
    Step 5: generalise and simplify
        init :: [a] -> a
        init [a]   = a
        init (_:a) = init a
