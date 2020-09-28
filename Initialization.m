

function [stream,p,T,rho,v] = Initialization(init, nodeX,nodeY)

X = numel(nodeX);
Y = numel(nodeY);

stream = zeros(Y,X);
p      = zeros(Y,X);
T      = zeros(Y,X);
rho    = zeros(Y,X);

% Initiazation of the whole matrix
stream(:,:) = init.istream;
p(:,:)      = init.p0;
T(:,:)      = init.T0;
rho(:,:)    = init.rho0;

    

%% Velocity Field
v.vp     = zeros(Y,X);

%Face Velocity  Nfaces = Nnodes-1
v.vxn    = zeros(Y-1,X-1);
v.vye    = zeros(Y-1,X-1); 

% Velocity Field
v.vp(:,:)     = init.v0;
v.vxn(:,:)    = init.v0;
%vye = 0 we are not taking into account the vertical velocity



end
