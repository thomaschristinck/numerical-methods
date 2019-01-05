% ECSE 543 Assignment 1
% Question 3 e)
% Script for SOR Method with nonuniform mesh to solve for R

% For n = 2, ..., 15, we want to find the resistance, R, between the node at the
% bottom left corner of the mesh and the node at the top right corner of the mesh

clear()
w = 1.25;
x = 0.06;
y = 0.04;

% Grid spacing
x_grid = [0 0.01 0.02 0.03 0.04 0.052 0.06 0.069 0.08 0.09 0.1];
y_grid = [0 0.01 0.02 0.031 0.04 0.05 0.06 0.07 0.08 0.09 0.1];


% A dummy h for testing
w = 1.25;
h = 0.01;

mesh_u = generate_mesh(h);
mesh_nu = generate_mesh_nonuniform(x_grid, y_grid);
[new_mesh_u, iterations_u] = iterate(mesh_u, h, w, x_grid, y_grid, 's');
[new_mesh_nu, iterations_nu] = iterate(mesh_nu, h, w, x_grid, y_grid, 'snu');
fprintf('\n Potential with uniform spacing (h = 0.01): \n ')
V_u = get_potential(new_mesh_u, x, y, h)
fprintf('\n Potential with nonuniform spacing (11 nodes, equivalent to h = 0.01): \n ')
V_nu = get_potential_nonuniform(new_mesh_nu, x, y, x_grid, y_grid)
