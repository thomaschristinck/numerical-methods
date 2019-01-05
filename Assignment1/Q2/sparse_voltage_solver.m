%#Solves the (AYA^T)Vn = A(J_YE) Equation with sparse optimizations
function[V, half_bw] = sparse_voltage_solver(incident_matrix, E, J, R)
    %Equation to solve: (A*Y*A^T)Vn = A(J-Y*E)
    %step_1 = Y*E
    %Step_2 = J-Step_1
    %Step_3 = A*Step_2
    %Step_4 = A^T
    %Step_5 = Y*Step_4
    %Step_6 = A*Step_5    
    
    %Gives B    
    Y = diag_mat(R);
    step_1 = matrix_multiply(Y, E);
    step_2 = matrix_add_subtract(J,step_1,'s');
    step_3 = matrix_multiply(incident_matrix,step_2);
    
    % Gives A
    step_4 = mat_transpose(incident_matrix);
    step_5 = matrix_multiply(Y, step_4);
    step_6 = matrix_multiply(incident_matrix,step_5);
    
    % Now we want to compute the voltage
    [step_7a_s, first_nonzero, half_bw] = sparse_cholesky(step_6);
    % Forward elim solves for y in Ly =b  Ly = 100, Lx = y
    % Back sub for x in L^T X = y
    [step_7b_s, step_7c]  = sparse_fwdelim_bcksub(step_7a_s, step_3, first_nonzero);
    V = step_7c;
    %V_s = step_7c_s;

    

    function[D] = diag_mat(A)
        size_A = size(A);
        row_len = size_A(1);

        D(1:row_len,1:row_len)=0;

        for i = 1:row_len
            if A(i) ~= 0
                D(i,i) = 1/A(i);
            else
                D(i,i) = 0;
            end;
        end;


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

    function[C] = matrix_add_subtract(A,B,operation)
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
        if rows_A == rows_B && cols_A == cols_B
            %rows_A == rows_B && cols_A == cols_B
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
            else   
                error("Invalid operation. Must be 'a' or 's'")
            end;
        else
            error("The two matrices to be added have to be equal inn size!!")
        end;

    function[y, x] = sparse_fwdelim_bcksub(L, b, first_nonzero)
    %   Function that performs bth forward elimination and back substitution
    %   i.e. in forward elimination it solves for y in Ly = b and in back
    %   substitution it solves for x in L^Tx = y

    %   Author: Thomas Christinck, 2018.
        size_L = size(L);
        length = size_L(1);

        y(1:length)=0;
        for i = 1:length
            sum = 0;
            for j = first_nonzero(i):i
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

    function [L, first_nonzero, half_bw] = sparse_cholesky(A)

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
            for k = first_nonzero(i):i 
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
