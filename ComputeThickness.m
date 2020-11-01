%% Potential flows
% Author:Gago, Edgar
% Date 15/10/2020
% Subject: Computational engineering
%
%% ComputeThickness
% Description
% Computes the thickness distribution of an airoil
%
% Inputs
% t: maximum thickness
% x: nodes distribution
% c: camber line
%
% Ouputs
% yt: resultant thickness distribution
%
%% CODE

function yt = ComputeThickness(t,c,x)

a0 = 0.2969;
a1 = -0.126;
a2 = -0.3516;
a3 = 0.2843;
a4 = -0.1036;

k0 = a0*x^0.5;
k1 =a1*x;
k2 =a2*x.^2;
k3 =a3*x.^3;
k4 =a4*x.^4;

yt = 5*t*c*( k0 + k1 + k2 + k3 + k4); 
end