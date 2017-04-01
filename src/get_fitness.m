%index branch get_fitness function to biomass or longevity, if index=1, use biomass fitness function, if index=2, use longevity fitness function
%genome[] is a array which contains the genome value (p) from one generation
%fitness[] is a array which contains the fitness for one generation 
function fitness =  get_fitness(genome1, genome2 ,population_size,index)
%method using p1 and p2 in the same forest, return the same fitness for both p1 and p2
    if index==1
       for i=1:population_size
           fitness(i) = biomass(genome1(i),genome2(i),0);
       end
    end
    if index==2
       for i=1:population_size
           fitness(i) = longevity(genome1(i),genome2(i),0);
       end
    end 
end

