function biomass=firefighter(p1,p2)
    biomass=[];
        for i=0:50:1000
            averagebiomass=biomass_no_image(p1,p2,i);
            biomass=[biomass,averagebiomass];
        
        end
     plot(0:50:1000,biomass);

end