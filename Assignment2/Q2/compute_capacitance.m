function C = compute_capacitance(file)
% Function to compute capacitance per unit length. SIMPLE2D_M has been 
% modified to return the global S-matrix, which is used in determining the
% total energy in the mesh.

[Potential, S] = SIMPLE2D_M(file);

% Potential pot = 110 V, U vector consists of potential at all nodes
pot = 110;
U = Potential(:, 4);
W = 0.5 * matrix_multiply(mat_transpose(U), matrix_multiply(S, U));

% Calculates the Capacitance per length (we multiply by 4 because there
% are 4 quadrants)
e0 = 8.854187817620e-12;
V2 = pot * pot;
C = e0 *(2 * W / V2) * 4;

  function[C] = matrix_multiply(A, B)
  %   Function that multiplies two matricies A and B
  %   The number of columns in matrix A must equal the number of rows in matrix B. The
  %   product matrix, C, is returned.
    
      size_A = size(A);
      size_B = size(B);
      rows_A = size_A(1);
      cols_A = size_A(2);
      rows_B = size_B(1);
      cols_B = size_B(2);

      if cols_A == rows_B
          C(1:rows_A,1:cols_B)=0;
          for i = 1:rows_A
              for j = 1:cols_B
                  for k = 1:cols_A
                      C(i,j) = C(i,j) + (A(i, k) * B(k,j));
                  end;
              end;
          end;
      else
          error("Cannot multiply the two matrices. Cols_A must equal Rows_B")
      end;
  
  function[A_T] = mat_transpose(A)
  %   Function that transposes a matrix A and returns the matrix's transpose 
  % A_T

  %   Author: Thomas Christinck, 2018.
      size_A = size(A);
      rows_A = size_A(1);
      cols_A = size_A(2);
  
      A_T(1:cols_A,1:rows_A)=0;
      for i = 1:cols_A
          for j = 1:rows_A
              A_T(i,j) = A(j,i);
            
          end;
      end;