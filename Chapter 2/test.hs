-- 3. Corrected n-function
n = a `div` length xs
    where
        a = 10
        xs = [1, 2, 3, 4, 5]

-- 4. Alternative last functions
--last [1, 2, 3, 4, 5] = 5
lastAlt2 ns = head (reverse ns)
lastAlt3 ns = sum ns - sum (take (length ns-1) ns)
lastAlt4 ns = ns !! (length ns -  1)
lastAlt5 ns = sum (drop (length ns - 1) ns)

-- 5. Alternative init functions
init [1, 2, 3] = [1, 2]
-- init [1, 2, 3, 4, 5] = [1, 2, 3, 4]
initAlt2 ns = take (length ns - 1) ns
initAlt3 ns = reverse (tail (reverse ns))