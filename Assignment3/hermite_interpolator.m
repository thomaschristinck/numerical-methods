function [y_test] = hermite_interpolator()
% Interpolate using cubic Hermite polynomials

    hb_data = [0.0 0.0;0.2 14.7; 0.4,36.5;0.6 71.7; 0.8 121.4; 1 197.4; 1.1 256.2; 1.2 348.7; 1.3 540.6; 1.4 1062.8; 1.5 2318.0; 1.6 4781.9; 1.7,8687.4; 1.8 13924.3; 1.9 22650.2];
    X = hb_data([1 9 10 13 14 15],1);
    Y = hb_data([1 9 10 13 14 15],2);
    x_test = 0:(1.9/99):1.9;
    y_test(1:100) = 0;
    y_test = interpolate(x_test, X, Y);


    figure(2)
    plot(y_test, x_test)
    legend("interpolated curve")
    hold on
    plot(Y, X, 'x')
    title('Cubic-Hermite Polynomial Interpolation')
    legend("interpolated curve", "data points", 'location', 'southeast')  
    hold off
    xlabel('H (A/m)') 
    ylabel('B (T)')
    grid 

    function[coefficients] = get_coefficients(x0, x1, y0, y1, dy0, dy1)
        A = [x0^3 x0^2 x0 1.0;
            x1^3 x1^2 x1 1.0;
            (3 * x0^2) (2 * x0) 1.0 0.0;
            (3 * x1^2) (2 * x1) 1.0 0.0];
        b = [y0; y1; dy0; dy1];
        disp("Matrix solver")
        coefficients = mat_solve(A, b);
    
    function[coefficient_matrix] = get_coefficient_matrix(X, Y)
        % Returns a coefficient matrix for the given X and Y (with rows
        % specified by get_coefficients function)
        dy1 = 0;
        [X_rows, X_cols] = size(X);
        coefficient_matrix(1:(X_rows -1), 1:4) = 0;
        for i = 1:X_rows - 1 
            x0 = X(i, 1);
            x1 = X(i + 1, 1);
            y0 = Y(i, 1);
            y1 = Y(i + 1, 1);

            % Derivative approximation
            dy0 = dy1;
            dy1 = (y1 - y0) / (x1 - x0);

            coefficient_matrix(i,:) = get_coefficients(x0, x1, y0, y1, dy0, dy1);
        end;

    function[x] = mat_solve(A, b)
    % Matrix solver for non-symmetric matrices
        det = 1;
        [A_rows, A_cols] = size(A);
        [b_rows, b_cols] = size(b);
        for i = 1:A_rows - 1 
            k = i;
            for j=i + 1:A_rows 
                if abs(A(j, i)) > abs(A(k, i))
                    k = j;
                end
            end
            if k ~= i
                % If k is not equal to i, then transpose ith entry and kth 
                % entry of A and b
                A([i k],:)=A([k i],:)
                b([i k]) = b([k i]);
                det = -1 * det;
            end

            for j = (i + 1):A_rows 
                t = A(j, i) / A(i, i);
                for k = (i + 1): A_rows
                    A(j, k) = A(j,k) - t * A(i, k);
                end
                for k = 1: b_cols
                    b(j, k) = b(j, k) - t * b(i, k);
                end
            end
        end

        for i = A_rows:-1:1
            for j=i + 1: A_rows
                for k=1:b_cols
                    b(i, k) = b(i,k) - A(i, j) * b(j, k);
                end
            end
            t = 1.0 / A(i, i);
            det = det * A(i, i);
            for j=1:b_cols
                b(i, j) = b(i, j) * t;
            end
        end

        x = b;


    function[y] = apply(coefficient_matrix, x)
    %   Apply coefficients to x to get y
        [rows_x, cols_x] = size(x);
        x = [x.^3 x^2 x 1.0];
        % Dot product of the coefficient matrix with x
        y = coefficient_matrix .* x;
        y = sum(y);
    

    function[y] = interpolate(x_test, X, Y)
        [rows_x_test, cols_x_test] = size(x_test);
        [rows_X, cols_X] = size(X);
        coefficient_matrix = get_coefficient_matrix(X, Y);
        y(1:rows_x_test, 1:cols_x_test) = 0;
        for i = 1:cols_x_test
            for j = 1:rows_X - 1
                if x_test(:,i) <= X(j + 1, 1)
                    break;
                end;
            end;
            y(:,i) = apply(coefficient_matrix(j,:), x_test(:,i));
        end


