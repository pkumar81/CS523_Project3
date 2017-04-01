function p1 = run_GA_p1p2(population1, population2, num_of_generations, population_size, mutation_rate, genome_min, genome_max)
    % This function will mutate the genomes (probabilities) of both
    % population1 and population2. fitness of genomes are computed every
    % generations using either biomass or longevity. Half of the population
    % with bad fitness are replaced by genomes with good fitness
    
    % mutate the populations
    for j = 1:num_of_generations
        % mutate the genomes of population1 . Add/subtract a randomly
        % selected number between 0 and 1 from uniform continuous distribution.
        for k = 1:population_size
            modified_genome = population1(k).genome + random('unif',0,mutation_rate,1,1);
            if (modified_genome <= genome_max && modified_genome >= genome_min)
                population1(k).genome = modified_genome;
            else
                modified_genome = population1(k).genome - random('unif',0,mutation_rate,1,1);
                if (modified_genome <= genome_max && modified_genome >= genome_min)
                    population1(k).genome = modified_genome;
                end
            end
        end
        
        % mutate the genomes of population2 . Add/subtract a randomly
        % selected number between 0 and 1 from normal distribution.
        for k = 1:population_size
            modified_genome = population2(k).genome + random('norm',0,mutation_rate,1,1);
            if (modified_genome <= genome_max && modified_genome >= genome_min)
                population2(k).genome = modified_genome;
            else
                modified_genome = population2(k).genome - random('norm',0,mutation_rate,1,1);
                if (modified_genome <= genome_max && modified_genome >= genome_min)
                    population2(k).genome = modified_genome;
                end
            end
        end
        %disp(population2(1).genome);
        % Recompute the fitness
        p1 = [];
        p2 = [];
        for m = 1:population_size
            p1(m) = population1(m).genome;
            p2(m) = population2(m).genome;
        end
        biomass_or_longevity = 1; %randi(1);
        f1 = get_fitness(p1, p2, population_size, biomass_or_longevity);
        %f2 = get_fitness(p1, p2, population_size, biomass_or_longevity);
        f2 = f1;
        disp(f1);
        disp(f2);
        
        for m = 1:population_size
            population1(m).fitness = f1(m);
            population2(m).fitness = f2(m);
        end
        
        % sort the population by fitness in increasing order
        [~, sorted_idx1] = sort([population1.fitness]);
        population1 = population1(sorted_idx1);
        
        [~, sorted_idx2] = sort([population2.fitness]);
        population2 = population2(sorted_idx2);

        % replace the half of the population with low fitness with the
        % population with high fitness
        half_size = ceil (population_size/2);
        for t = 1:half_size
            population1(t) = copy(population1(half_size+randi(half_size)));
            population2(t) = copy(population2(half_size+randi(half_size)));
        end
    end
end

