

function [stream,p,T,rho,v] = Solver(stream,coeff,nodeX,nodeY,sigma,meshSizes,p,T,rho,init,fluidC,v,mat)

    

    N = meshSizes(1);
    M = meshSizes(2);
    
    % Error initilization i order to start the loop
    eT   = 1; 
    ep   = 1;
    erho = 1;
    n = 0;
    
    
    while eT> sigma  || ep> sigma  || erho > sigma 
    
    % Initialize stream parameter;
    
    n = n+1;    
    % Discretized Stream Func Solve
    % Solver Core
    for i = 2:N+1
        for j = 2:M+1
            
            if mat(j,i) == 0
            stream(j,i) = (coeff.ae(j,i)*stream(j,i+1) + ...
                           coeff.aw(j,i)*stream(j,i-1) + ...
                           coeff.an(j,i)*stream(j+1,i) + ...
                           coeff.as(j,i)*stream(j-1,i)) / coeff.ap(j,i);                     
            end
            
        end        
    end
    
    [stream] = neuman(stream,N);
    
    %Density Temperature and Pressure Solve
    % Field Solver
    Tini   = T;
    pini   = p;
    rhoini = rho;
    
    for i = 2:N+1
        for j = 2:M+1
            
            % Only compute at fluid media mat=0
            if mat(j,i) == 0
                
                v.vxn(j,i) = (stream(j+1,i)-stream(j,i) ) / (nodeY(j+1) - nodeY(j));            
                v.vye(j,i) = (stream(j,i+1)-stream(j,i) ) / (nodeX(i+1) - nodeX(i));

                % Due to the for dimensions it is necessary to keep face
                % velocity to zero, this if ensures that
                if j == M+1
                   v.vxn(j,i) = 0;
                   v.vye(j,i) = 0;
                end            

                v.vxP(j,i) = (v.vxn(j,i)+v.vxn(j-1,i))/2;
                v.vyP(j,i) = (v.vye(j,i)+v.vye(j,i-1))/2;

                % Due to the for dimensions the mean value is the point value
                if j == 2
                   v.vxP(j,i) = v.vxn(j,i);
                   v.vyP(j,i) = v.vye(j,i);
                end
                        
                if j == M+1
                   v.vxP(j,i) = v.vxn(j-1,i);
                   v.vyP(j,i) = v.vye(j,i-1);
                end

                v.vp(j,i) = sqrt(v.vxP(j,i)^2 + v.vyP(j,i)^2);                  

                % If -> Total energy conserved
                % Then:            
                T(j,i) = init.T0 + (init.v0^2-v.vp(j,i)^2)/(2*fluidC.cp);

                % Isentropic relation applyed
                p(j,i) = init.p0 * (T(j,i)/init.T0)^(fluidC.gam/(fluidC.gam-1));                
                
                % Density from gas relation
                % Air considered as an ideal gas
                rho(j,i) = p(j,i)/(fluidC.R*T(j,i));             
                
            end
                        
        end        
    end
    
    [p] = neuman(p,N);
    [rho] = neuman(rho,N);
    [T] = neuman(T,N);
    [v.vp] = neuman(v.vp,N);
    
    eT   = max(max(abs(T-Tini)));
    ep   = max(max(abs(p-pini)));
    erho = max(max(abs(rho-rhoini)));
    
    %[coeff] = interiorcoefficients(rho,nodeX,faceX,nodeY,faceY,rho0);   
    end
    
    

end
