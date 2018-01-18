function [R] = Quat2RotMat(q)

if norm(q) ~= 1
    q = q/norm(q);
end

% Rotation angle
angle = acos(q(1));

sin_t = sin(angle);

angle = angle * 2;

% Rotation axis
u = q(2:4)/sin_t; 

% Calculate rotation matrix
R = Eaa2rotMat(u,angle);

end