function potential_pop(region,ssp,BETA,scenarios,resultfolder)
    alldatafolder = 'urban_land';
    [beta,pop2020,popheader,popinfo] = Initial_con(BETA,region);
    geoTag = popinfo.GeoTIFFTags.GeoKeyDirectoryTag;
    
    parfor m = 1:100
        for t = 1:8 %time, unit: decade
            time1 = num2str(2010 + t*10); %t1
            time2 = num2str(2020 + t*10); %t2
            index_m = num2str(m);% index of Monte Carlo
            result_path = fullfile(resultfolder,region,ssp,time2,strcat(index_m,".tif"));
            if exist(result_path,'file') == 2
                continue
            else 
                %% urban info
                file_list1 = dir(fullfile(alldatafolder,region,ssp,time1, '*.tif'));
                file_list2 = dir(fullfile(alldatafolder,region,ssp,time2, '*.tif'));
                urban_patht1 = fullfile(file_list1(m).folder,file_list1(m).name);
                urban_patht2 = fullfile(file_list2(m).folder,file_list2(m).name);
                [urban_t1,urheader]= readgeoraster(urban_patht1, 'CoordinateSystemType', 'planar');
                urban_t1(urban_t1<0)=0;
                urban_t2 = readgeoraster(urban_patht2);     
                %% get pop in urban components
                if t == 1 % the first time of prediction
                    pop_cell_t1 = preprocess(pop2020,popheader,urban_t1,urheader);
                else
                    pop_t1 = fullfile(resultfolder,region,ssp,time1,strcat(index_m,".tif"));
                    pop_distribute =  readgeoraster(pop_t1, 'CoordinateSystemType', 'planar');
                    pop_cell_t1 = preprocess(pop_distribute,urheader,urban_t1,urheader);
                end

                %% senario condition
                idx =  strcmp(scenarios.SCENARIO, ssp) & strcmp(scenarios.Region32, region) & (scenarios.year == 2020 + t*10);
                total_con = scenarios.urban_pop(idx)*1000000;
                
                % predict population in each cell
                [~,pop_combine] = predict_pop(beta,total_con,pop_cell_t1);
                
                %% cell to raster
                pop_distribute = pop_metrix(urban_t2,urheader,pop_combine);

                %% write img
                outfile_path = fullfile(resultfolder,region,ssp,time2);
                if exist(outfile_path, 'dir') == 0 
                    mkdir(outfile_path);
                end
                geotiffwrite(result_path, pop_distribute, urheader,'GeoKeyDirectoryTag',geoTag);
                disp(result_path)
            end
        end
    end
end