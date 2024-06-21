# Chapter 1

## Exercise 1

Give another possible calculation for the result `double (double 2)`

### Calcultation 1

    double (double 2)
    = {applying the inner double}
    double (2 + 2)
    = {applying the +}
    double 4
    = {applying the double}
    4 + 4
    = {applying the +}
    8

### Calculation 2

    double (double 2)
    = {applying the outer double}
    double 2 + double 2
    = {applying the first double}
    2 + 2 + double 2
    = {applying the +}
    4 + double 2
    = {applying the double}
    4 + (2 + 2)
    = {applying the second +}
    4 + 4
    = {applying the +}
    8

## Exercise 2

Show that `sum [x] = x` for any number x

    By definition:
        sum [] = 0
        sum (n:ns) = n + sum ns

---
    sum [x]
    = {applying sum}
    x + sum []
    = {applying sum}
    x + 0
    = {applying +}
    x

## Exercise 3

Define a function `product` that produses the product of a list of numbers, and show using your definition that `product [2, 3, 4] = 24`

```haskell
product' :: Num a => [a] -> a
product' [] = 1
product' (n:ns) = n * product' ns
```

## Exercise 4

How should the definition of the function `qsort` be modified so that it produces a reverse sorted version of a list?

```haskell
-- Original sort function
    qsort :: Ord a => [a] -> [a]
    qsort [] = []
    qsort (x:xs) = qsort smaller ++ [x] ++ qsort larger
        where 
            smaller = [a | a <- xs, a <= x]
            larger  = [a | a <- xs, a > x]

-- Reversed sort function
    rqsort :: Ord a => [a] -> [a]
    rqsort [] = []
    rqsort (x:xs) = rqsort larger ++ [x] ++ rqsort smaller
        where 
            smaller = [a | a <- xs, a < x]
            larger  = [a | a <- xs, a > x]
```

## Exercise 5

What would be the effect of replacing <= by < in the original definition of qsort?

    The function would exclude all other numbers equal to x, which would be similar to removing all duplicates in the list.
