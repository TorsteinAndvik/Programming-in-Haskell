# Chapter 5

## Exercise 1

Using a list comprehension, give an expression that calculates the sum $$1^2 + 2^2 + ... + 100^2$$ of the first one hundred integer squares

```haskell
squares :: Integer -> Integer
squares n = sum [x^2 | x <- [1..n]]
```

## Exercise 2

Suppoe that a coordinate grid of size m x n is given by the list of all pairs (x, y) og integers such that `0 <= x <= m` and `0 <= y <= n`. Using a list comprehension, define a function `grid :: Int -> Int -> [(Int, Int)]` that returns a coordinate grid of a given size

```haskell
grid :: Int -> Int -> [(Int, Int)]
grid m n = [(m, n) | m <- [0..m], n <- [0..n]]
```

```haskell
> grid 1 2
[(0, 0), (0, 1), (0, 2), (1, 0), (1, 1), (1, 2)]
```

## Exercise 3

Using a list comprehension and the function grid above, define a function `square :: Int -> [(Int, Int)]` that returns a coordinate square of size n, excluding the diagonal from (0, 0) to (n, n)

```haskell
square :: Int -> [(Int, Int)]
square n = [(x, y) | (x, y) <- grid n n, x /= y]
```

```haskell
> square 2
[(0, 1), (0, 2), (1, 0), (1, 2), (2, 0), (2, 1)]
```

## Exercise 4

In a similar way to the function length, show how the library function `replicate :: Int -> a -> [a]` that produces a list of identical elements can be defined using a list comprehension

```haskell
replicate' :: Int -> a -> [a]
replicate' n a = [a | i <- [1..n]]
```

```haskell
> replicate' 3 True
[True, True, True]
```

## Exercise 5

A triple (x, y, z) of positive integers is Pythagorean if it satisfies the equation x^2 + y^2 = z^2. Using a list comprehension with three generators, define a function `pyths :: Int -> [(Int, Int, Int)]` that returns the list of all such triples whose components are at most a given limit

```haskell
pyths :: Int -> [(Int, Int, Int)]
pyths n = [(x, y, z) | x <- [2..n], 
                       y <- [2..n], 
                       z <- [2..n], 
                       x^2 + y^2 == z^2]
```

```haskell
> pyths 10
[(3, 4, 5), (4, 3, 5), (6, 8, 10), (8, 6, 10)]
```

## Exercise 6

A positive integer is perfect if it equals the sum of all it's factors, excluding the number itself. Using a list comprehension and the function factors, define a function `perfects :: Int -> [Int]` that returns the list of all perfect number up to a given limit

```haskell
factors :: Int -> [Int]
factors n = [x | x <- [1..n], n `mod` x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum (factors x) - x == x]
```

```haskell
> perfects 500
[6, 28, 496]
```

## Exercise 7

Show how the list comprehension [(x, y) | x <- [1, 2], y <- [3, 4]] with two generators can be re-expressed using two comprehensions with single generators

```haskell
-- One comprehension, two generators
lcEx1 :: [(Integer, Integer)]
lcEx1 = [(x, y) | x <- [1, 2], y <- [3, 4]]

-- Two comprehensions, one generator
lcEx2 :: [(Integer, Integer)]
lcEx2 = concat [[(x, y) | y <- [3, 4]] | x <- [1, 2]]
```

## Exercise 8

Redefine the function positions using the function 'find'

```haskell
-- Original positions function
positions :: Eq a => a -> [a] -> [Int]
positions x xs = [i | (x', i) <- zip xs [0..], x == x']
```

```haskell
-- New positions function
find :: Eq a => a-> [(a, b)] -> [b]
find k t = [v | (k', v) <- t, k' == k]

positions' :: Eq a => a -> [a] -> [Int]
positions' x xs = find x (zip xs [0..])
```

## Exercise 9

The scalar product of two lists of integers xs and ys of length n is given by the sum of the products of corresponding integers:$$\sum_{i=0}^{n-1} (xs_i * ys_i)$$ In a similar manner to chisqr, show how a list comprehension can be used to define a function
 `scalarproduct :: [Int] -> [Int] -> Int` that returns the scalar product of two lists. For example:

 ```haskell
 > scalarproduct [1, 2, 3] [4 ,5, 6]
 32
 ```

```haskell
scalarproduct :: [Int] -> [Int] -> Int
scalarproduct xs ys = sum [x * y | (x, y) <- zip xs ys]
```

## Exercise 10

Modify the Ceasar cipher program to also handle upper-case letters.

```haskell
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
```
