function [A, b] = generate_matrix(h)
    
    mesh = generate_mesh(h)
    
    core_height = 0.02;
    core_width = 0.04;
    core_potential = 110.0;
    cable_height = 0.1;
    cable_width = 0.1;

    node_height = floor((cable_height / h) + 1);
    node_width = floor((cable_width / h) + 1);
 
    core_node_height = floor(core_height / h + 1);
    core_node_width = floor(core_width / h + 1);
    free_node = (node_height * node_width) - (core_node_height * core_node_width) - (node_height + node_width) + 1;
    
    A(1:free_node, 1:free_node) = 0;
    b(1:free_node) = 0;   
    
    for x = 1:node_width
        for y = 1: node_height
            node = mesh(x, y);
            A(node, node) = -4.0;
            % Down
            if y > 1
                node_down = mesh(x, y - 1);
                A(node, node_down) = 1;
                if node == 1
                    A(node, node_down) = 2;
                    b(node + 1) = -1 * core_potential;
                end;
                if node_down == 4 || node_down == 9 || node_down == 14
                    A(node, node_down) = 2;
                end;
            end;
            % Up
            if y < node_height
                node_up = mesh(x, y + 1);
                A(node, node_up) = 1;
                if node == 1
                    A(node, node_up) = 2;
                    b(node) = -1 * core_potential;
                end;
            end;
            % Left 
            if x > 1
                node_left = mesh(x - 1, y);
                A(node, node_left) = 1
                if node == 14 || node == 9
                    A(node, node_left] = 2 
                end;
                if node_left == 0 || node_left == 1
                    A(node, node_left) = 2
                end;
            end;
            % Right
            if x < node_width
                node_right = mesh(x + 1, y);
                A(node, node_right) = 1;
                if node == 4 || node == 9
                        A(node, node_right) = 2;
                        if node == 4
                            b(node) = -1 * core_potential;
                            b(node + 1) = -1 * core_potential;
                            b[cord + 2] = -1 * core_potential;
                        end;
                end;
            end;
