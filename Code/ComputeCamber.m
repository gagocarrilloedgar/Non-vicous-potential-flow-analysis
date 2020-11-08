function [yc,dyc] = ComputeCamber(x,p,c,m,mp)


max = p*c;

if x <= max 
    yc = m*(x /p^2)*(2*p -(x / c));
    dyc = (2*m)/p^2*(p-(x/c));
elseif x > max
    yc = m*((c-x)/(1-p)^2)*(1+(x/c)-(2*p));
    dyc = ((2*m)/(1-p)^2)*(p-(x/c));
end


end