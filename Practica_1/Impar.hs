impar1 x = odd x
impar2 x = not (even x)


impar3:: Integer -> Bool
impar3 0 = False
impar3 1 = True
impar3 x = impar3 (x-2)
