function[A] = spd_generator(length)
%	Function that creates a random symmetric positive definite 
%	matrix A, given a length input.
	for i = 1:length
		for j = 1:i
			L(i,j) = 10 * rand();
		end;
	end;
	A(1:length,1:length)=0;
    A = matrix_multiply(L, mat_transpose(L)); 

	function[T_T] = mat_transpose(T)
	% 	Function that transposes a matrix A and returns the matrix's transpose 
	%	A_T

	%   Author: Thomas Christinck, 2018.
  		size_T = size(T);
    	rows_T = size_T(1);
    	cols_T = size_T(2);
  
  		T_T(1:cols_T,1:rows_T)=0;
    	for i = 1:cols_T
        	for j = 1:rows_T
            	T_T(i,j) = T(j,i);
            
        	end;
    	end;

    function[D] = matrix_multiply(B, C)
	%   Function that multiplies two matricies A and B
	%   The number of columns in matrix A must equal the number of rows in matrix B. The
	%   product matrix, C, is returned.
    
    	size_B = size(B);
    	size_C = size(C);
    	rows_B = size_B(1);
    	cols_B = size_B(2);
    	rows_C = size_C(1);
    	cols_C = size_C(2);

    	if cols_B == rows_C
       	 	D(1:rows_B,1:cols_C)=0;
        	for i = 1:rows_B
            	for j = 1:cols_C
                	for k = 1:cols_B
                   	 	D(i,j) = D(i,j) + (B(i, k) * C(k,j));
                	end;
            	end;
        	end;
    	else
      		error("Cannot multiply the two matrices. Cols_A must equal Rows_B")
    	end;


