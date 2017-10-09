function [At, bt]= ownTriangulation(A,b)
% [At,bt] = ownTriangulation(A,b)
% Performs a forward elimination proces over the matrix [A b]
%	such that A*x = b and At*x = bt share the same solution x
% Inputs:
%	A: Coefficients matrix
%	b: Independent term
% Outputs:
%	At: Upper triangular matrix
% 	bt: Modified independent term

[n,m] = size(A)
r =2;
    for p = 1:1:m
        for j = r:1:n
    A(j,:) = A(j,:) * A(p, p) - A(p,:) * A(j, p)
    b(j,:) = b(j,:) * A(p, p) - b(p,:) * A(j, p)
        end
        r = r+1;
    end
end

