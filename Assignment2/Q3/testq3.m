% ECSE 543 Assignment 2
% Question 3
% Script for Conjugate Gradient Node Voltage solver (for testing)

% Generate the matrix problem
[A,b] = generate_matrix(19)

%   UNCOMMENT TO CHECK POSITIVE DEFINITENESS
%disp("\n--------Positive Definite Check -------------\n")
%cholesky_x = cholesky(A,  b);

disp("-------- Cholesky Decomposition Solution -------------")
% We first take the matrix and make it positive definite and symmetric by multiplying
% both sides by A^T.
cholesky_x = cholesky(matrix_multiply(mat_transpose(A), A),  matrix_multiply(mat_transpose(A), b))

disp("-------- Conjugate Gradient Solution -------------")
conjugate_grad_x = conjugate_gradient(A, b)


disp("-------- Error -------------")
error = (abs(conjugate_grad_x - cholesky_x))

    
fprintf("Value at (0.06, 0.04) (Cholesky): %6.4f V \n", (cholesky_x(12, 1)))
fprintf("Value at (0.06, 0.04)  (CG): %6.4f V \n", (conjugate_grad_x(12, 1)))

% Compute the capacitance.
U_sum = conjugate_grad_x(2, 1) / 2;
U_sum = U_sum + conjugate_grad_x(4, 1) + conjugate_grad_x(9, 1) + conjugate_grad_x(14, 1);
U_sum = U_sum + conjugate_grad_x(19, 1) * 2;
U_sum = U_sum + conjugate_grad_x(16, 1) + conjugate_grad_x(17, 1) + conjugate_grad_x(18, 1);
U_sum = U_sum + conjugate_grad_x(15, 1) / 2;
U_sum = U_sum *  4
Q = 8.854e-12 * U_sum;
C = Q / 110.0;
 
fprintf("Total capacitance: %5.3f pF/m \n", C * 1e12)

