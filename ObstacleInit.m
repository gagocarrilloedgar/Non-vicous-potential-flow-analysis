
function [stream,rho,v,p,T] = ObstacleInit(init, nodeX,nodeY,mat,v,rho,stream,p,T)
X = numel(nodeX);
Y = numel(nodeY);

%% Obstacle filling 

for i = 2:X-1
    for j =2:Y-1
        
        if mat(j,i) == 1
            rho(j,i)     = 0;
            stream(j,i)  = init.v0*(nodeY(Y)/2); 
            p(j,i)       = init.p0;
            T(j,i)       = init.T0;
            v.vp(j,i)    = 0;
            v.vxP(j,i)   = 0;
            v.vyP(j,i)   = 0;
        end
        
    end
end

end
