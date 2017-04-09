function forest_fire()
% This is the main function that calls other functions to execute forrest
% fire logic.

% 1. Two different GAs: initialize two different populations. Genomes 
% (growth rate/probability) in the first population are initialized using 
% random numbers between 0 and 1. Genomes in the second population are 
% numbers between 0 and 1 that are evenly spaced.
    population_size = 10;
    max_steps = 5000;
    number_of_firefighters = 0;
    num_of_generations = 100;
    mutation_rate = 0.05;
    num_of_species = 1;
    genome_min = 0.00001;
    genome_max = 0.99999;
 
    % initialize populations
    population1 = repmat(GAp1p2, 1, population_size);
    population2 = repmat(GAp1p2, 1, population_size);

    % initialize genomes and their fitness for population1
    for i = 1:population_size
        population1(i).fitness = 0;
        population1(i).genome = rand();
    end
    
    % initialize genomes and their fitness for population2
    if (num_of_species == 1)
        % if there is just one species, set population2 to 0
        for i = 1:population_size
            population2(i).fitness = 0;
            population2(i).genome = 0;
        end
    else
        % generate a vector of evenly spaced numbers between min and max
        genome_space = linspace(genome_min, genome_max, population_size); 
        % initialize genomes and their fitness for population2
        for i = 1:population_size
            population2(i).fitness = 0;
            population2(i).genome = genome_space(i);
        end
    end
  
% 2. run GA for both population1 and population2 for n number of
% generations to see the impact on forest growth. get biomass fitness
    biomass_or_longevity = 1;
    [pop1, pop2, pop_biomass] = run_GA_p1p2(population1, population2, num_of_generations, population_size, mutation_rate, biomass_or_longevity, max_steps, number_of_firefighters, num_of_species, genome_min, genome_max);
% get longevity fitness    
    biomass_or_longevity = 2;
    [pop3, pop4, pop_longevity] = run_GA_p1p2(population1, population2, num_of_generations, population_size, mutation_rate, biomass_or_longevity, max_steps, number_of_firefighters, num_of_species, genome_min, genome_max);
    
% 3. use the returned data for drawing the plots. 
    x_vals = [];
    x_pop1_vals = [];
    x_pop2_vals = [];
    x_pop3_vals = [];
    x_pop4_vals = [];
    y_biomass_vals = [];
    y_longevity_vals = [];
    for k = 1:num_of_generations
        x_vals(k) = k;
        x_pop1_vals(k) = mean(pop1(k,:));
        x_pop2_vals(k) = mean(pop2(k,:));
        x_pop3_vals(k) = mean(pop3(k,:));
        x_pop4_vals(k) = mean(pop4(k,:));
        y_biomass_vals(k) = mean(pop_biomass(k,:));
        y_longevity_vals(k) = mean(pop_longevity(k,:));
    end
    
%   3a. generations Vs growth rates (probabilities)
    figure;
    yyaxis left;
    title('Growth Rate (probability) Vs Generations');
    xlabel('Generations');
    plot(x_vals, x_pop1_vals);
    ylabel('p1 growth rate');
    if (num_of_species > 1)
        yyaxis right;
        plot(x_vals, x_pop2_vals);
        ylabel('p2 growth rate');
    end

%  3b. growth rate (p1) Vs BM & growth rate (p3) Vs longevity. growth rate
%  p1 and p3 are for population1
    figure;
    yyaxis left;
    title('Growth Rate (probability) Vs Fitness');
    xlabel('Growth rate');
    plot(x_pop1_vals, y_biomass_vals);
    ylabel('Biomass');
    yyaxis right;
    plot(x_pop3_vals, y_longevity_vals);
    ylabel('Longevity');

%  3c. growth rate (p2) Vs BM & growth rate (p4) Vs longevity. growth rate
%  p2 and p4 are for population2
    figure;
    yyaxis left;
    title('Growth Rate (probability) Vs Fitness');
    xlabel('Growth rate');
    plot(x_pop2_vals, y_biomass_vals);
    ylabel('Biomass');
    yyaxis right;
    plot(x_pop4_vals, y_longevity_vals);
    ylabel('Longevity');
    
end

