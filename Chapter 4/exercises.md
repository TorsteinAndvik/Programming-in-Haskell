# Chapter 4

## 1. Using library functions, define `halve :: [a] -> ([a], [a])` that splits an even-lengthed list into two halves

```haskell
halve :: [a] -> ([a], [a])
halve xs = (take n xs, drop n xs)
    where
        n = length xs `div` 2

halve':: [a] -> ([a], [a])
halve' xs = splitAt n xs
    where
        n = length xs `div` 2

```

## 2. Define function `third :: [a] -> a` that returns the third element in a list that contains at least this many elements using

```haskell
-- a. head and tail
    third :: [a] -> a
    third xs = head (tail (tail  xs))

-- b. list indexing !!
    third' :: [a] -> a
    third' xs = xs !! 2

-- c. pattern matching
    third'' :: [a] -> a
    third'' (_: _: x:_) = x
```

## 3. Consider a function `safetail :: [a] -> [a]` that behaves in the same way as tail except that it maps the empty lit to itselft rather than prodcing an error. Using tail and the function `null :: [a] -> Bool` that decides if a list is empty or not, define safetail using

```haskell
    -- a. A conditional expression
        safetail :: [a] -> [a]
        safetail xs = if not(null xs) then tail xs else []

    -- b. guarded equations
        safetail' :: [a] -> [a]
        safetail' xs | null xs   = []
                    | otherwise = tail xs

    -- c. pattern matching
        safetail'' :: [a] -> [a]
        safetail'' [] = []
        safetail'' (_:xs) = xs
```

## 4. In a similar way to && in section 4.4, show how the disjunction operator || can be defined in four different ways using pattern matching

```haskell
(||) :: Bool -> Bool -> Bool
True  || True  = True
True  || False = True
False || True  = True
False || False = False


(||) :: Bool -> Bool -> Bool
True  || _ = True
False || b = b


(||) :: Bool -> Bool -> Bool
False || False = False
_     || _     = True


(||) :: Bool -> Bool -> Bool
b || c | b == c    = b
        | otherwise = True 
```

## 5. Without using any other library functions or operators, show how the meaning of the following pattern matching definition for logical conjunction && can be formalised using conditional expressions. Hint: use two nested conditional expressions

```haskell
-- Logical conjunction definition with pattern matching
True && True = True
_    && _    = False

-- Logical conjunction definition with nested conditionals
a && b = if a then (if b then True else False) else False
```

## 6. Do the same for the following alternative definintion, and note the difference in the number of conditional expressions that are required

```haskell
True && b = b
True && _ = False

a && b = if a then b else False
```

## 7. Show how the meaning of the following curried function definition can be formalised in terms of lambda expressions

```haskell
mult :: Int -> Int -> Int -> Int
mult x y z = x * y * z

mult :: Integer -> Integer -> Integer -> Integer
mult = \x -> (\y -> (\z -> x * y * z))
```

## 8 The Luhn algorithm is used to check bank card numbers for simple errors such as mistyping a digit. Define a `LuhnDouble :: Int -> Int` that doubles a digit and subtracts 9 if the result is greater than 9

```haskell
luhnDouble :: Int -> Int
luhnDouble n | n * 2 > 9   = n * 2 - 9
             | otherwise = n * 2

luhn :: Int -> Int -> Int -> Int -> Bool
luhn a b c d = (luhnDouble a + b + luhnDouble c + d) `mod` 10 == 0
```

```haskell
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
```
