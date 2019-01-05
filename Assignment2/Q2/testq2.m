% ECSE 543 Assignment 2
% Question 2
% Script for testing everything in Question 2
write_mesh_file
[pot, S] = SIMPLE2D_M('toSimple2D.txt')
 C = compute_capacitance('toSimple2D.txt')