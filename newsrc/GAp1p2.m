% this code is based on the code from lector 9
classdef GAp1p2
    properties
      genome;
      fitness;
    end
    
    methods
        function new = copy(this)
            new = feval(class(this));
            p = properties(this);
            for i = 1:length(p)
                new.(p{i}) = this.(p{i});
            end
        end
    end
end
 