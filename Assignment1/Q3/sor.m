function [M] = SOR(mesh, h, w)

%   Performs successive order relaxation on mesh with parameter w, and
%   node spacing h.
%   Author: Thomas Christinck, 2018.

    core_height = 0.02;
    core_width = 0.04;
    core_potential = 110.0;
    cable_height = 0.1;
    cable_width = 0.1;

    node_height = round((cable_height / h) + 1);
    node_width = round((cable_width / h) + 1);

    for i = 2:node_height - 1
        for j = 2:node_width - 1
            if (i-1) > round(core_height / h) || (j-1) > round(core_width / h)
                mesh(i, j) = (1 - w) * mesh(i, j) + (w / 4) * (mesh(i, j-1) + mesh(i, j+1) + mesh(i-1,j) + mesh(i+1,j));
            end;
        end;
    end;
    M = mesh;
 
