% ECSE 543 Assignment 1
% Question 1
% Script for Node Voltage solver (for testing)

clear() 

% Real, positive-definite, symmetric matrices A for n= 2,3,..,10 (made
% using the spd_generator. See spd_generator.m)
[A_2] = spd_generator(2);
[A_3] = spd_generator(3);
[A_4] = spd_generator(4);
[A_5] = spd_generator(5);
[A_6] = spd_generator(6);
[A_7] = spd_generator(7);
[A_8] = spd_generator(8);
[A_9] = spd_generator(9);
[A_10] = spd_generator(10);

% Ivented X's (targets) for n = 2,3,...,10
tgt_2 = [1.1; -2.1];
tgt_3 = [-0.6;2.9087;2.008];
tgt_4 = [10000.098;2.098;-1.2809;90];
tgt_5 = [1;2.789;-8.908;3.2098;-0.9087];
tgt_6 = [9;10;2;3;4.07;9.098];
tgt_7 = [-1.5;-9.2;50.90;-90.90;-2.90;-9.90;8.90];
tgt_8 = [1020.904;2000.809;3452.809;-79838.809;83896.836;-3777444.986;8982.834;111111.122];
tgt_9 = [10.905;20.16;390;4674;47;48;9408.09;409;90];
tgt_10 = [1.3;2.6;80.4;67;49;15;46.78;908;600;-900];

% Multily A by our target to get b
[b_2] = matrix_multiply(A_2, tgt_2);
[b_3] = matrix_multiply(A_3, tgt_3);
[b_4] = matrix_multiply(A_4, tgt_4);
[b_5] = matrix_multiply(A_5, tgt_5);
[b_6] = matrix_multiply(A_6, tgt_6);
[b_7] = matrix_multiply(A_7, tgt_7);
[b_8] = matrix_multiply(A_8, tgt_8);
[b_9] = matrix_multiply(A_9, tgt_9);
[b_10] = matrix_multiply(A_10, tgt_10);

% Give A and b to our program and see if it returns x correctly
fprintf('\n Running matrix solver for Ax = b using Cholesky Decomposition for N = 2,...,15 ... \n')
[L_2] = cholesky(A_2);
[y_2, X_2] = forwardelim_backsub(L_2, b_2);

[L_3] = cholesky(A_3);
[y_3, X_3] = forwardelim_backsub(L_3, b_3);

[L_4] = cholesky(A_4);
[y_4, X_4] = forwardelim_backsub(L_4, b_4);

[L_5] = cholesky(A_5);
[y_5, X_5] = forwardelim_backsub(L_5, b_5);

[L_6] = cholesky(A_6);
[y_6, X_6] = forwardelim_backsub(L_6, b_6);

[L_7] = cholesky(A_7);
[y_7, X_7] = forwardelim_backsub(L_7, b_7);

[L_8] = cholesky(A_8);
[y_8, X_8] = forwardelim_backsub(L_8, b_8);

[L_9] = cholesky(A_9);
[y_9, X_9] = forwardelim_backsub(L_9, b_9);

[L_10] = cholesky(A_10);
[y_10, X_10] = forwardelim_backsub(L_10, b_10);

% Check differences between targets and actual outputs X
% error tolerance is arbitrarily chosen as 1.0e-07
e = 1.0e-2;
dif_2 = abs(tgt_2 - X_2) <= e;
dif_3 = abs(tgt_3 - X_3) <= e;
dif_4 = abs(tgt_4 - X_4) <= e;
dif_5 = abs(tgt_5 - X_5) <= e;
dif_6 = abs(tgt_6 - X_6) <= e;
dif_7 = abs(tgt_7 - X_7) <= e;
dif_8 = abs(tgt_8 - X_8) <= e;
dif_9 = abs(tgt_9 - X_9) <= e;
dif_10 = abs(tgt_10 - X_10) <= e;


if all(dif_2) && all(dif_3) && all(dif_4) && all(dif_5) && all(dif_6) && all(dif_7) && all(dif_8) && all(dif_9) && all(dif_10)
	fprintf("\n Target 'X' and solution vectors are all equal!\n")
else
	fprintf("\nAt least one of the matrices in not equal to its target!\n")
end;


clear()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 		PART 4 - VOLTAGE SOLVER 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% We will use the example circuits provided on mycourses. These examples were transcribed to a .csv file
% called circuit_data.csv, where for an incidence matrix of size m x n, the first n columns consist of m
% entries of the incidence matrix. The n + 1th column is blank, and each of the 3 proceding columns consist 
% of the n entries of the E, J, R matrices


[I_1, E_1, J_1, R_1] = csv_matrix(0,0,0,1);
[I_2, E_2, J_2, R_2] = csv_matrix(2,2,0,1);
[I_3, E_3, J_3, R_3] = csv_matrix(4,4,0,1);
[I_4, E_4, J_4, R_4] = csv_matrix(6,7,0,3);
[I_5, E_5, J_5, R_5] = csv_matrix(10,12,0,5);

fprintf("\n %%%%%%%%%%%%%% VOLTAGE SOLVER %%%%%%%%%%%%%%%%\n")
fprintf("\n Ordered node voltages for circuit 1:\n")
[V_1] = voltage_solver(I_1, E_1, J_1, R_1)
fprintf("\n Ordered node voltages for circuit 2:\n")
[V_2] = voltage_solver(I_2, E_2, J_2, R_2)
fprintf("\n Ordered node voltages for circuit 3:\n")
[V_3] = voltage_solver(I_3, E_3, J_3, R_3)
fprintf("\n Ordered node voltages for circuit 4:\n")
[V_4] = voltage_solver(I_4, E_4, J_4, R_4)
fprintf("\n Ordered node voltages for circuit 5:\n")
[V_5] = voltage_solver(I_5, E_5, J_5, R_5)
