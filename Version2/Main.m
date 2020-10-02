%% MAIN PROGRAM %%
% Author: Edgar Gago Carrillo
% Subject: Computational engineering
% Date: 28th Sep 2020 

clear;
close all;
clc;

%% Initial conditions 
Input;

%% Distance vectors generation
[mesh] = CreateMesh(nodes, L, H);

%% Object Definition
[mat] = FillMaterial(R,mesh);

%% Initialization
[stream,prt] = Initialization(nodes,mesh,mat,flw);

%% Solver (GS)
[streamp, err, iterations] = Solver(nodes, mesh, stream, prt.rho, flw.rho0, delta,mat);

%% Compute velocities
v = ComputeVelocities(nodes, mesh, flw.u0, streamp,mat);

quiver(v.vx,v.vy);
title(sprintf('Nodal Velocity Vectors R = %0.3f [m]',Radi));
x = sprintf('Nodes X  = %d      L  =  %d  [m]',N,L);
y = sprintf('NodesY  = %d       H  =  %d  [m]',M,H); 
xlabel(x), ylabel(y);
set(gcf, 'Position',  [100, 100, L*500, H*500]);


