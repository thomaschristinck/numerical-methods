function [mesh, iterations] = iterate(mesh, h, w, x_grid, y_grid, mode)

%   Performs residual minimization for mesh with node spacing h using sor 
%   or jacobi method specified as 's' or 'j' in the mode parameter. If sor,
% 	omega is specified by w. For a non-uniform grid using the SOR method, specify 
% 	mode as 'snu' and provide x_grid, y_grid
%   Author: Thomas Christinck, 2018.
	
	threshold = 0.00001;
	iterations = 1;

	% Check if we are using SOR or Jacobi method
	if mode == 's'
		mesh = sor(mesh, h, w);
		while compute_residual(mesh, h) >= threshold 
			mesh = sor(mesh, h, w);
			iterations = iterations + 1;
		end;
	elseif mode == 'j'
		mesh = jacobian(mesh,h) ;
        while compute_residual(mesh,h) >= threshold
            mesh = jacobian(mesh,h);
            iterations = iterations + 1;
        end;
   	elseif mode == 'snu'
		mesh = sor_nonuniform(mesh, x_grid, y_grid, w);
		while compute_res_nonuniform(mesh, x_grid, y_grid) >= threshold  && iterations < 20000
			mesh = sor_nonuniform(mesh, x_grid, y_grid, w);
			iterations = iterations + 1;
		end;
	else
		error("Specify mode as 's' or 'j'!")
	end;
   