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
    num_of_species = 2;
    genome_min = 0.0;
    genome_max = 1.0;
    biomass_or_longevity = 1;
 
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
    [pop1, pop2, pop_biomass] = run_GA_p1p2(population1, population2, num_of_generations, population_size, mutation_rate, biomass_or_longevity, max_steps, number_of_firefighters, num_of_species, genome_min, genome_max);

% get longevity fitness.
    %biomass_or_longevity = 2;
    %[pop3, pop4, pop_longevity] = run_GA_p1p2(population1, population2, num_of_generations, population_size, mutation_rate, biomass_or_longevity, max_steps, number_of_firefighters, num_of_species, genome_min, genome_max);
    
% 3. use the returned data for drawing the plots. The codes in section 3,
% use average of p1, p2, biomass, and longevity to draw the plot.
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
        %x_pop3_vals(k) = mean(pop3(k,:));
        %x_pop4_vals(k) = mean(pop4(k,:));
        y_biomass_vals(k) = mean(pop_biomass(k,:));
        %y_longevity_vals(k) = mean(pop_longevity(k,:));
    end
    
%   3a. growth rates (probabilities)vs generations
    figure;
    yyaxis left;
    title('Growth Rate (probability) Vs Generations', 'FontSize', 14);
    xlabel('Generations', 'FontSize', 14);
    [~,idx]=sort(x_vals); %sort in ascending order for plot
    x_vals = x_vals(idx);
    x_pop1_vals = x_pop1_vals(idx);
    plot(x_vals, x_pop1_vals);
    ylim([min(x_pop1_vals) 1.1]);
    ylabel('p1 growth rate', 'FontSize', 14);
    if (num_of_species > 1)
        yyaxis right;
        [~,idx] = sort(x_vals); %sort in ascending order for plot
        x_vals = x_vals(idx);
        x_pop2_vals = x_pop2_vals(idx);
        plot(x_vals, x_pop2_vals);
        ylim([min(x_pop2_vals) 1.1]);
        ylabel('p2 growth rate', 'FontSize', 14);
    end

% 3b. growth rate (p1) Vs BM & growth rate (p3) Vs longevity. growth rate
%  p1 and p3 are for population1
    figure;
    yyaxis left;
    title('Fitness Vs Growth Rate (probability)', 'FontSize', 14);
    xlabel('Growth rate(p1)', 'FontSize', 14);
    [~,idx] = sort(x_pop1_vals); %sort in ascending order for plot
    x_pop1_vals = x_pop1_vals(idx);
    y_biomass_vals = y_biomass_vals(idx);
    plot(x_pop1_vals, y_biomass_vals);
    ylabel('Biomass', 'FontSize', 14);
    xlim([min(x_pop1_vals) 1.1]);
    yyaxis right;
    [~,idx] = sort(x_pop3_vals); %sort in ascending order for plot
    x_pop3_vals = x_pop3_vals(idx);
    y_longevity_vals = y_longevity_vals(idx);
    plot(x_pop3_vals, y_longevity_vals);
    ylabel('Longevity', 'FontSize', 14);

    if (num_of_species > 1)    
    %  3c. growth rate (p2) Vs BM & growth rate (p4) Vs longevity. growth rate
    %  p2 and p4 are for population2
        figure;
        yyaxis left;
        title('Fitness Vs Growth Rate (probability)', 'FontSize', 14);
        xlabel('Growth rate(p2)', 'FontSize', 14);
        [~,idx] = sort(x_pop2_vals); %sort in ascending order for plot
        x_pop2_vals = x_pop2_vals(idx);
        y_biomass_vals = y_biomass_vals(idx);
        plot(x_pop2_vals, y_biomass_vals);
        ylabel('Biomass', 'FontSize', 14);
        xlim([min(x_pop2_vals) 1.1]);
        yyaxis right;
        [~,idx] = sort(x_pop4_vals); %sort in ascending order for plot
        x_pop4_vals = x_pop4_vals(idx);
        y_longevity_vals = y_longevity_vals(idx);
        plot(x_pop4_vals, y_longevity_vals);
        ylabel('Longevity', 'FontSize', 14);
    end
   
