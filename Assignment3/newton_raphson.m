function [psi] = newton_raphson()

    % Function that solves the nonlinear equation in 1d) (see paper) to some tolerance, 
    % using the Newton Raphson Method
    
    psi = 0;
    tolerance = 1e-6; 
    hb_data = [0.0 0.0;0.2 14.7; 0.4 36.5;0.6 71.7; 0.8 121.4; 1 197.4; 1.1 256.2; 1.2 348.7; 1.3 540.6; 1.4 1062.8; 1.5 2318.0; 1.6 4781.9; 1.7,8687.4; 1.8 13924.3; 1.9 22650.2];
    i = 0;
    while abs(flux_expression(psi, hb_data)/flux_expression(0, hb_data)) > tolerance %&& i < 10 
    	i = i + 1;
    	psi = psi - (flux_expression(psi, hb_data) / flux_expression_der(psi, hb_data));
    end
    disp("Iterations: ")
    i
    disp("Flux calculated: ")
    psi

    % Now try optimization via successive substitution
    psi_successive_sub = successive_substitution(1e-6, hb_data, tolerance);


	function[flux_ex] = flux_expression(flux, hb_data)
        % Evaluates the expression for flux found in 1d)
		flux_ex = 3.978873577e7 * flux + 0.3 * h_val(flux, hb_data) - 8000;

	function[flux_ex_der] = flux_expression_der(flux, hb_data)
        % Evaluates the expression for flux derivative found in 1d)
		flux_ex_der = 3.978873577e7 + 0.3 * h_der(flux, hb_data)/(1/(100 ^ 2));


	function[h] = h_val(flux, hb_data)
		B = flux / (1.0 / (100 ^ 2));
		[hb_rows, hb_cols] = size(hb_data);
    	% Interpolate for values outside domain
    	if B > hb_data(end,1)
        	slope = (hb_data(end,2) - hb_data(end-1,2)) / (hb_data(end,1) - hb_data(end -1,1));
        	h = (B - hb_data(end, 1)) * slope + hb_data(end, 2);
        	return
		end

    	for i = 1:hb_rows
        	if hb_data(i,1) > B
            	slope = (hb_data(i,2) - hb_data(i-1, 2)) / (hb_data(i, 1) - hb_data(i-1, 1));
            	h = (B - hb_data(i-1,1)) * slope + hb_data(i-1, 2);
            	return
            end
        end
   	 	
   	 	% Must be smaller
        slope = (hb_data(2, 2) - hb_data(1, 2)) / (hb_data(2, 1) - hb_data(1,1));
        h = (B - hb_data(1, 1)) * slope + hb_data(1,2);
        return
        	

    function[h_der] = h_der(flux, hb_data)
		B = flux / (1.0 / (100 ^ 2));
		[hb_rows, hb_cols] = size(hb_data);
    	% Interpolate for values outside domain
    	if B > hb_data(end,1)
        	h_der = (hb_data(end, 2) - hb_data(end-1, 2)) /  (hb_data(end,1) - hb_data(end-1, 1));
        	return
        end

    	for i = 1:hb_rows
        	if hb_data(i,1) > B
            	slope = (hb_data(i,2) - hb_data(i-1, 2)) / (hb_data(i, 1) - hb_data(i-1, 1));
            	h_der = slope;
            	return
            end
        end
 
   	 	% Must be smaller
        slope = (hb_data(2, 2) - hb_data(1, 2)) / (hb_data(2, 1) - hb_data(1,1));
        h_der = slope;
        return

    function[psi] = successive_substitution(psi, hb_data, tolerance)
        i = 0;

        while abs(flux_expression(psi, hb_data) / flux_expression(0, hb_data)) > tolerance
            i = i + 1;

            psi = psi - (6.5e-9) * flux_expression(psi, hb_data);

        end
        disp("------------ Successive substitution ---------------------")
        disp("Iterations: ")
        i
        disp("Flux calculated: ")
        psi
   