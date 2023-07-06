%% load dataset
addpath("functions/");
dir_info = dir('urban_land');
dir_info(1:2) = []; %remove the "."&".." FILE
scenarios = readtable('urban_land.csv');
BETA = readtable('betas.csv');
resultfolder = 'result_t';

%% run the model
%for n = 1:length(dir_info)
for n = 25
    region= dir_info(n).name;
     for i = 1:5
        ssp =  strcat("SSP",num2str(i)); 
        tic
        disp([region,ssp]);
        %potential_pop(region,ssp,BETA,scenarios,resultfolder);
        avg_pop(region,ssp,resultfolder);
        toc
     end
end
