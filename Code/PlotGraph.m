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
% geometry: struct containing the geometry information
% nodes: struct containing x & y distribution
% v: final velocitiy matrix
% stream: final stream lines matrix
% rho: final densities matrix 
% T: final temperatures matrix 
% p: final pressures matrix 
% mat: matrix with the nodes dsitrbution where there's flow or solid
%
%
% Ouputs
%
%% CODE


function  PlotGraph(stream,p,T,rho,v,nodes,mat,geometry)

M = geometry.M;
r = geometry.r;
L = geometry.L;
H = geometry.H;
N = geometry.N;

X = numel(nodes.nx);
Y = numel(nodes.ny);


Ax.XDisplayLabels.Interpreter = 'latex';
Ax.Title.Interpreter = 'latex';
set(groot,'DefaultAxesTitle', Ax.Title);

for i = 2:X-1
    for j =2:Y-1        
        if mat(j,i) == 1
            rho(j,i)     = 0;
            stream(j,i)  = nan; 
            v.vp(j,i)    = 0;
        end        
    end
end



%% Plot 1 - Stream Function

figure(1);
hmh = heatmap(stream);  %heatmap
colormap(jet);
colorbar;
title(sprintf('Stream Function R = %0.3f [m]',r));
x = sprintf('Nodes X  = %d      L  =  %d  [m]',N,L);
y = sprintf('NodesY  = %d       H  =  %d  [m]',M,H); 
xlabel(x), ylabel(y);
set(gcf, 'Position',  [100, 100, L*500, H*500]);


if   X > 70
    %Label Control for heatmap
    Ax = gca;
    Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
    Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
    hmh.GridVisible = 'off';
end


%% Plot 2 - Stream Function Streamlines
figure(2);
contourf(stream,15);
colorbar;
title(sprintf('Stream Function Streamlines R = %0.3f [m]',r));
x = sprintf('Nodes X  = %d      L  =  %d  [m]',N,L);
y = sprintf('NodesY  = %d       H  =  %d  [m]',M,H); 
xlabel(x), ylabel(y);
set(gcf, 'Position',  [100, 100, L*500, H*500]);





%% Plot 3 - Pressure Field
figure(3);
hmh=heatmap(p);  %heatmap
colormap(jet);
colorbar;
title(sprintf('Pressure Field  R = %0.3f [m]',r));
x = sprintf('Nodes X  = %d      L  =  %d  [m]',N,L);
y = sprintf('NodesY  = %d       H  =  %d  [m]',M,H); 
xlabel(x), ylabel(y);
set(gcf, 'Position',  [100, 100, L*500, H*500]);

if   X > 70
    %Label Control for heatmap
    Ax = gca;
    Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
    Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
    hmh.GridVisible = 'off';
end


%% Plot 4 - Temperature Field
figure(4);
hmh = heatmap(T);  %heatmap
colormap(jet);
colorbar;
title(sprintf('Temperature Field R = %0.3f [m]',r));
x = sprintf('Nodes X  = %d      L  =  %d  [m]',N,L);
y = sprintf('NodesY  = %d       H  =  %d  [m]',M,H); 
xlabel(x), ylabel(y);
set(gcf, 'Position',  [100, 100, L*500, H*500]);

if   X > 70
    %Label Control for heatmap
    Ax = gca;
    Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
    Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
    hmh.GridVisible = 'off';
end

%% Plot 5 - Density field
figure(5);
hmh=heatmap(rho);  %heatmap
colormap(jet);
colorbar;
title(sprintf('Density Field R = %0.3f [m]',r));
x = sprintf('Nodes X  = %d      L  =  %d  [m]',N,L);
y = sprintf('NodesY  = %d       H  =  %d  [m]',M,H); 
xlabel(x), ylabel(y);
set(gcf, 'Position',  [100, 100, L*500, H*500]);

if   X > 70
    %Label Control for heatmap
    Ax = gca;
    Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
    Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
    hmh.GridVisible = 'off';
end


%% Plot 6 - Velocity Field
figure(6);
hmh = heatmap(v.vp);
colormap(jet);
colorbar;
title(sprintf('Velocity Field R = %0.3f [m]',r));
x = sprintf('Nodes X  = %d      L  =  %d  [m]',N,L);
y = sprintf('NodesY  = %d       H  =  %d  [m]',M,H); 
xlabel(x), ylabel(y);
set(gcf, 'Position',  [100, 100, L*500, H*500]);

if   X > 70
     %Label Control for heatmap
     Ax = gca;
     Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
     Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
     hmh.GridVisible = 'off';
end

%% Plot 7  - Pressure Isobars
figure(7);
contourf(p,15);
colorbar;
title(sprintf('Pressure Field Isobars R = %0.3f [m]',r));
x = sprintf('Nodes X  = %d      L  =  %d  [m]',N,L);
y = sprintf('NodesY  = %d       H  =  %d  [m]',M,H); 
xlabel(x), ylabel(y);
set(gcf, 'Position',  [100, 100, L*500, H*500]);


%% Plot 8 - Velocity Vectors
figure(8);
quiver(v.vxP,v.vyP)
title(sprintf('Nodal Velocity Vectors R = %0.3f [m]',r));
x = sprintf('Nodes X  = %d      L  =  %d  [m]',N,L);
y = sprintf('NodesY  = %d       H  =  %d  [m]',M,H); 
xlabel(x), ylabel(y);
set(gcf, 'Position',  [100, 100, L*500, H*500]);


end
