function[C] = matrix_add_or_subtract(A,B,operation)
%   Function that performs vector/matrix addition/subtraction
%   Matrices A and B must be the same size. Operation should be specified
%   as 's' for subtract and 'a' for add. Returns the result C
%   Author: Thomas Christinck, 2018.

    size_A = size(A);
    size_B = size(B);
    rows_A = size_A(1);
    cols_A = size_A(2);
    rows_B = size_B(1);
    cols_B = size_B(2);
    if rows_A == rows_B & cols_A == cols_B
    
        C(1:rows_A,1:cols_A)=0; 
        if operation == 'a'
            for i = 1:rows_A
                for j = 1:cols_A
                    C(i,j) = A(i,j)+B(i,j);
                end;
            end;
        elseif operation == 's'
             for i = 1:rows_A
                for j = 1:cols_A
                    C(i,j) = A(i,j)-B(i,j);
                end;
            end;
        end;  
    else
       error("The two matrices to be added have to be equal in size")
    end;
