


function [mat] = material(nodes,geo)

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

selection = 1;


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
                
                
                
                
        end
        
        
    end
end


end

