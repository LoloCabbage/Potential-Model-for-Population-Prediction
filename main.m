%% load dataset
addpath("functions");
dir_info = dir('urban_land'); % urban land data 
dir_info(1:2) = []; %remove the "."&".." FILE
scenarios = readtable('urban_land.csv'); % senario limitation
BETA = readtable('betas.csv'); %beta

%% run the model
tic
potential_pop('USA','SSP5',BETA,scenarios);
avg_pop('USA','SSP5','result_t');
toc

