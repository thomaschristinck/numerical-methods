function [L] = cholesky(A)

%   Cholesky decomposition algorithm.
%   [L] = cholesky(A,b) solves the equation A = LL^T. A must be a 
%   symmetric, positive-definite, real matrix. 


%   Author: Thomas Christinck, 2018.
    size_A = size(A);
    length = size_A(1);
    L(1:length,1:length)=0; 
    
    if length ==1
        L = A;
    else
        for i = 1:length
            for k = 1:i 
                sum = 0;
                if A(i,k) ~= A(k,i)
                    error("The matrix needs to be symmetric")
                end;
                for j = 1:k
                    sum = sum + (L(i,j) * L(k,j));
                end;    
                if (i == k)
                    if ((A(i,i) - sum)) < 0
                        error("The matrix needs to be positive definite")
                    end;
                    L(i,k) = sqrt(abs(A(i,i) - sum));
                else 
                    L(i,k) = (A(i,k) - sum) / L(k,k);
                end;
            end;
        end;
    end;







