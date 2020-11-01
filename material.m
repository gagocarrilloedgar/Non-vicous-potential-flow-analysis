%% Potential flows
% Author:Gago, Edgar
% Date 15/10/2020
% Subject: Computational engineering
%
%% material
% Description
% Material selector generator
%
% Inputs
% c: chord [m]
% geo: struct containing the geometry information
% nodes: struct containing x & y distribution
% airfoil: struct containing upper and lower distrubution of the airfoil
% index: vector whith index that conatain the starting point fo the mesh
% distribution
% ops: geometry selector
%
% Ouputs
% mat: matrix with the nodes dsitrbution where there's flow or solid
%
%% CODE


function [mat] = material(nodes,geo,c,airfoil,index,ops)

r = geo.r;
h = geo.h;
k = geo.k;


X = numel(nodes.nx); % returns the numer of elemets in the array NodeX
Y = numel(nodes.ny);

mat = zeros(Y,X);

N = X - 2;
M = Y - 2;

% floor rounds the element to the nearest integer
a = nodes.nx(floor(X/2) + 1);
b = nodes.ny(floor(Y/2) + 1);


% Airfoil
selection = ops;
init = (geo.L -c)/2;

[x,y] = meshgrid(nodes.nx,nodes.ny);


for i = 2:N+1
    for j = 2:M+1
        
        % Inside the circle
        switch(selection)
            
            case 0
                
                if ((nodes.ny(j) - b)^2 ) + ((nodes.nx(i) - a)^2) <= r^2
                    mat(j,i) = 1;
                end
                
            case 1
                
                if ((nodes.ny(j) - b)^2 )/h^2 + ((nodes.nx(i) - a)^2)/k^2 <= 1
                    mat(j,i) = 1;
                end
                
            case 2
                if(i>= index(1) && i<= index(end))
                    
                    if x(j,i)>=airfoil.xu(i-index(1)+1) && y(j,i) <= airfoil.yu(i-index(1)+1)
                        if y(j,i) >= airfoil.yl(i-index(1)+1)
                            mat(j,i)=1;
                        end
                    end
                    
                    if(x(j,i)> init + c*3/4)
                        if x(j,i) <= airfoil.xu(i-index(1)+1) && y(j,i) <= airfoil.yu(i-index(1)+1)
                            if y(j,i) >= airfoil.yl(i-index(1)+1)
                                mat(j,i)=1;
                            end
                        end
                    end
                end
        end
        
    end
end


end
