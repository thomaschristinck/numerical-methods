function [M] = generate_mesh_nonuniform(x_grid, y_grid)

%   Generates mesh with initial boundary conditions (considering 1/4 of the problem,
%   due to symmetry)
%   Author: Thomas Christinck, 2018.

    core_height = 0.02;
    core_width = 0.04;
    core_potential = 110.0;
    cable_height = 0.1;
    cable_width = 0.1;

    % First, we'll set up the mesh 
    for i = 1:length(y_grid)
        for j = 1:length(x_grid)
            if x_grid(j) <= (core_width) && y_grid(i) <= (core_height)
                mesh(i, j) = core_potential;
            else
                mesh(i, j) = 0;
            end;
        end;
    end;
    % Consider the Neumann boundary conditions
    delta_x = core_potential / (cable_width - core_width);
    delta_y = core_potential / (cable_height - core_height); 
    for x = 1:length(x_grid)
        if x_grid(x) > core_width
            mesh(1, x) = core_potential - delta_x * (x_grid(x) - core_width);
        end;
    end;
    for y = 1:length(y_grid)
        if y_grid(y) > core_height
            mesh(y, 1) = core_potential - delta_y * (y_grid(y) - core_height);  
        end;
    end;

    M = mesh;