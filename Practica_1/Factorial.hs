factorial :: Integer -> Integer
factorial n = if n == 0 then 1 else n*factorial(n-1)
main = print(factorial 10)