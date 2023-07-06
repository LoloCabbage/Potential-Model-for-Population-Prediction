function [beta,pop2020,popheader,popinfo] = Initial_con(BETA,region)
    alldatafolder = 'urban_land';
    beta = BETA.q(strcmp(BETA.REGION, region)); %% 0.25 ->q,0.5 ->h,0.75->t
    pop_img = strcat("pop_",region,"_00",".tif");
    pop_path = fullfile(alldatafolder,region,pop_img);
    [pop2020, popheader] = readgeoraster(pop_path, 'CoordinateSystemType', 'planar');
    popinfo = geotiffinfo(pop_path);
    
end

