function [C,X_nc,Y_nc] = coordinate_metrix(value,header)
    width = header.CellExtentInWorldX; % size for one grid
    height = header.CellExtentInWorldY; % size for one grid
    XL = header.XWorldLimits; % boundary for X
    YL = header.YWorldLimits; % boundary for Y
    X_nc = round(XL(1)+0.5*width : width : XL(2)-0.5*width,-1); % caculate the X coordinate for each grid
    Y_nc = round(YL(2)-0.5*height : -height : YL(1)+0.5*height,-1); % caculate the Y coordinate for each grid
    [X_nc, Y_nc] = meshgrid(X_nc, Y_nc); % generate coordinate metrix 
    
    %%generate a three-dimension cell
    [vol,col] = size(X_nc);
    C = cell(3,vol,col);
    C{1} = X_nc;
    C{2} = Y_nc;
    C{3} = value;
end

