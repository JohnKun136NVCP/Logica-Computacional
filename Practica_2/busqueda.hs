busquedaLineal x [] = False
busquedaLineal x (y:ys)
  | x == y =True
  | otherwise = busquedaLineal x ys

half xs = splitAt (length xs `div` 2) xs

compareAt y x xs
  | (xs !! y) == x = 0
  | (xs !! y) < x = -1
  | otherwise = 1

busquedaTempLista x xs ys
  | x == (xs !! (length xs -1)) = 0
  | x <= (xs !! (length xs -1)) = -1  
  | x == (ys !! (length ys -1)) = 0
   | x > (ys !! (length ys -1)) = 1
  
busquedaBinaria :: (Ord a) => a -> [a] -> Maybe Int
busquedaBinaria _ [] = Nothing
busquedaBinaria n xs
  | elem == n = Just indice
  | elem < n  = (+indice) . (+1) <$> busquedaBinaria n bs
  | otherwise = busquedaBinaria n as
  where indice = length xs `quot` 2
        (as,elem:bs) = splitAt indice xs

