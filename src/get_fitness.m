function fitness =  get_fitness(genome_value,index)
% This is a temp function for testing
    if index=1
    fitness = bimass_no_image(genome_value);
    end
    if index=2
    fitness = longevity_no_image(genome_value);
    end
end

