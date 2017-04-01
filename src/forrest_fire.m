function forrest_fire()
% This is the main function that calls other functions to execute forrest
% fire logic.

% 1. initialize the cells

% 2. Two different GAs, initialize two different populations
    population_size = 10;

    % initialize population1
    population1 = repmat(GAp1p2, 1, population_size);
    % initialize genomes and their fitness for population1
    for i = 1:population_size
        population1(i).fitness = 0;
        population1(i).genome = rand();
    end

    % initialize population2
    population2 = repmat(GAp1p2, 1, population_size);
    genome_min = 0.0000000001;
    genome_max = 0.9999999999;
    % generate a vector of evenly spaced numbers between min and max
    genome_space = linspace(genome_min, genome_max, population_size); 
    % initialize genomes and their fitness for population1
    for i = 1:population_size
        population2(i).fitness = 0;
        population2(i).genome = genome_space(i);
    end
   
%{
 3. call biomass function (to grow the forrest) using the initial
% probabilities
    %num_of_firefighters = randi(5000);
    num_of_firefighters = 0;
    biomass_or_longevity = randi(1);
    if (biomass_or_longevity == 1)
        for n = 1:population_size
            bmass = biomass_no_image(population1(n).genome, population2(n).genome, num_of_firefighters);
        end
    else
        for n = 1:population_size
            lngvity = longevity_no_image(population1(n).genome, population2(n).genome, num_of_firefighters);
        end
    end
 %}
    
% 4. run GA for both population1 and population2 for n number of
% generations to see the impact on forrest growth
    num_of_generations = 10;
    mutation_rate = 0.05;
    run_GA_p1p2(population1, population2, num_of_generations, population_size, mutation_rate, genome_min, genome_max);
end

