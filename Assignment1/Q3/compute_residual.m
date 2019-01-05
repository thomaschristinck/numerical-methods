function [max_res] = compute_residual(mesh, h)

%   Computes the maximum residual for mesh with node spacing h
%   Author: Thomas Christinck, 2018.

    core_height = 0.02;
    core_width = 0.04;
    cable_height = 0.1;
    cable_width = 0.1;
    node_height = round((cable_height / h) + 1);
    node_width = round((cable_width / h) + 1);
    max_res = 0;

    for i = 2:node_height - 1
        for j = 2:node_width - 1
            if (i-1) > (core_height / h) || (j-1) > (core_width / h)
                % Calculate the residual of the free points
                res = mesh(i, j-1) + mesh(i, j+1) + mesh(i-1, j) + mesh(i+1, j) - 4 * mesh(i, j);
                res = abs(res);
                if res > max_res
                    max_res = res;
                end;
            end;
        end;
    end;

