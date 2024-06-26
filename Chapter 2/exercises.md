# Chapter 2

## Exercise 1

Work trough the examples from this chapter using GHCi

    Done.

## Exercise 2

Parenthesise the following numeric expressions:

    2 ^ 3 * 4       =   (2 ^ 3) * 4
    2 * 3 + 4 * 5   =   (2 * 3) + (4 * 5)
    2 + 3 * 4 ^ 5   =   2 + (3 * (2 ^ 3))

## Exercise 3

The script below contains three syntactic errors. Correct and them check that your script works properly using GHCi.

```haskell
-- function with errors
N = a 'div' length xs
    where
        a = 10
        xs = [1, 2, 3, 4, 5]    
```

---

1. Function names must start with a lower case letter.
2. Funtions written between arguments must be enclosed in single back quotes.
3. Wrong indentation on last line.

---

```haskell
-- function without errors
n = a `div` length xs
    where
        a = 10
        xs = [1, 2, 3, 4, 5]
```

## Exercise 4

The library function `last` selects the last element of a non-emtpy list: for example, `last [1, 2, 3, 4, 5] = 5`. Show how the function `last` could be defined in terms of the other library functions introdueced in this chaper. Can you think of another possible definition?

```haskell
> last [1, 2, 3, 4, 5]
5
```

```haskell
lastAlt2 ns = head (reverse ns)
lastAlt3 ns = ns !! (length ns - 1)
lastAlt4 ns = sum ns - sum (take (length ns - 1) ns)
lastAlt5 ns = sum (drop (length ns - 1) ns)
```

## Exercise 5

The library function `init` removes the last element from a non-empty list; for example, `init [1, 2, 3, 4, 5] = [1, 2, 3, 4]`. Show how `init` could similarly be defined in two different ways

```haskell
> init [1, 2, 3, 4, 5]
[1, 2, 3, 4]
```

```haskell
initAlt2 ns = take (length ns - 1) ns
initAlt3 ns = reverse (tail (reverse ns))
```
