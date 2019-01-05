function [potential] = get_potential_nonuniform(mesh, x, y, x_grid, y_grid)
%   Gets the potential in mesh described by x_grid, y_grid at (x,y) 
    x_node = find(x_grid == x);
    y_node = find(y_grid == y);
    potential = mesh(x_node, y_node);

 