function neighbours = moore_neighbourhood(grid_size, cell_location, range)
% This function will find the neighbours of a given cell in the given grid. 
% r=1 for the adjacent neighbours.
    
    x_max = grid_size(1);
    y_max = grid_size(2);
    x0 = cell_location(1);
    y0 = cell_location(2);
    
    max_neighbours = power((2*range + 1),2);  %max neighbours for a given cell
    n_count = 1; %neighbour count
    
    for i = -1*range:1*range
        for j = -1*range:1*range
            x= x0 + j;
            y = y0 + i;
            if ((x >=1 && x<=x_max) && (y >=1 && y<=y_max) && (x ~= x0 || y ~= y0))
                neighbours(n_count,1) = x;
                neighbours(n_count,2) = y;
                n_count = n_count+1;
            end
        end
    end
    
    if (n_count > max_neighbours)
        disp ('Something Wrong!!!, neighbour count is incorrect');
    end
end
