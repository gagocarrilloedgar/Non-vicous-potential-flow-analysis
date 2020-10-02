


%% Flow data

flw.u0 = 20;                    % Free flow velocity [m/s]
flw.Rg = 287.058;               % Air specific gas constant [J/(kg*K)]
flw.gamma = 1.4;                % Air adiabatic coefficient [-]
flw.Cp = flw.gamma*flw.Rg/(flw.gamma-1);    % Air spec heat at constant Pressure [J/(kg*K)]
flw.P0 = 101325;                % Free flow Pressure [Pa]
flw.T0 = 288.15;                % Free flow Temperature [K]
flw.rho0 = flw.P0/(flw.Rg*flw.T0);          % Free flow density [kg/m3]
flw.a0 = sqrt(flw.gamma*flw.Rg*flw.T0);     % Free flow speed of sound [m/s]
flw.M0 = flw.u0/flw.a0;                 % Free flow Mach number [-]

%% Geometry

x_div = 100;    % Number of mesh divisions in the x direction
y_div = 100;    % Number of mesh divisions in the y direction

R = 4;                   % Cylinder's raduis [m]
L = 16;                  % Mesh longitude (x direction) [m]
H = 10;                  % Mesh height (y direction) [m]               
nodes.x = x_div+2;       % Mesh nodes in the x direction considering the boundary nodes
nodes.y = y_div+2;       % Mesh nodes in the y direction considering the boundary nodes

%% Control data

delta = 1e-6;         % Convergence criteria


