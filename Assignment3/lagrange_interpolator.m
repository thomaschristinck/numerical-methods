function [y_test] = lagrange_interpolator()
% Lagrange interpolator
    

    hb_data = [0.0 0.0;0.2 14.7; 0.4,36.5;0.6 71.7; 0.8 121.4; 1 197.4; 1.1 256.2; 1.2 348.7; 1.3 540.6; 1.4 1062.8; 1.5 2318.0; 1.6 4781.9; 1.7,8687.4; 1.8 13924.3; 1.9 22650.2];
    X = hb_data(1:6,1);
    Y = hb_data(1:6,2);
    x_test = 0:(1.9/99):1.9;

    y_test = interpolate(x_test, X, Y);

    figure(1)
    plot(y_test, x_test)
    legend("interpolated curve")
    hold on
    plot(Y, X, 'x')
    legend("interpolated curve", "data points", 'location', 'southeast')
    title('Full-domain Lagrange Polynomial Interpolation')  
    hold off
    xlabel('H (A/m)') 
    ylabel('B (T)')
    grid 

    X = hb_data([1 9 10 13 14 15],1);
    Y = hb_data([1 9 10 13 14 15],2);

    y_test = interpolate(x_test, X, Y);


    figure(2)
    plot(y_test, x_test)
    legend("interpolated curve")
    hold on
    plot(Y, X, 'x')
    title('Full-domain Lagrange Polynomial Interpolation')
    legend("interpolated curve", "data points", 'location', 'southeast')  
    hold off
    xlabel('H (A/m)') 
    ylabel('B (T)')
    grid 


    function[y] = multiplier(j, x_test, X)
    %   Function that finds the multiplier given row index and x_test
        [rows_x_test, cols_x_test] = size(x_test);
        [rows_X, cols_X] = size(X);
        if rows_x_test > 1 || cols_x_test > 1
            y(1:rows_x_test, 1:cols_x_test) = 1;
        else
            y = 1.0;
        end
        for i = 1:rows_X
            if i == j
                continue
            end
            check = (x_test - X(i, 1)) / (X(j,1) - X(i, 1));
            y = y .* (x_test - X(i, 1)) / (X(j,1) - X(i, 1));
        end

    function[y] = interpolate(x_test, X, Y)
        [rows_x_test, cols_x_test] = size(x_test);
        [rows_X, cols_X] = size(X);
        if rows_x_test > 1 || cols_x_test > 1
            y(1:rows_x_test, 1:cols_x_test) = 1;
        else
            y = 1.0;
        end
        for j = 1:rows_X
            y = y + multiplier(j, x_test, X) * Y(j, 1);
        end
       





