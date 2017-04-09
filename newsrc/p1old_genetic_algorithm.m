function p1 = p1_genetic_algorithm(method, mutation_rate)

% This function will use genetic algorithm to compute probability (p1)
    mutation_operation = {'insert', 'delete','update','swap'};
    num_of_mutation_operations = size(mutation_operation, 2);
    genome_length = 24;
    genome = sprintf('%d', round(rand(1, genome_length))); %generate string of 0 & 1
    
    switch method
        case 'mutation'
            if (mutation_rate < rand(1,1))
                oper_idx = randi([1,num_of_mutation_operations]); % which mutation operator
                if(strcmp(mutation_operation(oper_idx), 'insert'))
                    % insert 0 or 1 at the end of the binary string
                    new_char = sprintf('%d', round(rand(1, 1))); % generate 0 or 1
                    new_pos = genome_length + 1;
                    genome(new_pos) = new_char;  % append a new character
                    disp ('insert performed');
                elseif(strcmp(mutation_operation(oper_idx), 'delete'))
                    % delete a bit character from the bit string
                    del_pos = randi([1, genome_length]); % delete position
                    if (del_pos >= 1 && del_pos <= genome_length)
                        modified_genome = strcat(genome(1:del_pos-1), genome(del_pos+1:genome_length));
                        genome = modified_genome;
                    end
                    disp ('delete performed');
                elseif(strcmp(mutation_operation(oper_idx), 'update'))
                    % replace 0 by 1 and vice-versa
                    upd_pos = randi([1, genome_length]); % update position
                    if (genome(upd_pos) == '0')
                        modified_genome = strcat(genome(1:upd_pos-1), '1', genome(upd_pos+1:genome_length));
                    elseif(genome(upd_pos) == '1')
                        modified_genome = strcat(genome(1:upd_pos-1), '0', genome(upd_pos+1:genome_length));
                    end
                    genome = modified_genome;
                    disp ('update performed');
                elseif(strcmp(mutation_operation(oper_idx), 'swap'))
                    % swap two bit strings
                    swap_pos = randi([1,genome_length],1,2);  % randomly select 2 positions
                    if(swap_pos(1) < swap_pos(2)) 
                       modified_genome = strcat(genome(1:swap_pos(1)-1), genome(swap_pos(2)), genome(swap_pos(1)+1:swap_pos(2)-1), genome(swap_pos(1)), genome(swap_pos(2)+1:genome_length));
                    elseif(swap_pos(1) > swap_pos(2)) 
                        modified_genome = strcat(genome(1:swap_pos(2)-1), genome(swap_pos(1)), genome(swap_pos(2)+1:swap_pos(1)-1), genome(swap_pos(2)), genome(swap_pos(1)+1:genome_length));
                    else
                        modified_gnome = genome;
                    end
                    genome = modified_genome;
                    disp ('swap performed');
                else
                    fprintf('Wrong operation!!!\n');
                end
            else
                fprintf('No mutation performed!!!\n');
            end
    end
    genome_int = bin2dec(genome); %convert binary to decimal
    p1 = str2double(strcat('0.', num2str(genome_int)));
    disp(p1);
end

