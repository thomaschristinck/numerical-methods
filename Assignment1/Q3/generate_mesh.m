function [M] = generate_mesh(h)

%   Generates mesh with initial boundary conditions (considering 1/4 of the problem,
%   due to symmetry)
%   Author: Thomas Christinck, 2018.

    core_height = 0.02;
    core_width = 0.04;
    core_potential = 110.0;
    cable_height = 0.1;
    cable_width = 0.1;

    node_height = round((cable_height / h) + 1);
    node_width = round((cable_width / h) + 1);
    % First, we'll set up the mesh with Dirichlet conditions.
    mesh(1:node_height, 1:node_width) = 0;
    for i = 1:node_height
        for j = 1:node_width
            if (j - 1) <= (core_width / h) && (i - 1) <= (core_height / h)
                mesh(i, j) = core_potential;
            end;
        end;
    end;

    % Consider the Neumann boundary conditions
    delta_x = 110 * h / (cable_width - core_width);
    delta_y = 110 * h / (cable_height - core_height);
    for k = (round(core_width / h) + 2):(node_width - 1)
        mesh(1, k) = mesh(1, k-1) - delta_x;
    end;
    for l = (round(core_height / h) + 2):(node_height - 1)
        mesh(l, 1) = mesh(l-1, 1) - delta_y;
    end;
    M = mesh;

     
    