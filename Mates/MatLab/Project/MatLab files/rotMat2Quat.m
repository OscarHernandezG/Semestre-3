function [quaternion] = rotMat2Quat(M)
% [q] = rotMat2Quat(R)
% Given a rotation matrix it returns its respective quaternion
%Initialize threshold
Th = 1E-7;
Mry = [-1, 0, 0; 0, 1, 0; 0, 0, -1];
Mrz = [-1, 0, 0; 0, -1, 0; 0, 0, 1];
if Mry(1,1) == M(1,1) && Mry(2,2) == M(2,2) && Mry(3,3) == M(3,3)
   quaternion = [0; 0; 1; 0];
   
elseif Mrz(1,1) == M(1,1) && Mrz(2,2) == M(2,2) && Mrz(3,3) == M(3,3)
    quaternion = [0; 0; 0; 1];

else
    if trace(M) - 1<Th
        angle = pi;
    else
        angle = acos((trace(M) - 1) * 0.5);
    end

t = (M-M.')/(2 * sin(angle));

if angle == 0
    axis = [0;0;0];

elseif angle == pi
   u = sqrt((M(1,1)+1) * 0.5);
   v = (0.5 * M(1,2))/u;
   w = (0.5 * M(1,3))/u;
    
   axis = [u; v; w];
   
else
axis = [t(3,2); t(1,3); t(2,1)];

end
    
quaternion = [cos(angle/2); sin(angle/2) * axis];
quaternion = quaternion/norm(quaternion);
end
end