% 4. use the returned data for drawing the plots. The codes in section 3,
% use best values of biomass and the corresponding p1, p2 to draw the
% plots.
    x_vals = [];
    x_pop1_vals = [];
    x_pop2_vals = [];
    y_biomass_vals = [];
    x_all_pop1_vals = [];
    x_all_pop2_vals = [];
    y_all_biomass_vals = [];
    for k = 1:num_of_generations
        x_vals(k) = k;
        row_biomass = pop_biomass(k,:);
        max_biomass = max(row_biomass);
        b_idx = find(row_biomass==max_biomass);
        y_biomass_vals(k) = max_biomass;
        row_pop1 = pop1(k,:);
        row_pop2 = pop2(k,:);
        x_pop1_vals(k) = row_pop1(b_idx);
        x_pop2_vals(k) = row_pop2(b_idx);
        x_all_pop1_vals = cat(2, x_all_pop1_vals, row_pop1);
        x_all_pop2_vals = cat(2, x_all_pop2_vals, row_pop2);
        y_all_biomass_vals = cat(2, y_all_biomass_vals, row_biomass);
    end
    
%   4a. growth rates (probabilities) vs generations plots
    figure;
    yyaxis left;
    title('Growth Rate (probability) Vs Generations', 'FontSize', 14);
    xlabel('Generations', 'FontSize', 14);
    [~,idx]=sort(x_vals); %sort in ascending order for plot
    x_vals = x_vals(idx);
    x_pop1_vals = x_pop1_vals(idx);
    plot(x_vals, x_pop1_vals);
    ylim([min(x_pop1_vals) 1.1]);
    ylabel('p1 growth rate', 'FontSize', 14);
    if (num_of_species > 1)
        yyaxis right;
        [~,idx] = sort(x_vals); %sort in ascending order for plot
        x_vals = x_vals(idx);
        x_pop2_vals = x_pop2_vals(idx);
        plot(x_vals, x_pop2_vals);
        ylim([min(x_pop2_vals) 1.1]);
        ylabel('p2 growth rate', 'FontSize', 14);
    end
    
%  4b. Biomass vs growth rates (p1, and p2) plots 
    figure;
    [~,idx] = sort(x_pop1_vals); %sort in ascending order for plot
    x_pop1_vals = x_pop1_vals(idx);
    y_biomass_vals = y_biomass_vals(idx);
    plot(x_pop1_vals, y_biomass_vals);
    xlim([min(x_pop1_vals) 1.1]);
    title('Fitness (BM) Vs Growth Rate (probability)', 'FontSize', 14);
    xlabel('Growth rate (p1)', 'FontSize', 14);
    ylabel('Biomass', 'FontSize', 14);
    %  BM vs p2
    if (num_of_species > 1)
        figure;
        [~,idx] = sort(x_pop2_vals); %sort in ascending order for plot
        x_pop2_vals = x_pop2_vals(idx);
        y_biomass_vals = y_biomass_vals(idx);
        plot(x_pop2_vals, y_biomass_vals);
        xlim([min(x_pop2_vals) 1.1]);
        title('Fitness (BM) Vs Growth Rate (probability)', 'FontSize', 14);
        xlabel('Growth rate (p2)', 'FontSize', 14);
        ylabel('Biomass', 'FontSize', 14);
    end
%  4c. there will be 1000 biomass values (100 generations * 10 population size)and 1000 probabilities for each 
% population.  Draw plots BM vs probabilities using all 1000 values.
    figure;
    [~,idx] = sort(x_all_pop1_vals); %sort in ascending order for plot
    x_all_pop1_vals = x_all_pop1_vals(idx);
    y_all_biomass_vals = y_all_biomass_vals(idx);
    plot(x_all_pop1_vals, y_all_biomass_vals);
    xlim([min(x_all_pop1_vals) 1.1]);
    title('Fitness (BM) Vs Growth Rate (probability)', 'FontSize', 14');
    xlabel('Growth rate (p1)', 'FontSize', 14);
    ylabel('Biomass', 'FontSize', 14);  
    % BM vs p2.  
    if (num_of_species > 1)
        figure;
        [~,idx] = sort(x_all_pop2_vals); %sort in ascending order for plot
        x_all_pop2_vals = x_all_pop2_vals(idx);
        y_all_biomass_vals = y_all_biomass_vals(idx);
        plot(x_all_pop2_vals, y_all_biomass_vals);
        xlim([min(x_all_pop2_vals) 1.1]);
        title('Fitness (BM) Vs Growth Rate (probability)', 'FontSize', 14);
        xlabel('Growth rate (p2)', 'FontSize', 14);
        ylabel('Biomass','FontSize', 14);  
    end
% 5. find the values of p1 and p2 that maximize biomass
    top_biomass = max(y_all_biomass_vals);
    top_idx = find(y_all_biomass_vals == top_biomass);
    disp(x_all_pop1_vals(top_idx));
    if (num_of_species > 1)
        disp(x_all_pop2_vals(top_idx));
    end
   
end

