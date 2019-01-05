function [L, first_nonzero, half_bw] = sparse_cholesky(A)

%   Cholesky decomposition algorithm with sparse optimization.
%   [L] = cholesky(A,b) solves the equation A = LL^T. A must be a 
%   symmetric, positive-definite, real matrix. 


%   Author: Thomas Christinck, 2018.
    size_A = size(A);
    length = size_A(1);
    L(1:length,1:length)=0; 
    
    if length ==1
        L = A;
    else
        % Find first non-zero indices for half band width
        first_nonzero(1:length) = length;
        half_bw = 0;
        for i = 1:length
            for j = 1:length
                if A(i,j) ~= 0
                    first_nonzero(i) = j;
                    if (i - j + 1) > half_bw
                        half_bw = i - j + 1;
                    end;
                break
                end;
            end;
        end;

        for i = 1:length
            for k = first_nonzero(i):min(i, half_bw)
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