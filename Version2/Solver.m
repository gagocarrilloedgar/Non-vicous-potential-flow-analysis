function [stream, err, iterations] = Solver(nodes, mesh, stream, rho, rho0, delta, mat)

dx = mesh.dx;
dy = mesh.dy;

streamp = stream;
k = 1;

converged = false;
iterations = 1;

while ~converged
    
   for i = 2:nodes.y-1
       for j = 2:nodes.x-1
           if mat.id(i,j)
               
               aN = ComputeCoeff(ComputeRho(dy, rho(i,j), rho(i+1,j), rho0), mesh.dPN(i,j), dy);
               aS = ComputeCoeff(ComputeRho(dy, rho(i,j), rho(i-1,j), rho0), mesh.dPS(i,j), dy);
               aE = ComputeCoeff(ComputeRho(dx, rho(i,j), rho(i,j+1), rho0), mesh.dPE(i,j), dx);
               aW = ComputeCoeff(ComputeRho(dx, rho(i,j), rho(i,j-1), rho0), mesh.dPW(i,j), dx);
               aP = aN + aS + aE + aW;
               
               streamE = streamp(i, j+1);
               streamW = streamp(i, j-1);
               streamN = streamp(i+1, j);
               streamS = streamp(i-1, j);

               streamp(i,j) = ( aE*streamE + aW*streamW + aN*streamN + aS*streamS )/aP;
           end
       end
   end

   % Compute error
   err(k) = abs(max(max(streamp - stream)));
   if err(k) < delta
      converged = true;
      disp(err(k));
   end
   k = k+1;
   % Update stream function
   stream = streamp;
   iterations = iterations + 1;
end

end