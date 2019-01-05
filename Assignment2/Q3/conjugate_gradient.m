function [x] = conjugate_gradient(A, b)
    % Find x in Ax = b using the conjugate gradient method
    size_b = size(b);
    x(1:size_b(1), 1) = 0;
    tolerance = 1.0e-6;
    
    r = b - matrix_multiply(A, x);
    p = r;
    r_old = matrix_multiply(mat_transpose(r), r);
    r_new = r_old;
    iteration = 1;

    % Set up storage for norms
    npoints = 10000;
    inf_norm_list = cell(npoints, 2);
    l2_norm_list = cell(npoints, 2);
     

    while sqrt(r_new) > tolerance
        Ap = matrix_multiply(A, p);

        alpha = r_old / matrix_multiply(mat_transpose(p), Ap);
        x = x + p * alpha;
        r = r - Ap * alpha;

        r_new = matrix_multiply(mat_transpose(r), r);
        p = r + p * (r_new / r_old);

        r_old = r_new;
        
        size_r = size(r);
        squares_sum = 0;
        inf_norm = 0;
        for i = 1:size_r(1)
            % Update norms
            squares_sum = squares_sum + r(i)^2;
            inf_norm = max(abs(r(i)), inf_norm);
        end;
        l2_norm = sqrt(squares_sum);
        inf_norm_list(iteration, :) = {iteration, inf_norm};
        l2_norm_list(iteration, :) = {iteration, l2_norm};
        iteration = iteration + 1;
    end;
    inf_norm_list(iteration:end, :) = [];
    l2_norm_list(iteration:end, :) = [];

    l2_norms = cell2mat(l2_norm_list);
    inf_norms = cell2mat(inf_norm_list);

    fprintf('\n Plotting graphs for L2 and Infinity Norms... \n ')

    figure(1)
    plot(l2_norms(:, 1), l2_norms(:,2))
    xlabel('Iteration') 
    ylabel('L2 Norm of Residual')
    grid

    figure(2)
    plot(inf_norms(:, 1), inf_norms(:,2))  
    xlabel('Iteration') 
    ylabel('Infinity Norm of Residual')
    grid 

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