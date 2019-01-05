function [M] = sor_nonuniform(mesh, x_grid, y_grid, w)

%   Performs successive order relaxation on mesh with parameter w, and
%   node spacing specified by y_grid and x_grid.
%   Author: Thomas Christinck, 2018.

    core_height = 0.02;
    core_width = 0.04;
    M = mesh;
    for i = 2:(length(y_grid) - 1)
        for j = 2:(length(x_grid) - 1)
            if y_grid(i) > core_height || x_grid(j) > core_width

            	surround = (M(i - 1, j) + M(i, j - 1) ...
                               + mesh(i + 1, j) + mesh(i, j + 1));
            	old_value = mesh(i, j);
            	new_value = (1 - w) * old_value + w / 4 * surround;
            	M(i,j) = new_value;
            end;
        end;
    end;