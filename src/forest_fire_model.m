%p is the gowth rate, Num is the number of fire fighters
function  everagebiomass=forest_fire(p1,p2,Num)
	if (p2==0)&&(Num==0)
	everagebiomass=tree1(p1);
    elseif (p2>0)&&(Num==0)
	everagebiomass=tree2(p1,p2);
    elseif (p2>0)&&(Num>0)
	everagebiomass=tree_firefighter(p1,p2,Num);
	end
end

%function which take 1 tree species, return the everage biomass on 5000
%steps
function everagebiomass=tree1(p)
f = 0.01; % lightning
EMPTY   = 0;
TREE    = 1;
BURNING = 2;
cell = zeros(250,250); %initiate the lattice
biomass=[];
sum=0;
 
for i=1:20
    pause(0.5);
    %increase the boundary wrap around like 1D CAs
    tilecell = cell([end 1:end 1], [end 1:end 1]);
 
    % count neighbors    
    nconv = conv2(double(tilecell==BURNING),[1 1 1; 1 0 1; 1 1 1],'same');
    neighbors = nconv(2:end-1,2:end-1);
    
    % empties may come to life
    newgrowth = (cell==EMPTY).*(rand(250,250)<p);
    cell=cell+newgrowth;
    
    %turn burning cell to empty cell
    cell=cell-((cell==BURNING).*2);      
    
    % trees with burning neighbors will burn
    toburn = (cell==TREE).*(neighbors > 0);
    cell=cell+toburn;
    
    % some trees get hit by lightning
    lightning = (cell==TREE).*(rand(250,250)<f);
    cell=cell+lightning;   
    
    %stor the biomass every step
    biomass=[biomass,numel(find(cell==TREE))/62500];
    
    %set the colormap range    
    map=[1 1 1;0 1 0;1 1 0];
    caxis([0 2]);    
    colormap(map);
    % view the cell
    imagesc(cell);     
    % plot
    drawnow;
end

%caculate the everage biomass
biomass_index=numel(biomass);
for k=1:biomass_index
    sum=sum+biomass(k);
end
everagebiomass=sum/biomass_index;

end

function everagebiomass=tree2(p1,p2)
f = 0.001; % lightning
EMPTY   = 0;
TREE1   = 1;
TREE2   = 2;
BURNING = 3;
cell = zeros(250,250); %initiate the lattice
biomass=[];
sum=0;
 
for i=1:20
    pause(0.5);
    %increase the boundary wrap around like 1D CAs
    tilecell = cell([end 1:end 1], [end 1:end 1]);
 
    % count neighbors    
    nconv = conv2(double(tilecell==BURNING),[1 1 1; 1 0 1; 1 1 1],'same');
    neighbors = nconv(2:end-1,2:end-1);
    
    % empties may come to life
    newgrowth1 = (cell==EMPTY).*(rand(250,250)<p1);
    newgrowth2 = (cell==EMPTY).*(rand(250,250)<p2);
    bothgrowth = newgrowth1+newgrowth2;
    onlygrowth1= newgrowth1-(bothgrowth==2);
    onlygrowth2= newgrowth2-(bothgrowth==2);

    %flip corn to decide tree species in cells with two tree species
    doubletreeindex=find(bothgrowth==2);
    doubletreenum=numel(doubletreeindex);
    if doubletreenum >0
       randomtree=randsample([1 2],doubletreenum,true);    
       for j=1:doubletreenum
           cell(doubletreeindex(j))=randomtree(j);
       end       
    end
    
    %update cell with new growing trees
    cell=cell+onlygrowth1+(onlygrowth2.*2);
    
    %turn burning cell to empty cell
    cell=cell-((cell==BURNING).*3);    
       
    % trees with burning neighbors will burn
    toburn = ((cell==TREE1)+(cell==TREE2)).*(neighbors > 0);
    toburn1= (cell==TREE1).*toburn;
    toburn2= (cell==TREE2).*toburn;
    cell=cell+(toburn1*2)+toburn2; 
     
    % some trees get hit by lightning
    tolight = ((cell==TREE1)+(cell==TREE2)).*(rand(250,250)<f);
    tolight1= (cell==TREE1).*tolight;
    tolight2= (cell==TREE2).*tolight;
    cell=cell+(tolight1*2)+tolight2;   
   
    %stor the biomass every step
    biomass=[biomass,numel(find((cell==TREE1)+(cell==TREE2)))/62500];
    
    %set the colormap range    
    map=[1 1 1;0 0.5 0;0 0.8 0; 1 1 0];
    caxis([0 3]);    
    colormap(map);
    % view the cell
    imagesc(cell);     
    % plot
    drawnow;
