
%% MAIN
% Author: Edgar Gago Carrillo
% Subject: Computational engineering
% Date: 28th Sep 2020
%
% Description
% Core of the program. Developd both the solver and the pre and post
% process

clear;
close all;
clc;

%% Initial conditions
Input;

% Space allocation
time = zeros(1,numel(M));
itt = zeros(1,numel(M));

for i=1:numel(M)
    
    %% Geometry
    N_ = N(i);
    M_ = M(i);
    
    mesh=[N_ M_];
    geometry = struct("L",L,"H",H,"M",M_,"N",N_,"r",r,"h",h,"k",k);
    [nodes] = ComputeVectors(domainP, mesh);
    
    %% Airfoil Gemetry generation
    [airfoil,index] = AirfoilCordinates(c,NACA,geometry,nodes);
    
    %% Initialization
    [stream,p,T,rho,v] = Initialization(flow,nodes);
    
    %% Material
    [mat] = material(nodes,geometry,c,airfoil,index,ops);
    
    %% Obstacle Initialization
    [stream,rho,v,p,T] = ObstacleInit(flow,nodes,mat,v,rho,stream,p,T);
    
    %% Compute Inner Coefficients
    tic
    [coeff,rho_frac] = ComputeInnerCoeff(rho,nodes,flow,mat);
    
    %% Compute Boundary
    [stream,coeff,v] = ComputeBoundary(stream,flow,H,nodes.ny,mesh,coeff,v);
    
    %% Solver
    [stream,p,T,rho,v,it] = Solver(stream,coeff,nodes,delta,mesh,p,T,rho,flow,v,mat,rho_frac);
    time(i) = toc;
    itt(i) = it;
end

%% Plots

% Physical solution plots
PlotGraph(stream,p,T,rho,v,nodes,mat,geometry);

% Computational-cost plot
costPLots;



