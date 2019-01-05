function [potential] = get_potential(mesh, x, y, h)
%   Gets the potential in mesh with node spacing h at (x,y) 
	cable_height = 0.1;
    cable_width = 0.1;
    node_height = round(cable_height / h + 1);
    node_width = round(cable_width / h + 1);
    x_node = round(node_width - x / h);
    y_node = round(node_height - y / h);
    potential = mesh(y_node, x_node);
	

  