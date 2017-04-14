% script to generate figure
load('biomass_p_0.001.mat');
figure;
hold on
yyaxis left;
plot(0.001:0.001:1,biomass_landscape);
ylabel('Biomass');
yyaxis right;
Tsel = 5000 * ones(1, 1000);
plot(0.001:0.001:1,Tsel,'r--');
ylim([4000 6000]);

title('Fitness Landscape of Growth Rate');
ylabel('Longevity');

set(gca,'FontSize',14,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',14,'fontWeight','bold');
hold off;


load('firefighter_biomass.mat');
figure;
hold on
plot(0:50:1000,biomass);
title('Effect of Fire Fighters on Biomass');
xlabel('Number of Fire Fighters');
ylabel('Biomass');
set(gca,'FontSize',14,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',14,'fontWeight','bold');
hold off;



load('biomass_100_firefighter.mat');
load('biomass_no_firefighter.mat');
load('biomass_50_firefighter.mat');
figure;
hold on;
plot(1:200,biomass_no_firefighter,'-');
plot(1:200,biomass_50_firefighter,'--');
plot(1:200,biomass_100_firefighter,'k:');
legend('no firefighter','50 firefighter','100 firefighter');
title('Effect of Fire Fighters on Biomass');
xlabel('Time Steps of CA');
ylabel('Biomass');
set(gca,'FontSize',14,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',14,'fontWeight','bold');
hold off;


figure;
tree_firefighter2(0.965,0.972,0,200);
figure;
tree_firefighter2(0.965,0.972,50,200);
figure;
tree_firefighter2(0.965,0.972,100,200);




