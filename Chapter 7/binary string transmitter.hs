import Data.Char
type Bit = Int

bin2int :: [Bit] -> Int
bin2int = foldr (\x y -> x + 2*y) 0

{-
bin2int [1, 0, 1]
 = (x2 + 2 * (x1 + 2 * (x0 + 2 * y))
 = (1 + 2 * (0 + 2 * (1 + 2 * 0)))
 = (1 + 2 * (0 + 2 * (1)))
 = (1 + 2 * (2))
 = (1 + 4)
 = 5
-}

int2bin :: Int -> [Bit]
int2bin 0 = []
int2bin n = n `mod` 2 : int2bin (n `div` 2)

{-
int2bin 5
 = 5 mod 2 : int2bin (5 div 2)
 = 1 : int2bin 2
 = 1 : 2 mod 2 : int2bin (2 div 2)
 = 1 : 0 : int2bin 1 : int2bin (1 div 2)
 = 1 : 0 : 1 mod 2 : int2bin 0
 = 1 : 0 : 1 : []
 = [1, 0, 1]  
-}

make8 :: [Bit] -> [Bit]
make8 bits = take 8 (bits ++ repeat 0)

{-
make8 [1, 0, 1]
= take 8 ([1, 0, 1] ++ repeat 0)
= take 8 ([1, 0, 1] ++ [0, 0, 0, 0, 0])
= [1, 0, 1, 0, 0, 0, 0]
-}

encode :: String -> [Bit]
encode = concat . map (make8 . int2bin . ord)

{-
encode "ab"
concat . map (make8 . int2bin . ord) "ab"
concat . map (make8 . int2bin . ord) ['a', 'b']
concat [(make8 . int2bin . ord) 'a', (make8 . int2bin . ord) 'b']
concat [make8 . int2bin 97), make8 . int2bin 98]
concat [make8 [1,0,0,0,0,1,1]), make8 [0,1,0,0,0,1,1]]
concat [[1,0,0,0,0,1,1,0]), [0,1,0,0,0,1,1,0]]
[1,0,0,0,0,1,1,0,0,1,0,0,0,1,1,0]
-}


chop8 :: [Bit] -> [[Bit]]
chop8 [] = []
chop8 bits = take 8 bits : chop8 (drop 8 bits)

{-
chop8 [1,0,0,0,0,1,1,0,0,1,0,0,0,1,1,0]
take 8 [1,0,0,0,0,1,1,0,0,1,0,0,0,1,1,0] : chop8 (drop 8 [1,0,0,0,0,1,1,0,0,1,0,0,0,1,1,0])
[1,0,0,0,0,1,1,0] : chop8 [0,1,0,0,0,1,1,0]
[1,0,0,0,0,1,1,0] : take 8 [0,1,0,0,0,1,1,0] : chop8 (drop 8 [0,1,0,0,0,1,1,0])
[1,0,0,0,0,1,1,0] : [0,1,0,0,0,1,1,0] : []
[[1,0,0,0,0,1,1,0], [0,1,0,0,0,1,1,0]]
-}

decode :: [Bit] -> String
decode = map (chr . bin2int) . chop8

channel :: [Bit] -> [Bit]
channel = id

transmit :: String -> String
transmit = decode . channel . encode

