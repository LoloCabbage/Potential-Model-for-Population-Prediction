function avg_pop(region,ssp,resultfolder)
    for t = 1:8
        time = num2str(2020 + t*10);
        result_path = fullfile(resultfolder,region,strcat(region,"_",ssp,"_",time,".tif"));
        if exist(result_path,'file') == 2
            continue
        else 
            pop_dataset = dir(fullfile(resultfolder,region,ssp,time));
            filename1 = strcat(pop_dataset(3).folder,'\',pop_dataset(3).name);
            popinfo = geotiffinfo(filename1);
            for k = 3:size(pop_dataset,1) %remove the "."&".." FILE
                filename = strcat(pop_dataset(k).folder,'\',pop_dataset(k).name);
                [popdata,pop_header] = readgeoraster(filename, 'CoordinateSystemType', 'planar');
                geoTag = popinfo.GeoTIFFTags.GeoKeyDirectoryTag;
                pop_data_all{k} = popdata;     
                pop_mean = mean(cat(3,pop_data_all{:}),3);  
            end
            geotiffwrite(result_path, pop_mean, pop_header,'GeoKeyDirectoryTag',geoTag);
            disp(result_path)
        end 
    end
end