
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
[nodeX,faceX,nodeY,faceY] = ComputeVectors(domainP, meshSizes);

%% Initialization
[stream,p,T,rho,v] = Initialization(init, nodeX,nodeY);

%% Material
[mat] = material(nodeX,nodeY,D/2);

%% Obstacle Initialization
[stream,rho,v,p,T] = ObstacleInit(init, nodeX,nodeY,mat,v,rho,stream,p,T);

%% Compute Inner Coefficients
[coeff] = ComputeInnerCoeff(rho,nodeX,faceX,nodeY,faceY,init,mat);

%% Compute Boundary
[stream,coeff,v] = ComputeBoundary(stream,init,H,nodeY,meshSizes,coeff,v);

%% Solver
[stream,p,T,rho,v] = Solver(stream,coeff,nodeX,nodeY,sigma,meshSizes,p,T,rho,init,fluidC,v,mat);


