%% Potential flows
% Author:Gago, Edgar
% Date 15/10/2020
% Subject: Computational engineering
%
%% ComputeInnerCoeff
% Description
% Computes the inner coefficients of the case study
%
% Inputs
% nodes: struct with the different vectors distributions of the problem
% mat: contains the logic selector determine whether it is flow or an
% obbject
% flow: strtuc with the physical flow properties
% rho: densitty matrix 
%
% Ouputs
% v: velocities matrix with the corrected boundary conditions
% coeff: matrix with the computed inner coefficients
% rho_frac: struct with the different rho distribution of the cv's

%% CODE

function [coeff,rho_frac] = ComputeInnerCoeff(rho,nodes,flow,mat)
nx = nodes.nx;
ny = nodes.ny;
fx = nodes.fx;
fy = nodes.fy;

X = numel(nodes.nx);
Y = numel(nodes.ny);

coeff.ap = zeros(Y,X);
coeff.ae = zeros(Y,X);
coeff.aw = zeros(Y,X);
coeff.an = zeros(Y,X);
coeff.as = zeros(Y,X);
coeff.bp = zeros(Y,X);

rhohe = zeros(Y,X);
rhohw = zeros(Y,X);
rhohs = zeros(Y,X);
rhohn = zeros(Y,X);


% Inner nodes
for i = 2:X-1
    for j = 2:Y-1
        
        Dy = fy(j)-fy(j-1);
        Dx = fx(i)-fx(i-1);
        
        dPE = nx(i+1)-nx(i);
        dPW = nx(i) - nx(i-1);
        dPN = ny(j+1) - ny(j);
        dPS = ny(j)  - ny(j-1);
        
        N = ny(j+1);
        S = ny(j-1);
        E = nx(i+1);
        W = nx(i-1);
        
        fn = fy(j);
        fs = fy(j-1);
        fe = fx(i);
        fw = fx(i-1);
        
        Px = nx(i);
        Py = ny(j);
        
        if mat(j,i) == 0
            
            rhohe(j,i) = (dPE) / ( ((fe-Px)/(flow.rho0/rho(j,i))) + ((E-fe)/(flow.rho0/rho(j,i+1))) );
            rhohw(j,i) = (dPW) / ( ((Px-fw)/(flow.rho0/rho(j,i))) + ((fw-W)/(flow.rho0/rho(j,i-1))) );
            rhohn(j,i) = (dPN) / ( ((fn-Py)/(flow.rho0/rho(j,i))) + ((N-fn)/(flow.rho0/rho(j+1,i))) );
            rhohs(j,i) = (dPS) / ( ((Py-fs)/(flow.rho0/rho(j,i))) + ((fs-S)/(flow.rho0/rho(j-1,j))) );
            
            coeff.ae(j,i) = rhohe(j,i) * (Dy/dPE);
            coeff.aw(j,i) = rhohw(j,i) * (Dy/dPW);
            coeff.an(j,i) = rhohn(j,i) * (Dx/dPN);
            coeff.as(j,i) = rhohs(j,i) * (Dx/dPS);
            coeff.ap(j,i) = coeff.ae(j,i)+coeff.aw(j,i)+coeff.an(j,i)+coeff.as(j,i);
            
        end
        
    end
end

rho_frac = struct("rhohe",rhohe,"rhohw",rhohw,"rhohn",rhohn,"rhohs",rhohs);

end