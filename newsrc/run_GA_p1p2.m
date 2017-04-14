function [pop1, pop2, pop_fitness] = run_GA_p1p2(population1, population2, num_of_generations, population_size, mutation_rate, biomass_or_longevity, max_steps, number_of_firefighters,  num_of_species, genome_min, genome_max)
    % This function will mutate the genomes (probabilities) of both
    % population1 and population2. fitness of genomes are computed every
    % generations using either biomass or longevity. Half of the population
    % with bad fitness are replaced by genomes with good fitness.
    pop1 = [];
    pop2 = [];
    pop_fitness = [];
    % mutate the populations
    for j = 1:num_of_generations
        % mutate the genomes of population1 . Add/subtract a randomly
        % selected number between 0 and 1 from uniform continuous distribution.
        for k = 1:population_size
            modified_genome = population1(k).genome + random('unif',0,mutation_rate,1,1);
            if (modified_genome <= genome_max && modified_genome >= genome_min)
                population1(k).genome = modified_genome;
            %{
            else
                modified_genome = population1(k).genome - random('unif',0,mutation_rate,1,1);
                if (modified_genome <= genome_max && modified_genome >= genome_min)
                    population1(k).genome = modified_genome;
                end
             %}
            end
        end
        % if there is just one species, do not mutate population2
        if (num_of_species > 1)
            % mutate the genomes of population2 . Add/subtract a randomly
            % selected number between 0 and 1 from normal distribution.
            for k = 1:population_size
                modified_genome = population2(k).genome + random('norm',0,mutation_rate,1,1);
                if (modified_genome <= genome_max && modified_genome >= genome_min)
                    population2(k).genome = modified_genome;
              %{
                else
                    modified_genome = population2(k).genome - random('norm',0,mutation_rate,1,1);
                    if (modified_genome <= genome_max && modified_genome >= genome_min)
                        population2(k).genome = modified_genome;
                    end
                 %}
                end
            end
        end
        
        % Recompute the fitness of genomes in both populations
        p1 = [];
        p2 = [];
        for m = 1:population_size
            p1(m) = population1(m).genome;
            p2(m) = population2(m).genome;
        end
        
        % get_fitness function calls programs biomass or longevity
        % depending on the the value of biomass_or_longevity. When 
        % biomass_or_longevity is 1, biomass function is called and when 
        % biomass_or_longevity is 2, longevity function is called.

        %[f1,f2] = get_fitness2(p1, p2, population_size, biomass_or_longevity, max_steps, number_of_firefighters);
        
        new_fitness = get_fitness(p1, p2, population_size, biomass_or_longevity, max_steps, number_of_firefighters);
        % update populations with new fitness
        for m = 1:population_size
            population1(m).fitness = new_fitness(m);
            if (num_of_species > 1)
                population2(m).fitness = new_fitness(m);
            end
        end
        
        % updated populations (probabilities) and their fitness will be
        % returned to the calling program.
        pop1(j,:) = p1;
        pop2(j,:) = p2;
        pop_fitness(j,:) = new_fitness;
        
        % sort the population by fitness in increasing order
        [~, sorted_idx1] = sort([population1.fitness]);
        population1 = population1(sorted_idx1);
        
        [~, sorted_idx2] = sort([population2.fitness]);
        population2 = population2(sorted_idx2);

        % replace the half of the population with low fitness with the
        % population with high fitness
        half_size = ceil(population_size/2);
        for t = 1:half_size
            population1(t) = copy(population1(half_size+randi(half_size)));
            population2(t) = copy(population2(half_size+randi(half_size)));
        end
    end
end

