function[C] = matrix_multiply(A, B)
%   Function that multiplies two matricies A and B
%   The number of columns in matrix A must equal the number of rows in matrix B. The
%   product matrix, C, is returned.
    
    size_A = size(A);
    size_B = size(B);
    rows_A = size_A(1);
    cols_A = size_A(2);
    rows_B = size_B(1);
    cols_B = size_B(2);

    if cols_A == rows_B
        C(1:rows_A,1:cols_B)=0;
        for i = 1:rows_A
            for j = 1:cols_B
                for k = 1:cols_A
                    C(i,j) = C(i,j) + (A(i, k) * B(k,j));
                end;
            end;
        end;
    else
      error("Cannot multiply the two matrices. Cols_A must equal Rows_B")
    end;
  