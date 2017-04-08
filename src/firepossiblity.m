function longevityarrary=firepossiblity(p1,p2)
% f = 0.5; % lightning
 EMPTY   = 1;
 TREE1   = 2;
 TREE2   = 3;
 BURNING = 4;
 cells = ones(250,250); %initiate the lattice
 longevityarrary=[];

 for f=0.01:0.01:1
     longevity=0;
 for i=1:500
    
    if i>1
    %increase the boundary wrap around like 1D CAs
    tilecells = cells([end 1:end 1], [end 1:end 1]);
 
    % count neighbors    
    nconv = conv2(double(tilecells==BURNING),[1 1 1; 1 0 1; 1 1 1],'same');
    neighbors = nconv(2:end-1,2:end-1);       
    
    %record the burning cells from pervious step
    burncells=(cells==BURNING);
       
    % trees with burning neighbors will burn
    toburn = ((cells==TREE1)+(cells==TREE2)).*(neighbors > 0);
    toburn1= (cells==TREE1).*toburn;
    toburn2= (cells==TREE2).*toburn;
    cells=cells+(toburn1*2)+toburn2; 
     
    % some trees get hit by lightning
    tolight = ((cells==TREE1)+(cells==TREE2)).*(rand(250,250)<f);
    tolight1= (cells==TREE1).*tolight;
    tolight2= (cells==TREE2).*tolight;
    cells=cells+(tolight1*2)+tolight2;  
    
    if numel(find((cells==TREE2)+(cells==TREE1)))==0
       longevity=i;
    end
    
    if longevity>0
    break
    end
    
    end
    % empties may come to life
    newgrowth1 = (cells==EMPTY).*(rand(250,250)<p1);
    newgrowth2 = (cells==EMPTY).*(rand(250,250)<p2);
    bothgrowth = newgrowth1.*newgrowth2;
    onlygrowth1= newgrowth1-bothgrowth;
    onlygrowth2= newgrowth2-bothgrowth;

    %flip corn to decide tree species in cellss with two tree species
    doubletreeindex=find(bothgrowth);
    doubletreenum=numel(doubletreeindex);
    if doubletreenum >0
       randomtree=randsample([2 3],doubletreenum,true);    
       for j=1:doubletreenum
           cells(doubletreeindex(j))=randomtree(j);
       end       
    end
    
    %update cells with new growing trees
    cells=cells+onlygrowth1+(onlygrowth2.*2); 
   
    if i>2
    %turn burning cells from previous step to empty cells
    cells=cells-(burncells.*3);
    end
    
 end
 longevityarrary=[longevityarrary,longevity];
 end
 plot(0.01:0.01:1,longevityarrary);
end
