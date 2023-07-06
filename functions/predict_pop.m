function [total_pop,pop_combine] = predict_pop(beta,total_con,pop_cell_t1)
    total_pop = 0;
    for i = 1:length(pop_cell_t1)
        [GridNum,~] = size(pop_cell_t1{i});
        points_xy = pop_cell_t1{i}(:,1:2);
        distance_metrix = squareform(pdist(points_xy)/1000);
        x = exp(distance_metrix*-beta)-eye(GridNum);
        pop_cell_t1{i}(:,4) = x*pop_cell_t1{i}(:,3); %population increase for one component
        pop_cell_t1{i}(:,5)  = pop_cell_t1{i}(:,3)+pop_cell_t1{i}(:,4); %predicted population for one component
        total_pop = total_pop+sum(pop_cell_t1{i}(:,5)); 
    end
    pop_combine = cell2mat(pop_cell_t1);
    scale_para = total_con/total_pop;
    pop_combine(:,6) = pop_combine(:,5)*scale_para;
end

