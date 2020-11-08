%% Potential flows
% Author:Gago, Edgar
% Date 15/10/2020
% Subject: Computational engineering
%
%% ObstacleInit
% Description
% Applying obstacle selector to the physical properties of the problem
%
% Inputs
% nodes: struct containing x & y distribution
% mat: matrix with the nodes dsitrbution where there's flow or solid
% v: initial velocitiy matrix
% stream: initial stream lines matrix
% rho: initial densities matrix 
% rho_frac: struct with the different rho's distributions of the cv's
% T: initial temperatures matrix 
% p: initial pressures matrix 
% coeff: matrix conataining the inner coefficients
% delta: minimum admisible error
% flow: strtuc with the physical flow properties
%
% Ouputs
% v: final velocitiy matrix
% streamp: final stream lines matrix
% rho: final densities matrix 
% T: final temperatures matrix 
% p: final pressures matrix 
% it: number of iterations until converged
%
%% CODE

function [streamp,p,T,rho,v,it] = Solver(stream,coeff,nodes,delta,mesh,p,T...
    ,rho,flow,v,mat,rho_frac)


N = mesh(1);
M = mesh(2);
streamp = stream;

e = 1;
it = 1;

while e>delta
    
    % Discretized Stream Func Solve
    % Solver Core
    for i = 2:N+1
        for j = 2:M+1
            
            
            if mat(j,i) == 0
                
                streamp(j,i) = (coeff.ae(j,i)*stream(j,i+1) + ...
                    coeff.aw(j,i)*stream(j,i-1) + ...
                    coeff.an(j,i)*stream(j+1,i) + ...
                    coeff.as(j,i)*stream(j-1,i)) / coeff.ap(j,i);
            end
            
        end
    end
    
    [streamp] = neuman(streamp,N);
    err = abs(streamp - stream);
    e =  max(max(err));
    stream = streamp;
    it = it + 1;
    
end



for i = 2:N+1
    for j = 2:M+1
        
        % Only compute at fluid media mat=0
        if mat(j,i) == 0
            
            v.vxn(j,i) = rho_frac.rhohn(j,i)*((streamp(j+1,i)-streamp(j,i) ) / (nodes.ny(j+1) - nodes.ny(j)));
            v.vxs(j,i) = rho_frac.rhohs(j,i)*((-streamp(j-1,i)+streamp(j,i) ) / (nodes.ny(j) - nodes.ny(j-1)));
            
            v.vye(j,i) = -rho_frac.rhohe(j,i)*((streamp(j,i+1)-streamp(j,i) ) / (nodes.nx(i+1) - nodes.nx(i)));
            v.vyw(j,i) = -rho_frac.rhohw(j,i)*((-streamp(j,i-1)+streamp(j,i) ) / (nodes.nx(i) - nodes.nx(i-1)));
            
            v.vxP(j,i) = (v.vxn(j,i)+v.vxs(j,i))/2;
            v.vyP(j,i) = (v.vye(j,i)+v.vyw(j,i))/2;
        
        
            v.vp(j,i) = sqrt(v.vxP(j,i)^2 + v.vyP(j,i)^2);
        end
        
        
        % If -> Total energy conserved
        % Then:
        T(j,i) = flow.T0 + (flow.v0^2-v.vp(j,i)^2)/(2*flow.cp);
        
        % Isentropic relation applyed
        p(j,i) = flow.p0 * (T(j,i)/flow.T0)^(flow.gamma/(flow.gamma-1));
        
        % Density from gas relation
        % Air considered as an ideal gas
        rho(j,i) = p(j,i)/(flow.R*T(j,i));
        
    end
    
end

[p] = neuman(p,N);
[rho] = neuman(rho,N);
[T] = neuman(T,N);
[v.vp] = neuman(v.vp,N);




end