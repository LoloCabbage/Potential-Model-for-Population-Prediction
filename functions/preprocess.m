function pop_cell = preprocess(pop,popheader,urban,urheader)
    [Pop_C,~] = coordinate_metrix(pop,popheader);
    [Urban_C,~] = coordinate_metrix(urban,urheader);
    
    %% conncected components
    urban_filtered = imboxfilt(urban,3);%filter range,if index = 1, there is no filtering
    cc  = bwconncomp(urban_filtered,8);
    numPixels = cellfun(@numel,cc.PixelIdxList);

    %% pop in each components
    pop_cell = cell(cc.NumObjects,1);
    for i = 1:cc.NumObjects
        X_urban_comp = Urban_C{1}(cc.PixelIdxList{1,i});
        Y_urban_comp = Urban_C{2}(cc.PixelIdxList{1,i});

        [j,~] = size(X_urban_comp);
        pop_comp = zeros(j,3);
        pop_comp(:,1) = X_urban_comp;
        pop_comp(:,2) = Y_urban_comp;
        for k = 1:j
            [~,xloc] = min(abs(Pop_C{1}(1,:)-X_urban_comp(k)));
            [~,yloc] = min(abs(Pop_C{2}(:,1)-Y_urban_comp(k)));
            d_pop = Pop_C{3}(yloc,xloc);
            pop_comp(k,3) = d_pop;
        end       
        nd_region = find(pop_comp(:,3)<0);%skip nodata value
        pop_comp(nd_region,:) = [];
        pop_cell{i} = pop_comp;
    end
end

