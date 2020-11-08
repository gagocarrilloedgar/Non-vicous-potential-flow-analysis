%% Potential flows
% Author:Gago, Edgar
% Date 15/10/2020
% Subject: Computational engineering
%
%% Initialization
% Description
% Physical properties vectors initialization
%
% Inputs
% flow: strtuc with the physical flow properties
% nodes: struct with the different vectors distributions of the problem
% 
%
% Ouputs
% v: initialized velocitiy matrix
% stream: initialized matrix with the stream lines
% rho: initialized densities matrix 
% T: initialized temperatures matrix 
% p: initialized pressures matrix 
%
%% CODE

function [stream,p,T,rho,v] = Initialization(flow,nodes)

X = numel(nodes.nx);
Y = numel(nodes.ny);

stream = zeros(Y,X);
p      = zeros(Y,X);
T      = zeros(Y,X);
rho    = zeros(Y,X);

% Initiazation of the whole matrix
stream(:,:) = flow.istream;
p(:,:)      = flow.p0;
T(:,:)      = flow.T0;
rho(:,:)    = flow.rho0;

    

%% Velocity Field
v.vp     = zeros(Y,X);

%Face Velocity  Nfaces = Nnodes-1
v.vxn    = zeros(Y-1,X-1);
v.vye    = zeros(Y-1,X-1); 

% Velocity Field
v.vp(:,:)     = flow.v0;
v.vxn(:,:)    = flow.v0;



end
