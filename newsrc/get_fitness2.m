 %method using the max(p1,p2) as p, the smallest p will return zero as fitness, 
 %the bigger one will get fitness from biomass or longevity test
 
function [fitness1,fitness2] =  get_fitness2(genome1, genome2 ,population_size, index, max_steps, number_of_firefighters)
    if index==1
       for i=1:population_size
           if genome1(i)>genome2(i)
              fitness1(i) = biomass(genome1(i), 0, number_of_firefighters, max_steps);
              fitness2(i)=0;
           elseif genome1(i)<genome2(i)
              fitness2(i) = biomass(genome2(i), 0, number_of_firefighters, max_steps);
              fitness1(i)=0;
           else
              fitness1(i) = biomass(genome1(i), 0, number_of_firefighters, max_steps);
              fitness2(i)=fitness1(i);
           end
       end
    end
    if index==2
       for i=1:population_size
           if genome1(i)>genome2(i)
              fitness1(i) = longevity_no_image(genome1(i), 0, number_of_firefighters, max_steps);
              fitness2(i)=0;
           elseif genome1(i)<genome2(i)
              fitness2(i) = longevity_no_image(genome2(i), 0, number_of_firefighters, max_steps);
              fitness1(i)=0;
           else
              fitness1(i) = longevity_no_image(genome1(i), 0, number_of_firefighters, max_steps);
              fitness2(i)=fitness1(i);
           end
       end
    end 
end
