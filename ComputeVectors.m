
%% ComputeVectors %%


function [nodes] = ComputeVectors(domainP, meshSizes)

xLength = domainP(1,2)-domainP(1,1);  
yLength = domainP(2,2)-domainP(2,1);  

[nx,fx]=mesh(xLength,meshSizes(1),domainP(1,1));

[ny,fy]=mesh(yLength,meshSizes(2),domainP(2,1));

nodes = struct("nx", nx,"ny",ny, "fx",fx, "fy",fy);

end

function [nx,fx]=mesh(length,numCV,initPoint)

fx=linspace(initPoint,initPoint+length,numCV+1);

nx(1,1)=initPoint;
nx(1,2:numCV+1)=(fx(2:end)+fx(1:end-1))*0.5;
nx(1,numCV+2)=initPoint+length;

end
