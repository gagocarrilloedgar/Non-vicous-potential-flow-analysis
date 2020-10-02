
function [stream,rho,v,p,T] = ObstacleInit(flow,nodes,mat,v,rho,stream,p,T)
X = numel(nodes.nx);
Y = numel(nodes.ny);

%% Obstacle filling 

for i = 2:X-1
    for j =2:Y-1
        
        if mat(j,i) == 1
            rho(j,i)     = 0;
            stream(j,i)  = flow.v0*(nodes.ny(Y)/2); 
            p(j,i)       = flow.p0;
            T(j,i)       = flow.T0;
            v.vp(j,i)    = 0;
            v.vxP(j,i)   = 0;
            v.vyP(j,i)   = 0;
        end
        
    end
end

end