end

%caculate the everage biomass
biomass_index=numel(biomass);
for k=1:biomass_index
    sum=sum+biomass(k);
end
everagebiomass=sum/biomass_index;
end

function everagebiomass=tree_firefighter(p1,p2,Num)
f = 0.01; % lightning
N=Num;
EMPTY   = 0;
TREE1   = 1;
TREE2   = 2;
BURNING = 3;
EXTINGUISHED =4;
cell = zeros(250,250); %initiate the lattice
biomass=[];
sum=0;
 
for i=1:20
    pause(0.5);
    %increase the boundary wrap around like 1D CAs
    tilecell = cell([end 1:end 1], [end 1:end 1]);
 
    % count neighbors    
    nconv = conv2(double(tilecell==BURNING),[1 1 1; 1 0 1; 1 1 1],'same');
    neighbors = nconv(2:end-1,2:end-1);
    
    %turn burning cell to empty cell
    cell=cell-((cell==BURNING).*3);   
    %turn cell with trees which were extinguished to refresh trees
    cell=cell-(((cell==EXTINGUISHED).*(cell==TREE1))*3);
    cell=cell-(((cell==EXTINGUISHED).*(cell==TREE2))*2);
    
    % empties may come to life
    newgrowth1 = (cell==EMPTY).*(rand(250,250)<p1);
    newgrowth2 = (cell==EMPTY).*(rand(250,250)<p2);
    bothgrowth = newgrowth1+newgrowth2;
    onlygrowth1= newgrowth1-(bothgrowth==2);
    onlygrowth2= newgrowth2-(bothgrowth==2);

    %flip corn to decide tree species in cells with two tree species
    doubletreeindex=find(bothgrowth==2);
    doubletreenum=numel(doubletreeindex);
    if doubletreenum >0
       randomtree=randsample([1 2],doubletreenum,true);    
       for j=1:doubletreenum
           cell(doubletreeindex(j))=randomtree(j);
       end       
    end
    
    %update cell with new growing trees
    cell=cell+onlygrowth1+(onlygrowth2.*2);    
       
    % trees with burning neighbors will burn
    toburn = ((cell==TREE1)+(cell==TREE2)).*(neighbors > 0);
    toburn1= (cell==TREE1).*toburn;
    toburn2= (cell==TREE2).*toburn;
    cell=cell+(toburn1*2)+toburn2; 
     
    % some trees get hit by lightning
    tolight = ((cell==TREE1)+(cell==TREE2)).*(rand(250,250)<f);
    tolight1= (cell==TREE1).*tolight;
    tolight2= (cell==TREE2).*tolight;
    cell=cell+(tolight1*2)+tolight2; 
    
    %implement with fire fighters
    %find out the burning cell index
    fire_cell_index = find(cell==BURNING);
    %count the number of burning cell
    firecellnum=numel(fire_cell_index); 
    %if the number of burning cell is less the the settled number of fire
    %fighters, swap N and firecellnum
    if firecellnum < N
       N = firecellnum;     
    sprintf('N is %d\n',N)
    end
    %randomly choose N number of burning cells, variable
    %fire_cell_extinguished_index stores the index of burning cell chose by
    %fire fighters
    fire_cell_extinguished_index = randsample(fire_cell_index,N);
    index=numel(fire_cell_extinguished_index);
    %change the burning cell to extinguished cell (trees)
    for j=1:index
    cell(fire_cell_extinguished_index(j))=4;
    end        
    % restore the number of N
    N=Num;    
   
    %stor the biomass every step
    biomass=[biomass,numel(find((cell==TREE1)+(cell==TREE2)))/62500];
    
    %set the colormap range    
    map=[1 1 1;0 0.5 0;0 0.8 0;1 1 0;0 0 1];
    caxis([0 4]);    
    colormap(map);
    % view the cell
    imagesc(cell);     
    % plot
    drawnow;
end

%caculate the everage biomass
biomass_index=numel(biomass);
for k=1:biomass_index
    sum=sum+biomass(k);
end
everagebiomass=sum/biomass_index;
end

