
%% MAIN PROGRAM %%
% Author: Edgar Gago Carrillo
% Subject: Computational engineering
% Date: 28th Sep 2020 

clear;
close all;
clc;

%% Initial conditions 
Input;

%% Geometry
[nodes] = ComputeVectors(domainP, mesh);

%% Airfoil Gemetry generation 
[airfoil,index] = AirfoilCordinates(c,NACA,geometry,nodes);

%% Initialization
[stream,p,T,rho,v] = Initialization(flow,nodes);

%% Material
[mat] = material(nodes,geometry,c,airfoil,index);

%% Obstacle Initialization
[stream,rho,v,p,T] = ObstacleInit(flow,nodes,mat,v,rho,stream,p,T);

%% Compute Inner Coefficients
[coeff,rho_frac] = ComputeInnerCoeff(rho,nodes,flow,mat);

%% Compute Boundary
[stream,coeff,v] = ComputeBoundary(stream,flow,H,nodes.ny,mesh,coeff,v);

%% Solver
[stream,p,T,rho,v] = Solver(stream,coeff,nodes,delta,mesh,p,T,rho,flow,v,mat,rho_frac);

%% Plots 
PlotGraph(stream,p,T,rho,v,nodes,mat,geometry);

