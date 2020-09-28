
function [coeff] = ComputeInnerCoeff(rho,nodeX,faceX,nodeY,faceY,init,mat)
    
    X = numel(nodeX);
    Y = numel(nodeY);
    
    coeff.ap = zeros(Y,X);
    coeff.ae = zeros(Y,X);
    coeff.aw = zeros(Y,X);
    coeff.an = zeros(Y,X);
    coeff.as = zeros(Y,X);
    coeff.bp = zeros(Y,X);
    
    
    % Inner nodes
    for i = 2:X-1       
        for j = 2:Y-1
            
            Dy = faceY(j)-faceY(j-1); 
            Dx = faceX(i)-faceX(i-1);
            
            dPE = nodeX(i+1)-nodeX(i);
            dPW = nodeX(i) - nodeX(i-1);
            dPN = nodeY(j+1) - nodeY(j);
            dPS = nodeY(j)  - nodeY(j-1);
            
            N = nodeY(j+1);
            S = nodeY(j-1);
            E = nodeX(i+1);
            W = nodeX(i-1);

            fn = faceY(j);
            fs = faceY(j-1);
            fe = faceX(i);
            fw = faceX(i-1);
            
            Px = nodeX(i);
            Py = nodeY(j);
            
            if mat(j,i) == 0
            
            rhohe = (dPE) / ( ((fe-Px)/(init.rho0/rho(j,i))) + ((E-fe)/(init.rho0/rho(j,i+1))) );
            rhohw = (dPW) / ( ((Px-fw)/(init.rho0/rho(j,i))) + ((fw-W)/(init.rho0/rho(j,i-1))) );
            rhohn = (dPN) / ( ((fn-Py)/(init.rho0/rho(j,i))) + ((N-fn)/(init.rho0/rho(j+1,i))) );
            rhohs = (dPS) / ( ((Py-fs)/(init.rho0/rho(j,i))) + ((fs-S)/(init.rho0/rho(j-1,i))) );
                
            coeff.ae(j,i) = rhohe * (Dy/dPE);
            coeff.aw(j,i) = rhohw * (Dy/dPW);
            coeff.an(j,i) = rhohn * (Dx/dPN);
            coeff.as(j,i) = rhohs * (Dx/dPS);
            coeff.ap(j,i) = coeff.ae(j,i)+coeff.aw(j,i)+coeff.an(j,i)+coeff.as(j,i);
            %coeff.bp(j,i)= 0;
            
            end
                            
        end        
    end
    
    
end
