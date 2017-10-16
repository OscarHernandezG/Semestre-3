a =[1 2 3;4 5 6; 5 7 8]
b = [8;5;1]


[At, bt] = ownTriangulation(a,b)
[x] = backSubs(At,bt)


a =[0 2 3;0 2 -2; 1 1 2]
b = [14;-1;8]

[flag,At1,bt] = ownTriangulationPartialPivoting(a,b)


At
At1
flag
 