function [x] = cholesky(A, b)

    %   Cholesky decomposition algorithm - decomposes and then solves using forward elimination
    %   and back substitution. [x] = cholesky(A,b) solves the equation Ax = b. A must be a 
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

        size_L = size(L);
        length = size_L(1);

        y(1:length)=0;
        for i = 1:length
            sum = 0;
            for j = 1:i
                sum = sum + (L(i, j) * y(j));
            end;
            y(i) = (b(i) - sum) / L(i, i);
        end;

        x(1:length, 1)=0;
        for i = length:-1:1
        sum = 0;
            for j = i:length
                sum = sum + (L(j, i) * x(j));
            end;
            x(i) = (y(i) - sum) / L(i,i);
        end;