function [quaternion] = Eaa2Quat(angle,axis)
% Angle expressed in radians
if norm(axis) ~= 1
    axis = axis/norm(axis);
end

if isrow(axis) == 1
   axis = axis'; 
end
quaternion = [cos(angle * 0.5); sin(angle * 0.5) * axis];

end

