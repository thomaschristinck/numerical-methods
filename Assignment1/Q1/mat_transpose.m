function[A_T] = mat_transpose(A)
% 	Function that transposes a matrix A and returns the matrix's transpose 
%	A_T

%   Author: Thomas Christinck, 2018.
  	size_A = size(A);
    rows_A = size_A(1);
    cols_A = size_A(2);
  
  	A_T(1:cols_A,1:rows_A)=0;
    for i = 1:cols_A
        for j = 1:rows_A
            A_T(i,j) = A(j,i);
            
        end;
    end;
