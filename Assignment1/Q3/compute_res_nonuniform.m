function [max_res] = compute_res_nonuniform(mesh, x_grid, y_grid)

%   Computes the maximum residual for mesh with non-uniform node-spacing
%   Author: Thomas Christinck, 2018.

    core_height = 0.02;
    core_width = 0.04;
    max_res = 0;

    for i = 2:(length(y_grid)- 1)
        for j = 2:(length(x_grid) - 1)
            if x_grid(j) > core_width || y_grid(i) > core_height
                % Calculate the residual of the free points

                res = abs(mesh(i - 1, j) + mesh(i, j - 1) + mesh(i + 1, j) ...
                        + mesh(i, j + 1) - (4 * mesh(i, j)));
                res = abs(res);
                

                if res > max_res
                    max_res = res;
                end;
            end;
        end;
    end;