%% Neuman boundary condition 

function [x] = neuman(x,N)

x(:,N+2) = x(:,N+1);

end