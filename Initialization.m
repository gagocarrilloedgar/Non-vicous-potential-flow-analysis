

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
