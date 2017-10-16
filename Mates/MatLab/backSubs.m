function [x] = backSubs(A,b)
% [x] = backSubs(A,b)
% Performs a backsubstitution process over the matrix [A b]
%	to find x such that A*x = b with A upper triangular
% Inputs:
%	A: Upper triangular coefficients matrix
%	b: Independent term
% Outputs:
%	x: Solution of A*x = b

[m,n] = size(A);

x=zeros(m,1)

x(m,1) = b(m,1)/A(m,n)
for i = m-1:-1:1
    x(i,1) = (b(i,1) - A(i,i+1:m) * x(i+1:m)) / A(i,i)
end


end

