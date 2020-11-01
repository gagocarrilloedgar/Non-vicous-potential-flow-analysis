%% Potential flows
% Author:Gago, Edgar
% Date 15/10/2020
% Subject: Computational engineering
%
%% AirfoilCordinates
% Description
% Generation of the airfoil acoording to the NACA-4 series
%
% Inputs
% c: chord [m]
% NACA: string containing the selected profiles
% geo: struct containing the geometry information
% nodes: struct containing x & y distribution
%
% Ouputs
% airfoil: struct containing upper and lower distrubution of the airfoil
% index: vector whith index that conatain the starting point fo the mesh
% distribution
%
%% CODE

function [airfoil,index] = AirfoilCordinates(c,NACA,geo,nodes)

s=num2str(NACA);
NACA = s;
d1=str2double(s(1)); % pulls the first digit out of the scalar
d2=str2double(s(2));% pulls the second digit out of the scalar
d34=str2double(s(3:4)); % pulls the third and fourth digit out of the scalar

m=d1/100;
p=d2/10;
t=d34/100;

init = (geo.L -c)/2 ;
inity = geo.H /2;


for i=1:size(nodes.nx,2)
    if( nodes.nx(i) >= init && nodes.nx(i) <= init+c)
        index(i)=i;
    end
end

index = index(index~=0);

x=linspace(0, c, index(end));

% Thicness distribution;
yt = ComputeThickness(t,c,x);

for k = 1:length(x)
    if x(k) <= p*c
        yc(k)=m*(x(k)/p^2)*(2*p-(x(k)/c));
        dx(k)=(2*m)/p^2*(p-(x(k)/c));
    elseif x(k) > p*c
        yc(k)=m*((c-x(k))/(1-p)^2)*(1+(x(k)/c)-(2*p));
        dx(k)=((2*m)/(1-p)^2)*(p-(x(k)/c));
    end
    
    %upper and lower limits of the airfoil (xu,yu) ; (xl,yl)
    theta=atan(dx(k));
    xu(k)=x(k)-yt(k)*sin(theta);
    yu(k)=yc(k)+yt(k)*cos(theta);
    xl(k)=x(k)+yt(k)*sin(theta);
    yl(k)=yc(k)-yt(k)*cos(theta);
end

xu = xu + init;
yu = yu + inity;
xl = xl + init;
yl = yl + inity;


airfoil = struct("xu",xu,"yu",yu,"xl",xl,"yl",yl);

end
