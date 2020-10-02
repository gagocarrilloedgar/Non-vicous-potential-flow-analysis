
function [stream,prt] = Initialization(nodes, mesh,mat,flw)

    stream = zeros(nodes.x, nodes.y);
    vel = flw.u0;
    y0=0;
    
    % Impose Dirichlet boundary conditions
    % Upper/Lower boundaries 
    stream(1,:) = (mesh.y(1,:)-y0) * vel;
    stream(end, :) = (mesh.y(end,:)-y0) * vel;
    
    % Inflow
    stream(:,1) = (mesh.y(:,1)-y0) * vel;
    
    % Outflow
    stream(:,end) = (mesh.y(:, end)-y0) * vel;
    
    % Inner nodes
    stream(2:end-1, 2:end-1) = (mesh.y(2:end-1, 2:end-1)-y0) * vel;
    
    % Stream function null for the solid (nodes.id==0 for solid region)
    stream = stream .* mat.id;

    %Temperature, density & Temperature
    prt.P = flw.P0 * mat.id;
    prt.rho = flw.rho0 * mat.id;
    prt.T = flw.T0 * mat.id;
    
    stream = stream.*(prt.rho/flw.rho0);

    
    
end