function [axis, angle] = rotMat2Eaa(R)
% Calculate euler principal axis and angle from the provided rotation matrix

Ry = [-1, 0, 0; 0, 1, 0; 0, 0, -1];
Rz = [-1, 0, 0; 0, -1, 0; 0, 0, 1];

axis = [0; 0; 0];

if (Ry(1, 1) == R(1, 1)) && (Ry(2, 2) == R(2, 2)) && (Ry (3, 3) == R(3, 3))
    
   angle = pi; 
   axis = [0; 1; 0];
   
elseif (Rz(1, 1) == R(1, 1)) && (Rz(2, 2) == R(2, 2)) && (Rz(3, 3) == R(3, 3))
    
    angle = pi; 
    axis = [0; 0; 1];
    
else 
    
angle = acos((trace(R) - 1) / 2);
temp = (R - R.')/(2 * sin(angle));

end

if angle == 0
    
    axis = [0; 0; 0];
  
elseif angle == pi
    
   v1 = sqrt((R(1, 1) + 1) / 2);
   v2 = (R(1, 2) / 2) / v1;
   v3 = (R(1, 3) / 2) / v1;
    
   axis = [v1; v2; v3];
   
else
    
axis = [temp(3, 2); temp(1, 3); temp(2, 1)];


end

end