function p2 = p2_genetic_algorithm(population_size, mutation_rate, num_generations)
    % This function will calculate p1
    % This code is based on the code from lecture 9
    genome_min = 0.0000000001;
    genome_max = 0.9999999999;
    % generate a vector of 50 evenly spaced numbers between min and max
    %genome_space = linspace(genome_min, genome_max, population_size); 
    
    population = repmat(GA1, 1, population_size);
    
    % initialize genome of the population
    for i = 1:population_size
        population(i).fitness = 0;
        population(i).genome = rand();
    end
    
    % mutate the population. Add/subtract a randomly selected number
    % between 0 and 1 from normal distribution.
    for j = 1:num_generations
        for k = 1:population_size
            modified_genome = population(k).genome + random('norm',0,mutation_rate,1,1);
            if (modified_genome <= genome_max && modified_genome >= genome_min)
                population(k).genome = modified_genome;
            else
                modified_genome = population(k).genome - random('norm',0,mutation_rate,1,1);
                if (modified_genome <= genome_max && modified_genome >= genome_min)
                    population(k).genome = modified_genome;
                end
            end
        end
        
        % Recompute the fitness
        for n = 1:population_size
            population(n).fitness = get_fitness (population(n).genome);
        end
        
        % sort the population by fitness in increasing order
        [~, sorted_idx] = sort([population.fitness]);
        population = population(sorted_idx);
        
        % replace the half of the population with low fitness with the
        % population with high fitness
        half_size = ceil (population_size/2);
        for t = 1:half_size
            population(t) = copy(population(half_size+randi(half_size)));
        end
    end
    % sort the population by fitness in increasing order
    [~, sorted_idx] = sort([population.fitness]);
    population = population(sorted_idx);
    p2 = population(sorted_idx(population_size));
end

