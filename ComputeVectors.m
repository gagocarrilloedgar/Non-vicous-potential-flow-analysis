
%% ComputeVectors %%


function [xn,xf,yn,yf] = ComputeVectors(domainP, meshSizes)

xLength = domainP([1],[2])-domainP([1],[1]);  
yLength = domainP([2],[2])-domainP([2],[1]);                              
domainLengths=[xLength, yLength]; 

dim=1;
[xn,xf]=facesZVB(domainLengths(dim),...
          meshSizes(dim),domainP([dim],[1]));

dim=2;
[yn,yf]=facesZVB(domainLengths(dim),...
  meshSizes(dim),domainP([dim],[1]));


end

function [nx,fx]=facesZVB(length,numCV,initPoint)

fx=linspace(initPoint,initPoint+length,numCV+1);

nx(1,1)=initPoint;
nx(1,2:numCV+1)=(fx(2:end)+fx(1:end-1))*0.5;
nx(1,numCV+2)=initPoint+length;

end
