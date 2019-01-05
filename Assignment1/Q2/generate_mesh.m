function [I, E, J, R] = generate_mesh(mesh_width)

%   Mesh generation algorithm.
%   Given an N, creates an N x N mesh 
%   Author: Thomas Christinck, 2018.
    
    I = generate_incidence_mat(mesh_width);
    E = generate_E_vector(mesh_width);
    J = generate_J_vector(mesh_width);
    R = generate_R_vector(mesh_width);

    function [I] = generate_incidence_mat(mesh_width)
        % Set up node count (total nodes in mesh), branch count (total branches), and incidence
        % matrix
        % Get N + 1? (more useful, since N x N mesh has (N + 1) ^2 nodes)
        N = mesh_width;
        node_count = N^2;
        branch_count = 2 * (N-1) * (N);
        incidence_matrix(1:node_count, 1:(branch_count + 1)) = 0;
        %num_branches_row = 2 * n - 1
        for i = 1:N
            for j = 1:N
                node_idx = N * (j -1) + i; 
                branch_above = node_idx + (N - 1) * (j - 1);
                branch_below = branch_above - 1;
                branch_left = branch_above - N;
                branch_right = branch_above + N - 1;

                % Now we populate the incidence matrix to describe our mesh. First, check
                % if we're in the far right column. We use the convention +1 for current leaving
                % a node, -1 for entering a node 
   
                if j == N
                    incidence_matrix(node_idx, branch_left) = -1;
                    if i == 1 
                        incidence_matrix(node_idx, branch_above) = 1;
                    elseif i == N
                        incidence_matrix(node_idx, branch_below) = -1;
                    else 
                        incidence_matrix(node_idx, branch_above) = 1;
                        incidence_matrix(node_idx, branch_below) = -1;  
                    end;

                elseif j == 1          
                    incidence_matrix(node_idx, branch_right) = 1;
                    if i == 1
                        incidence_matrix(node_idx, branch_above) = 1;
                    elseif i == N
                        incidence_matrix(node_idx, branch_below) = -1;
                    else
    
                        incidence_matrix(node_idx, branch_above) = 1;
                        incidence_matrix(node_idx, branch_below) = -1;
                    end;
                else
                    incidence_matrix(node_idx, branch_left) = -1;
                    incidence_matrix(node_idx, branch_right) = 1;
                    if i == 1
                        incidence_matrix(node_idx, branch_above) = 1;
                    elseif i == N
                        incidence_matrix(node_idx, branch_below) = -1;
                    else
                        incidence_matrix(node_idx, branch_above) = 1;
                        incidence_matrix(node_idx, branch_below) = -1;
                    end;
                end;
                % Now we connect a voltage source between the bottom left and top right of the mesh.
                incidence_matrix(1,branch_count + 1) = -1;
                incidence_matrix(node_count, branch_count + 1) = 1; 
            end;
        end;

        incidence_matrix_reduced(1:node_count-1, 1:branch_count + 1) = 0;
        for i = 1:(branch_count + 1)
            for j = 1:(node_count - 1)
                incidence_matrix_reduced(j, i) = incidence_matrix(j, i);
            end;
        end;

        I = incidence_matrix_reduced;

    function [E] = generate_E_vector(mesh_width)
        % The E vector will consist of 0 V everywhere except for the last branch, where we will place
        % a 1 V test source
        N = mesh_width;
        branch_count = 2 * N * (N-1);
        E(1:branch_count + 1, 1) = 0;
        E(branch_count + 1, 1) = 1.00 ;

    function [J] = generate_J_vector(mesh_width)
        % The J vector will consist of 0 A everywhere (there are no current sources)
        N = mesh_width;
        branch_count = 2 * N * (N-1);
        J(1:branch_count + 1, 1) = 0;
        
    function [R] = generate_R_vector(mesh_width)
        % There is a 10 kohm resistor connecting all the nodes, except for the last branch where we
        % will place a 1 ohm resistor in series with the test source
        N = mesh_width;
        branch_count = 2 * N * (N-1);
        R(1:branch_count + 1, 1) = 10000;
        R(branch_count + 1, 1) = 1.00;