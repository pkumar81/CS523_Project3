# CS523_Project3
CS523 Project 3: Modelling


1 To generate additional plots

forest_fire.m is the main driver program that calls the downline programs to evolve GAs, to compute fitness values, and to draw some of the plots. The deafult values of the following parameters have been set in this program. Edit it, if you want to change any of these parameters.

    population_size = 10;
    max_steps = 5000;
    number_of_firefighters = 0;
    num_of_generations = 100;
    mutation_rate = 0.05;
    num_of_species = 2;
    genome_min = 0.0;
    genome_max = 1.0;
    biomass_or_longevity = 1;

Then, open this program (forest_fire.m) in matlab and execute it from command line or by clicking the run button. It takes more than 5 hours to finish, but at the end of the execution, it will generates several plots. This program calls no_image version of biomass and longevity so that it can finish quicker. But, if you want to see the visuals for growth and burning of trees, do the following changes in code get_fitness.m and then run forest_fire.m. This exeuction might take 7-8 hours.
   a) change function 'biomass_no_image' to 'biomass'
   b) chnage function 'longevity_no_image' to 'longevity'
 


2 To generate additional plots
   1) Download the folder newsrc.
   2) run script file figuregenerate.m to generate the figures.
