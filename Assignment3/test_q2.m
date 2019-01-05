function[V] = test_q2()

    % Solves the system of nonlinear equations in 2a) (see report) using the Newton
    % Raphson method

    V1 =  0;
    V2 = 0;
    E = 0.2;
    R = 512.0;
    Isa = 0.0000008;
    Isb = 0.0000011;
    V1 = 0.0;
    V2 = 0.0;
    k = 0.025;

    iterations = 0;
    
    V = vector_newton_raphson(Isa,Isb,k,E,R,V1,V2,iterations);
    f1 = V(1,1) - E + R * Isa * (exp((V(1,1) - V(2,1)) / k) - 1.0);
    f2 = Isa * ((exp((V(1,1) - V(2,1)) / k) - 1.0)) - Isb * (exp(V(2,1) / k) - 1.0);

     % Set up storage for errors
    npoints = 10;
    error_list = cell(npoints, 2);

    % Get the error
    fV1 = V(1,1) - E + R * Isa * (exp((V(1,1) - V(2,1)) / k) - 1.0);
    fV2 = Isa * ((exp((V(1,1) - V(2,1)) / k) - 1.0)) - Isb * (exp(V(2,1) / k) - 1.0);
    f01 = -1 * E + R * Isa * (exp(- 1.0));
    f02 = Isa * ((exp(- 1.0)) - Isb * (exp(- 1.0)));
    error_list(1, :) = {1, ((abs(fV1) + abs(fV2)) / (abs(f01) + abs(f02)))}; 
     
    while abs(f1) + abs(f2) > 1e-14
        % Update
        iterations = iterations + 1; 
        V = vector_newton_raphson(Isa,Isb,k,E,R,V(1,1),V(2,1),iterations);
        f1 = V(1,1) - E + R * Isa * (exp((V(1,1) - V(2,1)) / k) - 1.0);
        f2 = Isa * ((exp((V(1,1) - V(2,1)) / k) - 1.0)) - Isb * (exp(V(2,1) / k) - 1.0);

        % Get the error
        fV1 = V(1,1) - E + R * Isa * (exp((V(1,1) - V(2,1)) / k) - 1.0);
        fV2 = Isa * ((exp((V(1,1) - V(2,1)) / k) - 1.0)) - Isb * (exp(V(2,1) / k) - 1.0);
        f01 = -1 * E + R * Isa * (exp(- 1.0));
        f02 = Isa * ((exp(- 1.0)) - Isb * (exp(- 1.0)));
        error_list(iterations + 1, :) = {iterations + 1, ((abs(fV1) + abs(fV2)) / (abs(f01) + abs(f02)))}; 

    end 

    disp("Number of iterations: ")  
    iterations 

    disp("V1 : ")
    V(1,1)
    disp("V2 : ")
    V(2,1)


    error_list(iterations + 1:end, :) = [];
    errors = cell2mat(error_list);
    fprintf('\n Plotting graph for Error... \n ')

    figure(1)
    plot(errors(:, 1), errors(:,2))
    xlabel('Iteration') 
    ylabel('Error')
    grid

    function[V] = vector_newton_raphson(Isa, Isb, k, E, R, V1, V2, iterations)
        % Vectorized Newton Raphson implementation
        f1 = V1 - E + R * Isa * (exp((V1 - V2) / k) - 1.0);
        f2 = Isa * ((exp((V1 - V2) / k) - 1.0)) - Isb * (exp(V2 / k) - 1.0);  
        f1V1Prime = 1.0 + (R * Isa / k) * (exp((V1 - V2) / k));
        f1V2Prime = -1.0 * (R * Isa / k) * (exp((V1 - V2) / k));
        f2V1Prime = (Isa / k) * (exp((V1 - V2) / k));
        f2V2Prime = -1.0 * (Isa / k) * (exp((V1 - V2) / k)) - (Isb / k) * (exp(V2 / k));
        V = [V1; V2];
        f = [f1; f2]; 
        J(1:2,1:2) = 0;
        J(1,1) = f1V1Prime;
        J(1,2) = f1V2Prime;
        J(2,1) = f2V1Prime;
        J(2,2) = f2V2Prime;
        J_inverse = mat_inverse(J);

        negative_product = -1 * matrix_multiply(J_inverse, f);
        V = matrix_add_or_subtract(negative_product, V, 'a');

    function[A_inv] = mat_inverse(A)
    %   Function that inverts a 2 x 2 matrix

        A_det = A(1,1) * A(2,2) - A(1,2) * A(2,1);
        A_inv(1:2, 1:2) = 0;
        A_inv(1,1) = A(2,2) / A_det;
        A_inv(2,2) = A(1,1) / A_det;
        A_inv(1,2) = -1 * A(1,2) / A_det;
        A_inv(2,1) = -1 * A(2,1) / A_det;

    function[C] = matrix_add_or_subtract(A,B,operation)
    %   Function that performs vector/matrix addition/subtraction
    %   Matrices A and B must be the same size. Operation should be specified
    %   as 's' for subtract and 'a' for add. Returns the result C

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

    

     