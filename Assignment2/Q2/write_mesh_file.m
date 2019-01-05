function mesh_file = write_mesh_file()
	% Writes a file 'toSimple2D.txt' describing the mesh in problem 2, that
	% can be interpreted by SIMPLE2D_M.m

	output_file = fopen('toSimple2D.txt','w');


	y_nodes = 6;
	x_nodes = 5;
	potential = 110.0;
	bounds(1:(y_nodes - 1)) = 0;
	for i = 1:(y_nodes - 1)
		bounds(i) = i;
	end;

	mesh(1:x_nodes, 1:y_nodes) = 0;
	for i = 1:x_nodes
		for j = 1:y_nodes
			mesh(i,j) = ((j + 4) + (i-1) * y_nodes);
		end;
	end;

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Section one of input file (node #, x coordinate, y coordinate)
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	for i = 1:(y_nodes - 2)
		nbytes = fprintf(output_file, '%5.2f %5.2f %5.2f \n', bounds(i), (i + 1) * 0.02, i * 0.0);
	end;

	for x = 1:x_nodes
		for y = 1:y_nodes
        	nbytes = fprintf(output_file, '%5.2f %5.2f %5.2f \n', mesh(x,y), (y - 1) * 0.02, (x) * 0.02);
    	end;
	end;

	nbytes = fprintf(output_file, '\n');

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Section two of input file (mesh node 1 -> node 2 -> node 3 - 0):
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	for i = 1:(y_nodes - 3)
		nbytes = fprintf(output_file, '%5d %5d %5d %6.2f \n', bounds(i), bounds(i + 1), mesh(1, i + 2), 0.0);
		nbytes = fprintf(output_file, '%5d %5d %5d %6.2f\n', bounds(i + 1), mesh(1, i + 3), mesh(1, i + 2), 0.0);
	end;

	for x = 1:(x_nodes - 1)
    	for y = 1:(y_nodes - 1)
    		nbytes = fprintf(output_file, '%5d %5d %5d %6.2f \n', mesh(x,y), mesh(x, y + 1), mesh(x + 1, y), 0.0);
			nbytes = fprintf(output_file, '%5d %5d %5d %6.2f \n', mesh(x, y + 1), mesh(x + 1, y + 1), mesh(x + 1, y), 0.0);
		end;
	end;

	nbytes = fprintf(output_file, '\n');

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Section three of input file (nodes with boundary conditions):
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	% Get boundary conditions outside the rectangular mesh
	nbytes = fprintf(output_file,'%5d %5d \n', 1, potential);
	nbytes = fprintf(output_file,'%5d %5d \n', 4, 0.00); 

	for i = 1:y_nodes
    	if mesh(1,i) < 8
    		nbytes = fprintf(output_file,'%5d %5d \n', mesh(1,i), potential);
        end;
    end;
	for i = 1:y_nodes
		nbytes = fprintf(output_file,'%5d %5.2f \n', mesh(x_nodes, i), 0.00);
 	end;
	for i = 1:x_nodes
		nbytes = fprintf(output_file,'%5d %5.2f \n', mesh(i, y_nodes), 0.00);
    end;

	fclose(output_file);
