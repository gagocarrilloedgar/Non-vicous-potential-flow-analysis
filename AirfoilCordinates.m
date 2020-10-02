

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

%thicness distribution;
yt = 5*t*c*(.2969*(sqrt(x/c))+-.1260*(x/c)+-.3516*(x/c).^2+.2843*(x/c).^3+-.1015*(x/c).^4);


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


[x,y] = meshgrid(nodes.nx,nodes.ny);

% figure(1);
% % %plot of airfoil
% plot(xu,yu,'*b')
% hold on
% plot(xl,yl,'*b')
% plot(x,y,'*r');
% % %plot(x,yc,'g')


%axis equal;

% X = numel(nodes.nx); % returns the numer of elemets in the array NodeX
% Y = numel(nodes.ny);
% 
% mat = zeros(Y,X);
% 
% N = X - 2;
% M = Y - 2;
% 
% 
% for i = index(1):index(end)
%     for j = 2:M+1
%         if x(j,i)>=xu(i-index(1)+1) && y(j,i) <= yu(i-index(1)+1)
%             if y(j,i) >= yl(i-index(1)+1)
%                 mat(j,i)=1;
%             end
%         end
%         
%         if(x(j,i)> init + c*3/4)
%             if x(j,i) <= xu(i-index(1)+1) && y(j,i) <= yu(i-index(1)+1)
%                 if y(j,i) >= yl(i-index(1)+1)
%                     mat(j,i)=1;
%                 end
%             end
%         end
%     end
% end


airfoil = struct("xu",xu,"yu",yu,"xl",xl,"yl",yl);

end
