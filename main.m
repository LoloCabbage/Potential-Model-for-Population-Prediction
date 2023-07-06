%% load dataset
addpath("functions");
dir_info = dir('urban_land');
dir_info(1:2) = []; %remove the "."&".." FILE
scenarios = readtable('urban_land.csv');
BETA = readtable('betas.csv');

%% run the model
tic
potential_pop('USA','SSP5',BETA,scenarios);
avg_pop('USA','SSP5','result_t');
toc

