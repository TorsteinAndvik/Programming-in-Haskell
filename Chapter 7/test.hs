import Data.Char
type Bit = Int

-- 2. Define higher-order functions

-- a. Decide if all elements of a list satisfy a predicate:
--all :: (a -> Bool) -> [Bool] -> Bool
--all p = and . map p

-- b. Decide if any element of a list satisfies a predicate:
--any :: (a -> Bool) -> [Bool] -> Bool
--any p = or . map p
 
 -- c. Select elements from a list while they satisfy a predicate:
takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' _ [] = []
takeWhile' p (x:xs) = if p x then x : takeWhile' p xs else []

-- d. Remove elements from a list while they satisfy a predicate:
dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' _ []     = []
dropWhile' p (x:xs) = if p x then dropWhile' p xs else xs


-- 3. map and filter functions using foldr

map' :: (a -> b) -> [a] -> [b]
map' f = foldr (\x y -> f x : y) []

filter :: (a -> Bool) -> [a] -> [a]
filter p = foldr (\x y -> if p x then x : y else y) []


-- 4. dec2int function using foldl

dec2int :: [Int] -> Int
dec2int = foldl (\x y -> 10 * x + y) 0


-- 5. curried and uncurried function definitions
curry' :: ((a, b) -> c) -> (a -> b -> c)
curry' f = \x y -> f (x, y)

uncurry' :: (a -> b -> c) -> ((a, b) -> c)
uncurry' f = \(x, y) -> f x y

-- 6. Redefine the functions chop8, map f and iterate f using unfold
unfold :: (t -> Bool) -> (t -> a) -> (t -> t) -> t -> [a]
unfold p h t x | p x       = []
               | otherwise = h x : unfold p h t (t x)

chop8' :: [Bit] -> [[Bit]]
chop8' = unfold null (take 8) (drop 8)

map'' :: (a -> b) -> [a] -> [b]
map'' f = unfold null (f . head) tail

iterate' :: (a -> a) -> a -> [a]
iterate' f = unfold (const False) f f

-- 7. Modified string transmitter

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


-- 8 Testing faulty transmission

faultyChannel :: [Bit] -> [Bit]
faultyChannel = tail 

faultyTransmit :: String -> String
faultyTransmit = decode . faultyChannel . encode

-- 9. Alternate mapping function
altMap :: (a -> b) -> (a -> b) -> [a] -> [b]
altMap _ _ [] = []
altMap f g (x:xs) = f x : altMap g f xs


-- 10. luhn algorithm
luhn :: [Int] -> Bool
luhn ns = sum (altMap luhnDouble id ns) `mod` 10 == 0
            where luhnDouble = (`mod`9).(*2)
