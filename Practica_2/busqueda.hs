-- Regresa verdadero o falso, buscando elemento por elemento
busquedaLineal x [] = False
busquedaLineal x (y:ys)
  | x == y =True
  | otherwise = busquedaLineal x ys

-- Regresa el indice si el elemento se encuentra en la lista  
busquedaBinaria :: (Ord a) => a -> [a] -> Maybe Int
busquedaBinaria _ [] = Nothing
busquedaBinaria n xs
  | elem == n = Just indice
  | elem < n  = (+indice) . (+1) <$> busquedaBinaria n bs
  | otherwise = busquedaBinaria n as
  where indice = length xs `quot` 2
        (as,elem:bs) = splitAt indice xs

l = [1,2,3,4,5,5,6,7,8,8]
ejemploLineal = busquedaLineal 2 l
ejemploBinaria = busquedaBinaria 5 l

main :: IO ()
main = do

  print(l)
  print(ejemploLineal)
  print(ejemploBinaria)
  
