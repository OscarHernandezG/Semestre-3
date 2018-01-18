function [p] = Calculate3Dpoint(x, y, r)
% Calculates the mouse 3D coordinates on the surface of the sphere based on
% its x and y coordinates on the screen

if (x * x + y * y) < 0.5 * r * r
    p = [x, y, sqrt(r * r - x * x - y * y)]';
else
    p = [x, y, r * r/(2 * sqrt(x * x + y * y))]';
    p = r * p/norm(p);
end

end