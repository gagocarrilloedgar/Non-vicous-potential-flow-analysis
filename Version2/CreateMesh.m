function [mesh] = CreateMesh(nodes, L, H)

x_ = linspace(-L/2,L/2, nodes.x-1);
y_ = linspace(-H/2,H/2, nodes.y-1);


mesh.dx = x_(2)-x_(1);
mesh.dy = y_(2)-y_(1);

x = zeros(1,nodes.x);
y = zeros(1,nodes.y);

% Center block
x(2:end-1) = x_(1:end-1) + mesh.dx/2;
y(2:end-1) = y_(1:end-1) + mesh.dy/2;

% Boundaries
x([1,end]) = x_([1,end]);
y([1,end]) = y_([1,end]);


[mesh.x,mesh.y] = meshgrid(x, y);

% Get mesh lines for postprocessing plots
mesh.xlines = x_;
mesh.ylines = y_;

% Compute distances between control volumes centers
dPN = zeros(nodes.y, nodes.x);
dPS = zeros(nodes.y, nodes.x);
dPW = zeros(nodes.y, nodes.x);
dPE = zeros(nodes.y, nodes.x);

for i = 2:nodes.y-1
    for j = 2:nodes.x-1
        % North
        dN_x = abs(mesh.x(i,j)-mesh.x(i+1, j));
        dN_y = abs(mesh.y(i,j)-mesh.y(i+1, j));
        dPN(i,j) = sqrt(dN_x^2 + dN_y^2);
        
        % South
        dS_x = abs(mesh.x(i,j)-mesh.x(i-1, j));
        dS_y = abs(mesh.y(i,j)-mesh.y(i-1, j));
        dPS(i,j) = sqrt(dS_x^2 + dS_y^2);
  
        % West
        dW_x = abs(mesh.x(i,j)-mesh.x(i, j-1));
        dW_y = abs(mesh.y(i,j)-mesh.y(i, j-1));
        dPW(i,j) = sqrt(dW_x^2 + dW_y^2);
        
        % East
        dE_x = abs(mesh.x(i,j)-mesh.x(i, j-1));
        dE_y = abs(mesh.y(i,j)-mesh.y(i, j-1));
        dPE(i,j) = sqrt(dE_x^2 + dE_y^2);
    end
end

mesh.dPN = dPN;
mesh.dPS = dPS;
mesh.dPW = dPW;
mesh.dPE = dPE;

end