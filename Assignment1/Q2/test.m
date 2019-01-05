% ECSE 543 Assignment 1
% Question 2
% Script for Node Voltage solver

% For n = 2, ..., 15, we want to find the resistance, R, between the node at the
% bottom left corner of the mesh and the node at the top right corner of the mesh
clear()

trials = 15;
r(1:trials-1) = 0;
t(1:trials-1) = 0;

% Solve meshes up to N specified by 'trials' with unoptimized method
for N = 2:trials
	[I, E, J, R] = generate_mesh(N);
	tic;
	[V] = voltage_solver(I, E, J, R);
	t(N-1) = toc;
	
	%V(1) = Req x Vtest / (Rtest + Req) and so Req = V(1) x Rtest / (Vtest - V(1));
	R = V(1) / (1.00 - V(1));
	r(N-1) = R;
end;

clearvars -except t trials

t_s(1:trials-1) = 0;
r(1:trials-1) = 0;

% Solve meshes up to N specified by 'trials' with sparse optimized method
for N = 2:trials
	[I, E, J, R] = generate_mesh(N);
	tic;
	[V, half_bw] = sparse_voltage_solver(I, E, J, R);
	t_s(N-1) = toc;

	%V(1) = Req x Vtest / (Rtest + Req) and so Req = V(1) x Rtest / (Vtest - V(1));
	R = V(1) / (1.00 - V(1));
	r(N-1) = R;
end;


% Plot graphs :

fprintf('\n Plotting graphs for R vs N and Computation Time vs N.... \n ')

x = 2:trials;

% Plot R:
figure(1)
plot(x,r, 'x')
xlabel('N') 
ylabel('Resistance (ohms)')
grid
%hold on

% Plot unoptimized and sparse optimized computation time graphs
figure(2)
plot(x,t,'o')
xlabel('N') 
ylabel('Computation Time') 
hold on
plot(x,t_s, 'x')
grid



