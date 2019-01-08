# Numerical Methods in Electrical Engineering: Assignments

This repository is a collection of Numerical Methods Assignments I wrote for a class at McGill. Each of these folders includes the code for an assignment, as well as a write up discussing the approach and results. 

### Assignment 1

1.1. The first part of Assignment 1 consists of code written to perform matrix manipulations from "scratch" including a matrix equation solver via Cholesky decomposition. I then wrote a program that reads from a file a list of network branches (Jk, Rk, Ek) and a reduced incidence matrix, and finds the voltages at the nodes of the network using this Cholesky solver. 
To run this code, in MATLAB go to ```Numerical-Methods/Assignment1/Q1``` and run ```test```.

1.2. In the second part of the assignment, I was required to write a program that finds the resistance of an N x N resistor mesh. 
In MATLAB go to ```Numerical-Methods/Assignment1/Q2``` and run ```test``` to see a plot comparing computation time as N increases, as well as a plot illustrating how R changes as N increases.

1.3. The third part of the assignment consisted of solving an electrostatic problem with translational symmetry using the 5-point difference formula solved by (1) successive order relaxation and (2) the Jacobi method. See the report for more information.
In MATLAB, go to ```Numerical-Methods/Assignment1/Q3``` and run ```test```.
To test the successive order relaxation method for non-uniform node spacing, go to:
```Numerical-Methods/Assignment1/Q3``` and run ```testnu```.

### Assignment 2

2.1. The first part of Assignment 2 involved deriving S-matrices from first-order finite elements (see the report for Assignment 2).

2.2. The second part of the assignmnet consisted of writing a program that constructed a mesh, that could then be provided to a third-party program to compute the electrostatic potential solution. See the report for further explanation. 
To test, in MATLAB go to ```Numerical-Methods/Assignment2/Q2``` and run ```testq2```

2.3. The third part of the assignment consisted of solving an electrostatic problem with translational symmetry using the un-preconditioned conjugate gradient method, as well as Cholesky decomposition. Finally, the capacitance per unit length of the system is computed from the finite-difference solution. 
In MATLAB go to ```Numerical-Methods/Assignment2/Q3``` and run ```testq3```

### Assignment 3 

3.1.  In this part of the assignment, we interpolate magnetic field points using full-domain Lagrange polynomials and cubic Hermite polynomials. We then solve a non-linear flux equation using the Newton-Raphson method and successive substitution.

In MATLAB go to ```Numerical-Methods/Assignment3/```;
To test the lagrange polynomial interpolation, run ```lagrange_interpolation;```.
To test the cubic hermite interpolation, run ```hermite_interpolation;```.
To test the flux calculations via successive substitution and Newton Raphson methods, run ```newton_raphson;```.

3.2. In part 2 of the assignment, a system of non-linear equations corresponding to a simple diode circuit is solved using the Newton-Raphson method. The derivation of the system of equations and node assignments can be found in the report.
To test, in MATLAB go to ```Numerical-Methods/Assignment3``` and run ```test_q2;```.

3.3. In the final part of the assignment, a program was written to compute integrals by dividing the interval into N equal segments and using one-point Gauss-Legendre integration for each segment. The integrals that are computed are discussed in the report.
To test, in MATLAB go to ```Numerical-Methods/Assignment3``` and run ```test_q3;```.

### Author

[thomaschristinck](https://github.com/thomaschristinck/), 2018.
