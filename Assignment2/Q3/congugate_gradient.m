

function [x] = conjugate_gradient(A, b)
% Find x in Ax = b using the conjugate gradient method
    size_b = size(b);
    x(1:size_b) = 0;
    tolerance = 1.0e-6;
    
    r = b - matrix_multiply(A, x);
    p = r;
    r_old = matrix_multiply(mat_transpose(r), r);

    iteration = 0;
    while sqrt(r_new) > tolerance
        iteration = iteration + 1;
        Ap = matrix_multiply(A, p);

        alpha = r_old / matrix_multiply(mat_transpose(p), Ap);
        x = x + p * alpha;
        r = r - Ap * alpha;

        r_new = matrix_multiply(mat_transpose(r), r);
        p = r + p * (r_new / r_old)

        r_old = r_new;

  
    function[A_T] = mat_transpose(A)
    %   Function that transposes a matrix A and returns the matrix's transpose 
    %   A_T

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