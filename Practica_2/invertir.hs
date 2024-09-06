--Fucion que regresa una lista en orden inverso
inversa [] = []
inversa (x:xs) = inversa xs ++ [x]

l = [1,2,3,4]

ejemplo = inversa l

main :: IO ()
main = do
  print(l)  
  print(ejemplo)
