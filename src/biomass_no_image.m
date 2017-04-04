%p1 and p2 are the gowth rate, Num is the number of fire fighters, set p2 or and Num as zero if not exist.
function  everagebiomass=biomass_no_image(p1,p2,Num)
       max_steps = 50;
       if (p2==0)&&(Num==0)
	      everagebiomass=tree1(p1, max_steps);
       elseif (p2>0)&&(Num==0)
	      everagebiomass=tree2(p1, p2, max_steps);
       elseif (p2>0)&&(Num>0)
	      everagebiomass=tree_firefighter(p1, p2, Num, max_steps);
	   end
end

%function which take 1 tree species, return the everage biomass on 5000 steps
function everagebiomass=tree1(p, max_steps)
 f = 0.001; % lightning
 EMPTY   = 1;
 TREE    = 2;
 BURNING = 3;
 cells = ones(250,250); %initiate the lattice
 biomass=[];
 total=0;
  
 for i=1:max_steps
    if i>1  %implement fire from step 2
    %increase the boundary wrap around like 1D CAs
    tilecells = cells([end 1:end 1], [end 1:end 1]);
 
    % count neighbors    
    nconv = conv2(double(tilecells==BURNING),[1 1 1; 1 0 1; 1 1 1],'same');
    neighbors = nconv(2:end-1,2:end-1);   
    
    %record the burning cells from previous step
    burncells=(cells==BURNING);      
    
    % trees with burning neighbors will burn
    toburn = (cells==TREE).*(neighbors > 0);
    cells=cells+toburn;
    
    % some trees get hit by lightning
    lightning = (cells==TREE).*(rand(250,250)<f);
    cells=cells+lightning;   
    end

    % empties may come to life
    newgrowth = (cells==EMPTY).*(rand(250,250)<p);
    cells=cells+newgrowth;
    
    %turn burning cells from pervious step to empty cells
    if i>2
    cells=cells-(burncells.*2);    
    end

    %store the biomass every step
    biomass=[biomass,numel(find(cells==TREE))/62500];
    
 end

 %caculate the everage biomass
 biomass_index=numel(biomass);
 for k=1:biomass_index
    total=total+biomass(k);
 end
 everagebiomass=total/biomass_index;

end

%function takes two species of trees
function everagebiomass=tree2(p1, p2, max_steps)
 f = 0.001; % lightning
 EMPTY   = 1;
 TREE1   = 2;
 TREE2   = 3;
 BURNING = 4;
 cells = ones(250,250); %initiate the lattice
 biomass=[];
 total=0;
 
 for i=1:max_steps
    
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

    %stor the biomass every step
    biomass=[biomass,numel(find((cells==TREE1)+(cells==TREE2)))/62500];
    
 end

 %caculate the everage biomass
 biomass_index=numel(biomass);
 for k=1:biomass_index
    total=total+biomass(k);
 end
 everagebiomass=total/biomass_index;
end

%function takes firefighters
function everagebiomass=tree_firefighter(p1, p2, Num, max_steps)
 f = 0.001; % lightning
 N=Num;
 EMPTY   = 1;
 TREE1   = 2;
 TREE2   = 3;
 BURNING1 = 4;
 BURNING2 = 5;
 EXTINGUISHED1 =6;
 EXTINGUISHED2 =7;
 cells = ones(250,250); %initiate the lattice
 biomass=[];
 total=0;
 
 for i=1:max_steps    
     
    if i>1
    %increase the boundary wrap around like 1D CAs
    tilecells = cells([end 1:end 1], [end 1:end 1]);

    % count neighbors    
    nconv = conv2(double((tilecells==BURNING1)+(tilecells==BURNING2)),[1 1 1; 1 0 1; 1 1 1],'same');
    neighbors = nconv(2:end-1,2:end-1);    
  
    if i>3
    %turn cells with trees which were extinguished to refresh trees
    cells=cells-((cells==EXTINGUISHED1)*4);
    cells=cells-((cells==EXTINGUISHED2)*4);  
    end
    
    %record the burning cells from pervious step
    burncells1=(cells==BURNING1);
    burncells2=(cells==BURNING2);
    burncells=burncells1+burncells2;
    
    if i>2
    %implement with fire fighters
    %find out the burning cells index
    fire_cells_index = find(burncells);
    %count the number of burning cells
    firecellsnum=numel(fire_cells_index); 
    %if the number of burning cells is less the the settled number of fire
    %fighters, swap N and firecellsnum
    	if firecellsnum < N
      	   N = firecellsnum;     
    	end
    %randomly choose N number of burning cellss, variable
    %fire_cells_extinguished_index stores the index of burning cells chose by
    %fire fighters
    fire_cells_extinguished_index = randsample(fire_cells_index,N);
    index=numel(fire_cells_extinguished_index);
    %change the burning cells to extinguished cells (trees)
     for j=1:index
    	    temp=cells(fire_cells_extinguished_index(j))+ 2;
            cells(fire_cells_extinguished_index(j))=temp;
   	 end        
    % restore the number of N
    N=Num;   
    end
    
    % trees with burning neighbors will burn
    toburn = ((cells==TREE1)+(cells==TREE2)).*(neighbors > 0);
    cells=cells+(toburn*2); 
     
    % some trees get hit by lightning
    tolight = ((cells==TREE1)+(cells==TREE2)).*(rand(250,250)<f);
    cells=cells+(tolight*2);      

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
    cells=cells-((burncells1-(cells==EXTINGUISHED1))*3)-((burncells2-(cells==EXTINGUISHED2))*4);
    end 
  
    %stor the biomass every step
    biomass=[biomass,numel(find((cells==TREE1)+(cells==TREE2)+(cells==EXTINGUISHED1)+(cells==EXTINGUISHED2)))/62500];
    
 end

 %caculate the everage biomass
 biomass_index=numel(biomass);
 for k=1:biomass_index
    total=total+biomass(k);
 end
 everagebiomass=total/biomass_index;
end

