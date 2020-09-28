


function [mat] = material(nodeX,nodeY,r)

X = numel(nodeX); % returns the numer of elemets in the array NodeX
Y = numel(nodeY);

mat = zeros(Y,X);

N = X - 2;
M = Y - 2;

% floor rounds the element to the nearest integer
a = nodeX(floor(X/2) + 1); 
b = nodeY(floor(Y/2) + 1);


for i = 2:N+1
   for j = 2:M+1
       
       % Inside the circle
       
       if (nodeY(j) - b)^2 + (nodeX(i) - a)^2 <= r^2   
           mat(j,i) = 1;
       end
             
       
   end
end


end

