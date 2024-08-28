andOp :: Bool -> Bool -> Bool
andOp x y = 
    if x == True then
        (if y == True then True else False)
    else False

main = print(andOp True True)
