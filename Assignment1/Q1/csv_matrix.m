function[I, E, J, R] = csv_matrix(row_start, row_end, col_start, col_end)
    % Reads a csv file into incidence matrix I, voltage source matrix E, current
    % source matrix J, and resistance matrix R. Must specify where in the csv the 
    % incidence matrix is specified.
    file_name = 'circuit_data.csv';
    EJR_column = col_end + 2;
    I = csvread(file_name, row_start, col_start, [row_start, col_start, row_end, col_end]);
    E = csvread(file_name, row_start, EJR_column, [row_start,EJR_column,row_start+col_end,EJR_column]);
    J = csvread(file_name, row_start, EJR_column + 1, [row_start,EJR_column + 1,row_start+col_end,EJR_column + 1]);
    R = csvread(file_name, row_start, EJR_column + 2, [row_start,EJR_column + 2,row_start+col_end,EJR_column + 2]);