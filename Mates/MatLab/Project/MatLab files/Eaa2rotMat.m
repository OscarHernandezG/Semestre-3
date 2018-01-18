function [M] = Eaa2rotMat(v,angle)
% angle in radians
% v has 3 coordinates: x, y and z

unorm = norm(v);

if unorm > 0
    v = v/unorm;
end

if isrow(v) == 1
    v = v';
end

I = eye(3);

V = [0 -v(3) v(2); v(3) 0 -v(1);-v(2) v(1) 0];

M = I*cos(angle)+(1-cos(angle))*(v*v')+V*sin(angle);

end

