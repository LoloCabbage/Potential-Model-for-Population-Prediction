# Potential-Model-for-Population-Prediction
# How to run Potential Model to predict population

just run the MAIN.m to get a result for one region, one ssp scenario  
run the MAIN_ALL.m to predict the population for all areas  
run the MAIN_CLUSTER.m  with HPC Clusters

-------------------------
default setting ：  

regions：2 (change n for more)  
SSP:2 (change i for more)  
decades：2 (change t for more)  
Monte Carlo:2 (change m for more, parfor) 

beta scenario： BATA.q（25%）  
IF YOU WANT TO RUN DIFFERENT BETA SCENARIOS (eg.50%):  
OPEN the initial_con function   
-> find line 4  
-> change the BETA.q to BETA.h(or BETA.t)  
run the main.m again (suggest change the line 49 to create a new dir for storing your data)  

-------------------------
INPUT FILES:  
urban_land -> urban land distribution from 2020 to 2100   
		  0 for non-urban areas, 1 for urban areas  
		  a population image of 2020 under each region file  
		  
betas -> beta for different regions with different scenarios  
	   (q:25%,h:50%,t:75%)
-------------------------
OUTPUT FILES :  
result_q -> place for the population distribution from 2020 to 2100 under different SSP with the beta(q:25%)
	    
-------------------------
# Urban land Data
# Reference
