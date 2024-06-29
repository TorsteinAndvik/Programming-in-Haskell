# Chapter 7

## Exercise 1

Show how the listcomprehension `[f x | x <- xs, p x]` can be re-expressed using the higher-order function map and filter

```haskell
-- List comprehension
lc1 :: [Int] -> [Int]
lc1 xs = [f x | x <- xs, p x]

-- Higher order functions
lc2 :: [Int] -> [Int]
lc2 = map f . filter p
```

## Exercise 2

Define the following higher-order library functions on lists:

```haskell
-- a. Decide if all elements of a list satisfy a predicate:
all :: (a -> Bool) -> [Bool] -> Bool
all p = and . map p
```

```haskell
-- b. Decide if any element of a list satisfies a predicate:
any :: (a -> Bool) -> [Bool] -> Bool
any p = or . map p
```

```haskell
-- c. Select elements from a list while they satisfy a predicate:
takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' _ []     = []
takeWhile' p (x:xs) = if p x then x : takeWhile' p xs else []
```

```haskell
-- d. Remove elements from a list while they satisfy a predicate:
dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' _ []     = []
dropWhile' p (x:xs) = if p x then dropWhile' p xs else xs
```

## Exercise 3

Redefine the functions ***map f*** and ***filter p*** using ***foldr***.

```haskell
map :: (a -> b) -> [a] -> [b]
map f = foldr (\x y -> f x : y) []
```

```haskell
filter :: (a -> Bool) -> [a] -> [a]
filter p = foldr (\x y -> if p x then x : y else y) []
```

## Exercise 4

Using ***foldl***, define a function `dec2int :: [Int] -> Int` that converts a decimal number into an integer. For example:

```haskell
> dec2int [2, 3, 4, 5]
2345
```

```haskell
dec2int :: [Int] -> Int
dec2int = foldl (\x y -> 10 * x + y) 0
```

```haskell
> dec2int [2, 3, 4, 5]
  
 = (((0 * 10 + 2) * 10 + 3) * 10 + 4 ) * 10 + 5
 = (((2) * 10 + 3) * 10 + 4 ) * 10 + 5
 = ((23) * 10 + 4 ) * 10 + 5
 = (234) * 10 + 5
 = 2345

```

## Exercise 5

Define the higer-order library finction ***curry*** that converts a function on pairs into a curried function, and, conversly, the function ***uncurry*** that converts a curred function with two arguments into a function on pairs.

```haskell
curry' :: ((a, b) -> c) -> (a -> b -> c)
curry' f = \x y -> f (x, y)

uncurry' :: (a -> b -> c) -> ((a, b) -> c)
uncurry' f = \(x, y) -> f x y
```

## Exercise 6

A higher-order function ***unfold*** that encapsulates a simple pattern of recursion for producing a list can be defined as follows:

```haskell
unfold :: (t -> Bool) -> (t -> a) -> (t -> t) -> t -> [a]
unfold p h t x | p x       = []
               | otherwise = h x : unfold p h t (t x)
```

That is, the function `unfold p h t` produces the emtpy list if the predicate ***p*** is true of the argument value, and otherwise produces a non-emtpy list by applying the function ***h*** to this value to give the head, and the function ***t*** to generate another argument that is recursively processed in the same way to produce the tail of the list. For example, the function ***int2bin*** can be rewritten more compactly using unfold as follows:

```haskell
int2bin = unfold (==0) (`mod` 2) (`div` 2)
```

Redefine the functions ***chop8***, ***map f*** and ***iterate f*** using ***unfold***.

```haskell
-- chop8
chop8 :: [Bit] -> [[Bit]]
chop8 = unfold null (take 8) (drop 8)

-- map f
map :: (a -> b) -> [a] -> [b]
map f = unfold null (f . head) tail

-- iterate f
iterate :: (a -> a) -> a -> [a]
iterate f = unfold (const False) f f
```

## Exercise 7

Modify the binary string transmitter example to detect simple tranmission errors using the concept of parity bits. That is, each eight-bit binary number produced during enconding is extended with a parity bit, set to one if the number contains an odd number of ones, and to zero otherwise. In turn, each resulting nine-bit binary number consumed during decoding is checked to ensure that its parity bit is correct, with the parity bit being discarded if this is the case, and a parity error being reported otherwise.

Hint: the library function `error :: String -> a` displays the given string as an error message and terminates the program; the polmorphic result type ensures that ***error*** can be used in any context.

```haskell
import Data.Char
type Bit = Int

bin2int :: [Bit] -> Int
bin2int = foldr (\x y -> x + 2*y) 0

int2bin :: Int -> [Bit]
int2bin 0 = []
int2bin n = n `mod` 2 : int2bin (n `div` 2)

makeByte :: [Bit] -> [Bit]
makeByte bits = take 8 (bits ++ repeat 0)

pbit :: [Bit] -> [Bit]
pbit bits | (even . sum) bits = bits ++ [0]
          | otherwise         = bits ++ [1]

valbit :: [Bit] -> [Bit]
valbit bits = if bits == pbit (init bits) then init bits
              else error "Incorrect parity bit" 

encode :: String -> [Bit]
encode = concatMap (pbit . makeByte . int2bin . ord)

chop :: Int -> [Bit] -> [[Bit]]
chop _ [] = []
chop n bits = take n bits : chop n (drop n bits)

decode :: [Bit] -> String
decode = map (chr . bin2int . valbit) . chop 9

channel :: [Bit] -> [Bit]
channel = id

transmit :: String -> String
transmit = decode . channel . encode
```

## Exercise 8

Test your new string transmitter program from the previous exercise using a faulty communication channel that forgets the first bit, which can be modeled using the tail function on lists of bits.

```haskell
faultyChannel :: [Bit] -> [Bit]
faultyChannel = tail 

faultyTransmit :: String -> String
faultyTransmit = decode . faultyChannel . encode
```

## Exercise 9

Define a function `altMap :: (a -> b) -> (a -> b) -> [a] -> [b]` that alternately applies its two agument functions to successive elements in a list, in turn about order. For example:

```haskell
> altMap (+10) (+100) [0, 1, 2, 3, 4]
[10, 101, 12, 103, 14]
```

```haskell
altMap :: (a -> b) -> (a -> b) -> [a] -> [b]
altMap _ _ [] = []
altMap f g (x:xs) = f x : altMap g f xs
```

## Exercise 10

Using ***altMap***, define a function `luhn :: [Int] -> Bool` that implements the *Luhn algorithm* from the exercises in chapter 4 for bank card numbers of any length. Test your new function using your own bank card.

```haskell
luhn :: [Int] -> Bool
luhn ns = sum (altMap luhnDouble id ns) `mod` 10 == 0
    where luhnDouble = (`mod`9).(*2)
```
