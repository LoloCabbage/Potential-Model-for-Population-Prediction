function pop_distribute = pop_metrix(urban_t2,urheader,pop_combine)
    pop_distribute = zeros(size(urban_t2));
    [~,pop_X,pop_Y] = coordinate_metrix(urban_t2,urheader);
    [col,row] = size(urban_t2);
    for i = 1:col
        for j = 1:row
            pop_x = pop_X(i,j);
            pop_y = pop_Y(i,j);
            value_row = find(all(pop_combine(:,1:2)==[pop_x,pop_y],2));
            if isempty(value_row) == 1
                pop_distribute(i,j) = 0;
            else
                pop_distribute(i,j) = pop_combine(value_row,6);
            end

        end
    end
end

