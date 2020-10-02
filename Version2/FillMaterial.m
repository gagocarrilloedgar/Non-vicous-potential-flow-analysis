function [mat] = FillMaterial(R,mesh)
    
    theta = linspace(0,2*pi, 200);
    
    % Create circumferece with center at the center of the mesh
    mat.x = R*cos(theta);
    mat.y = R*sin(theta);
    
    id = inpolygon(mesh.x, mesh.y, mat.x, mat.y);
    id = double(~id);
    mat.id = id;

end