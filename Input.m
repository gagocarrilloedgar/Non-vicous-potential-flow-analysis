
%% Input Data %%


%% Domaingeometry
% Domain Length
domainP=[0  3; 0 1];        %First  row for X dim
                            %Second row for Y dim                           

%% Mesh
% N  = Nodes X
% M  = Nodes Y 
% H  = Domain Heigth - Y
% L  = Domain Length - X

L   = domainP(1,2)-domainP(1,1); % [m] x direction
H   = domainP(2,2)-domainP(2,1); % [m] y direction
M  =  100;
N  = M*L;  %Uniform CV
r = 0.25; %[m] This is the radius of the inner circle
h = r; %[m] Minor axis of the ellipse
k = 2*h; %[m] MAjor axis of the ellipse

mesh=[N M];

geometry = struct("L",L,"H",H,"M",M,"N",N,"r",r,"h",h,"k",k);

%% Iterative solver parameters
% maxIter   =   Maximum number of iterations
% sigma     =   Error Parameter

delta=1e-6;

%% Phisical Constants
%  Fluid -> Air at 300K
%  R     =   Gas Constant [J/kgK]

R   = 287;

% Suposing ideal diatomic gas
cp   = (5/2)*R;
gamma = 1.394;
flow = struct("R",R,"cp",cp,"gamma",gamma);

%% Reference Values %%
% rho   =   Density [kg/m^3]
% p     =   Pressure [Pa]
% T     =   Temperature [K]
% v     =   Velocity [m/s]
% R     =   GasConstant [kJ/kmolK]
% cp    =   Coefficent of pressure [Ws/kg K]   

p0   = 10000;
T0   = 273+27;
v0   = 100;
rho0 = p0/(R*T0);
istream = (v0*H)/2;

flow = struct("R",R,"cp",cp,"gamma",gamma,"p0",p0,"T0",T0,"v0",v0,...
"rho0",rho0,"istream",istream);

%% Airfoil info

c = 3.8;         %[m] Airfoil chord
NACA = 2215;   % NACA airfoil definition









