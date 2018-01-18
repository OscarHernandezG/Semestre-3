function [alpha, beta, gamma] = rotM2eAngles(R)

if R(3,1) == 1
    
    beta = -pi/2;
     alpha = 0;
     gamma = asin(-R(1,2));
     
elseif R(3,1) == -1
    
     beta = pi/2;
     alpha = 0;
     gamma = -asin(R(1,2));
     
else
    
    beta = asin(-R(3,1));
    temp = cos(beta);
    alpha = atan2(R(3,2)/temp, R(3,3)/temp);
    gamma = atan2(R(2,1)/temp, R(1,1)/temp);
    
end