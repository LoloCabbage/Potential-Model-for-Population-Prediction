%% load dataset
addpath("functions");
dir_info = dir("urban_land");
dir_info(1:2) = []; %remove the "."&".." FILE
scenarios = readtable('urban_land.csv');
BETA = readtable('betas.csv');

%% run the model
c = parcluster;
c.AdditionalProperties.WallTime = '10:00:00';
c.AdditionalProperties.ProcsPerNode = 1; 
c.AdditionalProperties.MemUsage = '2gb';

%for n = 2:length(dir_info)
for n = 1:length(dir_info)
    region= dir_info(n).name;
     for i = 1:5
            ssp =  strcat("SSP",num2str(i)); 
            disp(['Submit:',region,ssp]);
            c.batch(@potential_pop,0,{region,ssp,BETA,scenarios}, ...
                'Pool',11,'CurrentFolder','/scratch/xg2322/pop_prediction_cluster/potential');
     end
end
