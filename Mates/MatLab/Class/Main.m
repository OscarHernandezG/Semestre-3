
a = [-1/sqrt(5); 2/sqrt(5); 0]
b =  [-3/sqrt(13); 0; 2/sqrt(13)]

q1 = 20;
q2 = -35;

v = [cos(q1/2); sin(q1/2)*a]
u = [cos(q2/2); sin(q2/2)*b]

quaternionproduct(v, u)
