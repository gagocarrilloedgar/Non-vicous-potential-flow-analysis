function v = ComputeVelocities(nodes, mesh, vel, stream,mat)

    dx = mesh.dx;
    dy = mesh.dy;
    
    vp = mat.id * vel;
    for i=2:nodes.y-1
        for j=2:nodes.x-1     
            if mat.id(i,j)
                vye = (-stream(i,j+1)+stream(i,j))/dx;      
                vyw = (stream(i,j-1)-stream(i,j))/dx;
                vy(i,j) = (vye + vyw)/2;

                vxn = (-stream(i+1,j)+stream(i,j))/dy;      
                vxs = (stream(i-1,j)-stream(i,j))/dy;
                vx(i,j) = (vxn + vxs)/2;

                vp(i,j) = sqrt(vx(i,j)^2 + vy(i,j)^2); 
            end
        end
    end

v = struct( 'vy',vy,'vx',vx,'vp',vp);
end