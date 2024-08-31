anterior 0 = error "No hay numero natural menor a 0"
anterior x
  | x >= 1 = x - 1
  | otherwise = error "No hay numero natural menor a 0"

