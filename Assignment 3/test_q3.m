function [y] = test_q3()

    % Solves a series of integrals numerically via one-point Gauss-Legendre integration
    % Integrals are specified in the report (see report question 3).

    disp('----------------------- Even integrals --------------------')
    disp("Integral of sin(x) from 0 to 1 is 0.45970")
    error_list_a = cell(10, 2);
    for i = 1:20 
        target = 0.45970;
        y =  get_integral(@sin, 1, i, 0, 1);
        error_list_a(i, :) = {log10(i),  log10(abs(y - target))}; 
        fprintf("i is %d \n Integral is %.4f \n Error is %.4f \n\n", i, y, abs(y - target));
    end

    % Plot error graph
    errors_a = cell2mat(error_list_a);
    fprintf('\n Plotting graph for Error a... \n ')
    figure(1)
    plot(errors_a(:, 1), errors_a(:,2))
    xlabel('log(N)') 
    ylabel('log(abs(Error))')
    title('Approximation Error for sin(x) Integral')
    grid

    disp("Integral of ln(x) from 0 to 1 is -1")
    error_list_b = cell(10, 2);
    for i = 1:20  
        target = -1;
        y =  get_integral(@log, 1, i * 10, 0, 1);
        error_list_b(i, :) = {log10(10 * i),  log10(abs(y - target))}; 
        fprintf("i is %d \n Integral is %.4f \n Error is %.4f \n\n", i * 10, y, abs(y - target));
    end

     % Plot error graph
    errors_b = cell2mat(error_list_b);
    fprintf('\n Plotting graph for Error b... \n ')
    figure(2)
    plot(errors_b(:, 1), errors_b(:,2))
    xlabel('log(N)') 
    ylabel('log(abs(Error))')
    title('Approximation Error for ln(x) Integral')
    grid

    disp("Integral of ln(0.2(|sin(x)|) from 0 to 1 is -2.66616")
    error_list_c = cell(10, 2);
    for i = 1:20  
        target = -2.66616;
        y =  get_integral(@sin, @log, i, 0, 1);
        error_list_c(i, :) = {log10(10 * i),  log10(abs(y - target))}; 
        fprintf("i is %d \n Integral is %.4f \n Error is %.4f \n\n", i * 10, y, (y - target));
    end

    % Plot error graph
    errors_c = cell2mat(error_list_c);
    fprintf('\n Plotting graph for Error c... \n ')
    figure(3)
    plot(errors_c(:, 1), errors_c(:,2))
    xlabel('log(N)') 
    ylabel('log(abs(Error))')
    title('Approximation Error for ln(0.2(|sin(x)|) Integral')
    grid

    disp('----------------------- Uneven integrals --------------------')
    disp("Integral of ln(x): ");   
    y =  get_uneven_integral(@log, 1, 0, 1);
    target = -1;
    fprintf("Integral is %.4f \n Error is %.4f \n\n", y, (y - target));
    disp("Integral of ln(0.2(|sin(x)|): ") 
    y = get_uneven_integral(@sin, @log, 0, 1);
    target = -2.66616;
    fprintf("Integral is %.4f \n Error is %.4f \n\n", y, (y - target));

    function [sum_approximation] = get_integral(f1, f2, n, a, b)
        % Approximates the function f2(f1) using n points from a to b
        % f1 and f2 should be function handles
        sum_approximation = 0;
        segments = linspace(a,b,n);
        if ~isa(f2,'function_handle')
            for i = 1:n-1
                lower_limit = segments(i);
                higher_limit = segments(i+1);
                sum_approximation = sum_approximation + (higher_limit - lower_limit) * f1((higher_limit + lower_limit) / 2.0);
            end
        else
            for i = 1:n-1
                lower_limit = segments(i);
                higher_limit = segments(i+1);
                sum_approximation = sum_approximation + (higher_limit - lower_limit) * f2(0.2 * f1((higher_limit + lower_limit)/2.0));
            end
        end

    function [sum_approximation] = get_uneven_integral(f1, f2, a, b)
        % Approximates the function f2(f1) using points from a to b
        % f1 and f2 should be function handles
        % First we want the relative widths between points. We use a relative width scale of
        % [2^0, 2^1, ...., 2^9] for
        relative_widths(1:10) = 0;
        for i = 0:9
            relative_widths(i+1) = 2^i;
        end
        scale = (b - a) / sum(relative_widths);
        [widths_rows, widths_len] = size(relative_widths);
        widths(1:widths_len) = 0;
        for i = 1:widths_len
            widths(i) = relative_widths(i) * scale;
        end
        width = 0;
        sum_approximation = 0;

        if ~isa(f2,'function_handle')

            for i = 1:widths_len
                sum_approximation = sum_approximation + f1(widths(i)/2 + width) * widths(i);
                width = width + widths(i);
            end
        else
            for i = 1:widths_len
                % f2(0.2(|f1(x)|) - in this question f2 is ln(), f1 is sin()
                sum_approximation = sum_approximation + f2(0.2 * abs(f1(widths(i)/2 + width))) * widths(i);
                width = width + widths(i);
            end

        end
        

        



    