busquedaLineal x [] = False
busquedaLineal x (y:ys)
  | x == y =True
  | otherwise = busquedaLineal x ys

busquedaBinaria x [] = (-1)
busquedaBinaria x (y:ys:yss)
  | x == ys = 1
  | x <= ys = busquedaBinaria x y
  | otherwise = busquedaBinaria x yss
  
