% ECSE 543 Assignment 1
% Question 3
% Script for SOR Method/Jacobian Method to solve for R

% For n = 2, ..., 15, we want to find the resistance, R, between the node at the
% bottom left corner of the mesh and the node at the top right corner of the mesh
clear()


w_list = linspace(1,1.9,10);
iteration_list(1:10) = 0;
index = 1;
h = 0.02;
x = 0.06;
y = 0.04;
x_grid = 0;
y_grid = 0;
for w = w_list
	mesh = generate_mesh(h);
	[new_mesh, iterations] = iterate(mesh, h, w,  x_grid, y_grid, 's');
	V = get_potential(new_mesh, x, y, h);
	iteration_list(index) = iterations;
	index = index + 1;
end;

% Plot w:
fprintf('\n Plotting graphs for Omega vs Iterations to Convergence.... \n ')
figure(1)
plot(w_list,iteration_list, 'x')
xlabel('Omega') 
ylabel('Iterations to Convergence')
grid

%clear();
w = 1.25;
x = 0.06;
y = 0.04;
h_list = [0.02 0.01 0.005 0.004 0.002 0.001 0.0008 0.0005];
h_iteration_list(1:8) = 0;
potential_list(1:8) = 0;
invh_list(1:8) = 0;
x_grid = 0;
y_grid = 0;
index = 1;
for h = h_list
	mesh = generate_mesh(h);

	%Change iterate parameter 's' to 'j' to evaluate Jacobian method
	[new_mesh, iterations] = iterate(mesh, h, w, x_grid, y_grid, 's');
	V = get_potential(new_mesh, x, y, h);
	h_iteration_list(index) = iterations;
	potential_list(index) = V;
	invh_list(index) = 1/h;
	index = index + 1;
end;

fprintf('\n Plotting graphs for Potential and Iterations to Convergence vs 1/h.... \n ')
fprintf('\n NOTE default method is SOR - see Q3/test.m to Modify \n ')
figure(2)
plot(invh_list, potential_list, 'x')
xlabel('1/h') 
ylabel('Potential')
grid

figure(3)
plot(invh_list, h_iteration_list, 'x')
xlabel('1/h') 
ylabel('Iterations to convergence')
grid