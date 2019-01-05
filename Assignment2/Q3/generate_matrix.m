function [A, b] = generate_matrix(num_free_nodes)
    
    % Generates a finite difference mesh with the given number of free nodes.
    % This program is not portable and will only work for Problems in this
    % assignment.
   
    A(1:num_free_nodes, 1:num_free_nodes) = 0;
    b(1:num_free_nodes, 1) = 0;

    for i = 1:(num_free_nodes)
        A(i, i) = -4;

        % Look for nodes connected on the right
        if mod(i + 1, 5) ~= 0 && i ~= 2 && i ~= 19
            A(i + 1, i) = 1;
        end;
        % Nodes connected on the top
        if i >= 3 && i <=14
            A(i + 5, i) = 1;
        elseif i == 1 || i == 2
            A(i + 2, i) = 1;
        end;
        % Ndes connected on the bottom
        if i >= 8
            A(i - 5, i) = 1;
        elseif i == 3 || i == 4
            A(i - 2, i) = 2;
        end;
        % Nodes connected on the left
        if mod(i, 5) ~= 0 && i ~= 3 && i ~= 1
            A(i - 1, i) = 1;
        end;
        if mod(i - 1, 5) == 0 && i ~= 1 
            A(i - 1, i) = 2;
        end;
        if i == 1 || i == 3 || i == 5 || i == 6 || i == 7
            b(i) = -110.0;
        end;
    end;