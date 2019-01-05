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

    cableHeight = 0.1
    cableWidth = 0.1
    coreHeight = 0.02
    coreWidth = 0.04
    corePot = 110.0
    mesh = genMesh(0.02)
    
    nodeHeight = (int)(cableHeight/h + 1)
    nodeWidth = (int)(cableWidth/h + 1)
    coreHeightNode = (int)(coreHeight/h + 1)
    codeWidthNode = (int)(coreWidth/h + 1)
    freeNode = (nodeHeight * nodeWidth) - (coreHeightNode * codeWidthNode) - (nodeHeight + nodeWidth) + 1
    
    A = [[0 for x in range (freeNode)] for y in range (freeNode)]
    b = [0 for x in range(freeNode)]    
         
    for y in range (nodeHeight):
        for x in range (nodeWidth):
            if (mesh[y][x][0] != None):
                cord = mesh[y][x][0]
                cordRight = mesh[y][x + 1][0]
                cordLeft = mesh[y][x - 1][0]
                cordUp = mesh[y + 1][x][0]
                cordDown = mesh[y - 1][x][0]
                A[cord][cord] = -4.0
                #print (cord, cordLeft, cordRight, cordUp, cordDown)
                #right
                if (cordRight != None):
                    A[cord][cordRight] = 1
                    if (cord == 0):
                        A[cord][cordRight] = 2
                        b[cord] = -corePot           
                #left
                if (cordLeft != None):
                    A[cord][cordLeft] = 1
                    if (cord == 1):
                        A[cord][cordLeft] = 2
                        b[cord + 1] = -corePot
                    if (cordLeft == 4 or cordLeft == 9 or cordLeft == 14):
                        A[cord][cordLeft] = 2
                #up
                if (cordUp != None):
                    A[cord][cordUp] = 1
                    if (cord == 4 or cord == 9):
                        A[cord][cordUp] = 2
                        if (cord == 4):
                            b[cord] = -corePot
                            b[cord + 1] = -corePot
                            b[cord + 2] = -corePot
                #down
                if (cordDown != None):
                    A[cord][cordDown] = 1
                    if (cord == 14 or cord == 9):
                        A[cord][cordDown] = 2 
                    if (cordDown == 0 or cordDown == 1):
                        A[cord][cordDown] = 2
    
    return (A,b)

     