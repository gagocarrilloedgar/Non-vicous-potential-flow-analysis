%% Neuman boundary condition 

function [x] = neuman(x,N)

x(:,N+1) = x(:,N+2);

end