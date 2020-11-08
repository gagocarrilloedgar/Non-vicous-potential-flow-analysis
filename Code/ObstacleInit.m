%% Potential flows
% Author:Gago, Edgar
% Date 15/10/2020
% Subject: Computational engineering
%
%% ObstacleInit
% Description
% Applying obstacle selector to the physical properties of the problem
%
% Inputs
% flow: strtuc with the physical flow properties
% nodes: struct containing x & y distribution
% v: velocitiy matrix
% stream: stream lines matrix
% rho: densities matrix 
% T: temperatures matrix 
% p: pressures matrix 
% mat: matrix with the nodes dsitrbution where there's flow or solid

%
% Ouputs
% v: updated velocitiy matrix
% stream: updated matrix with the stream lines
% rho: updated densities matrix 
% T: updated temperatures matrix 
% p: updated pressures matrix 
%
%% CODE

function [stream,rho,v,p,T] = ObstacleInit(flow,nodes,mat,v,rho,stream,p,T)
X = numel(nodes.nx);
Y = numel(nodes.ny);

%% Obstacle filling 

for i = 2:X-1
    for j =2:Y-1
        
        if mat(j,i) == 1
            rho(j,i)     = 0;
            stream(j,i)  = flow.v0*(nodes.ny(Y)/2); 
            p(j,i)       = flow.p0;
            T(j,i)       = flow.T0;
            v.vp(j,i)    = 0;
            v.vxP(j,i)   = 0;
            v.vyP(j,i)   = 0;
        end
        
    end
end

end