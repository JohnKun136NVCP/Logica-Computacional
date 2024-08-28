square l = 
    if (l!!1**2-4*l!!0*l!!2) >=0 then sqrt(l!!1**2-4*l!!0*l!!2)
    else -1

root1 l = (-l!!1+square l)/(2*l!!0)
root2 l = (-l!!1-square l)/(2*l!!0)
raices l = 
    if  (square l)>0 then [root1 l, root2 l]
    else []
main = print(raices [1,1,1])