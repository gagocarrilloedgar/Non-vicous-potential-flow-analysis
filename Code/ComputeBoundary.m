%% Potential flows
% Author:Gago, Edgar
% Date 15/10/2020
% Subject: Computational engineering
%
%% ComputeBoundary
% Description
% Generation of the airfoil acoording to the NACA-4 series
%
% Inputs
% strem: matrix with the stream lines values
% H: height of the CV
% nodey: distribution of nodes on the y direction
% meshSizes: struct containing the sizes of the final mesh
% init: strutu with the initial/boundary values 
% coef: matrix with the coefficient values
% v: velocities matrix
%
% Ouputs
% v: velocities matrix with the corrected boundary conditions
% coef: matrix with the coefficient with the corrected boundary conditions
% strem: matrix with the stream lines with the corrected boundary 
%        conditions

%% CODE
function [stream,coeff,v] = ComputeBoundary(stream,init,H,nodeY,meshSizes,coeff,v)

    N = meshSizes(1);
    M = meshSizes(2);
    
    %% Top
    stream(M+2,:) = init.v0*H;
    coeff.ap(M+2,:)     = 1;
    coeff.aw(M+2,:)     = 0;
    coeff.ae(M+2,:)     = 0;    
    coeff.an(M+2,:)     = 0;
    coeff.as(M+2,:)     = 0;
    coeff.bp(M+2,:)     = init.v0*H;
    
    %No slip BC
    v.vp(M+2,:)           = 0;  
    v.vxn(M+1,:)          = 0;
    
    %% Bottom
    stream(1,:)   = 0;
    coeff.ap(1,:)     = 0;
    coeff.aw(1,:)     = 0;
    coeff.ae(1,:)     = 0;    
    coeff.an(1,:)     = 0;
    coeff.as(1,:)     = 0;
    coeff.bp(1,:)     = 0;
    
    %No slip BC
    v.vp(1,:)           = 0;   
    v.vxn(1,:)          = 0;
   
    %% Inlet
    stream(:,1) = init.v0*nodeY;
    coeff.ap(:,1)     = 1;
    coeff.ae(:,1)     = 0;
    coeff.aw(:,1)     = 0;
    coeff.an(:,1)     = 0;
    coeff.as(:,1)     = 0;
    coeff.bp(:,1)     = init.v0*H;
    
    %% Outlet
    % Stream not defined because it is already set when initiaizing field
    coeff.ap(:,N+2)     = 1;
    coeff.aw(:,N+2)     = 1;
    coeff.ae(:,N+2)     = 0;
    coeff.an(:,N+2)     = 0;
    coeff.as(:,N+2)     = 0;
    coeff.bp(:,N+2)     = 0;
  
end