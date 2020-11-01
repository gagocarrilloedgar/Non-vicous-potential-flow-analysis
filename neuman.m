%% Potential flows
% Author:Gago, Edgar
% Date 15/10/2020
% Subject: Computational engineering
%
%% AirfoilCordinates
% Description
% Application of the Nueman boundary condition to a matrix x
%
% Inputs
% N: mesh 
% x: matrix where to apply the conditions
%
% Ouputs
% x: matrix updated
%
%
%% CODE
function [x] = neuman(x,N)

x(:,N+2) = x(:,N+1);

end