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
aux =2;
aux2 = 0;
    for p = 1:1:m
        for j = aux:1:n   
            aux2 = A(j, p);
    A(j,:) = A(j,:) * A(p, p) - A(p,:) * aux2;
    b(j,:) = b(j,:) * A(p, p) - b(p,:) * aux2;
        end
        aux = aux+1;
    end
    
    At = A
    bt = b
    
end

