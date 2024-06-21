# Chapter 3

## Exercise 1

What are the types of the following values:

    ['a', 'b', 'c']             :: [char]
    ('a', 'b', 'c')             :: (char, char, char)
    [(False, '0'), (True, '1)]  :: [(Bool, char)]
    ([False, True], ['0', '1']) :: ([a], [a])
    [tail, init, reverse]       :: [[a] -> [a]]

## Exercise 2

Write down the definitions that have the following types; it does not matter what the definitions actually do as long as they are tupe correct

* `bools :: [Bool]`
  * `bools = [True, False, True]`
  * `bools = [False]`
* `nums :: [[Int]]`
  * `nums = [[0, 1], [5, 2], [3, 6, 6]]`
  * `nums = [[-1]]`
* `add :: Int -> Int -> Int -> Int`
  * `add a b c = a + b + c`
  * `mult x y z = x * y * z`
* `copy :: a -> (a, a)`
  * `copy a = (a, a)`
* `apply :: (a -> b) -> a -> b`
  * `apply f x = f x`

## Exercise 3

What are the types of the following functions

```haskell
second xs = head (tail xs)
second :: [a] -> a

swap (x, y) = (y, x)
swap :: (a, b) -> (b, a)

pair x y = (x, y)
pair :: a -> b -> (a, b)

double x = x * 2
double :: Num a => a -> a

palindrome xs = reverse xs == xs
palindrome :: Eq a => [a] -> Bool

twice f x = f (f x)
twice :: (a -> a) -> a -> a
```

## Exercise 4

Check your answers to the preceding three questions using GHCi

    Done

## Exercise 5

Why is it not feasible in general for function types to be instances of the Eq class? When is it feasible?

    Functions can take very different types of inputs. To compare the functions, you would need to compare the outputs for all possible inputs. 

    In cases with functions with finite domains or simple, well defined functions, it is possible to compare functions for equality.
