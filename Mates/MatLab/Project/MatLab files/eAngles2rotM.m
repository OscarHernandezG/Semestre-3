function [M] = eAngles2rotM(alpha,beta,gamma)
% Returns the rotation matrix of the euler angles
% angles are expressed in radians


if sin(beta) == -1
    a = alpha + gamma;
    M = [0, -sin(a), -cos(a); 0, cos(a), -sin(a); 1, 0, 0];
      
    
else if sin(beta) == 1
    a = alpha - gamma;
    M = [0, sin(a), cos(a); 0, cos(a), -sin(a); -1, 0, 0];
    
else
    ct = cos(beta);
    st = sin(beta);
    
    cph = cos(alpha);
    sph = sin(alpha);
    
    cps = cos(gamma);
    sps = sin(gamma);
    
    M = [ct * cps, cps * st * sph - cph * sps, cps * cph * st + sps * sph;
         ct * sps, sps * st * sph + cph * cps, sps * st * cph - cps * sph;
         -st, ct * sph, ct * cph];
      
end

end