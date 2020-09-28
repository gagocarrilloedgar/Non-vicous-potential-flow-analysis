
%% Input Data %%


%% Domain
% Domain Length
domainP=[0  3; 0 1];        %First  row for X dim
                            %Second row for Y dim  
                            
L   = domainP(1,2)-domainP(1,1); % [m] x direction
H   = domainP(2,2)-domainP(2,1); % [m] y direction

%%  Circumference or Cilinder
% rmax   = 
% rmin   = Minimum Radius
% Rsect  = Number of divisions
% visual = R to display
%
% Set Rsect as 1 and the code takes the minimum radius as the study radius
r.rmax   =  H / 2.354;      % Maximum Radius [m]
r.rmin   =  H / 10;         % Minimum Radius [m]
r.Rsect  =  20;             % Number of division [m]
r.visual =  5;    % R to dispaly

if r.Rsect ==1
    r.radi = r.rmin;
else
    r.radi = linspace(r.rmin,r.rmax,r.Rsect);
end
                         

%% Mesh
% N  = Nodes X
% M  = Nodes Y 
% H  = Domain Heigth - Y
% L  = Domain Length - X
% for computing the boundaries
M  =  20;
N  = M*L;  %Uniform CV

meshSizes=[N M];


%% Iterative solver parameters
% maxIter   =   Maximum number of iterations
% sigma     =   Error Parameter

maxIter=1e4;
sigma=1e-6;

%% Phisical Constants
%  Fluid -> Air at 300K
%  R     =   Gas Constant [J/kgK]

fluidC.R   = 287;

% Suposing ideal diatomic gas
fluidC.cp   = (5/2)*fluidC.R;
fluidC.gam = 1.394;

%% Reference Values %%
% rho   =   Density [kg/m^3]
% p     =   Pressure [Pa]
% T     =   Temperature [K]
% v     =   Velocity [m/s]
% R     =   GasConstant [kJ/kmolK]
% cp    =   Coefficent of pressure [Ws/kg K]   

init.p0   = 100000;
init.T0   = 273+27;
init.v0   = 4;
init.rho0 = init.p0/(fluidC.R*init.T0);
init.istream = (init.v0*H)/2;

%%
D=1.5; %[m] This is the diamter of the inner circle





