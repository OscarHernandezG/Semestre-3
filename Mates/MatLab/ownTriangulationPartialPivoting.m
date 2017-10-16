function [flag, At, bt]= ownTriangulationPartialPivoting(A,b)
% [At,bt] = ownTriangulationPartialPivoting(A,b)
% Performs a forward elimination proces over the matrix [A b]
%	such that A*x = b and At*x = bt share the same solution x
%	with partial pivoting
% Inputs:
%	A: Coefficients matrix
%	b: Independent term
% Outputs:
%	flag: Flag = 0 -> The system of LE has a unique solution
%	      Flag = 1 -> The system of LE has infinite or has not a solution		 
%	At: Upper triangular matrix
% 	bt: Modified independent term

[n,m] = size(A)
aux = 2;
aux2 = 0;
flag=0;
condition = 0;
    for p = 1:1:m
        for j = aux:1:n  
            
            while condition == 0
                if A(p,p) ~= 0
                   condition = 1 
                
                else 
                    aux3 =  A(j,:);
                    A(j,:) = A(p,:);
                    A(p,:) = aux3;
                    
                    aux3 =  b(j,:);
                    b(j,:) = b(p,:);
                    b(p,:) = aux3;
                end  
                if A(p,p) == 0 && A(j,p) == 0 
                   condition = 1; 
                   flag = 1;
                end
            end
                
                aux2 = A(j, p); 
                
                A(j,:) = A(j,:) * A(p, p) - A(p,:) * aux2
                b(j,:) = b(j,:) * A(p, p) - b(p,:) * aux2
            end
            aux = aux+1;

        end
    

        
    At = A
    bt = b
    
end


