% Generate colormaps 

clear; close all;

%UPDATE THESE -----------------------------------------------------

% path = '/Users/czimnicki/Desktop/creating_colormaps_code/';
% path = '/Users/czimnicki/Dropbox/holey_maps/magma_piloting/code/creating_colormaps_code/';

path = '/Users/czimnicki/Dropbox/OpacitySpatial/exp_2/colormaps_creating_code/';

out_folder = 'shifted_white_grids/';

%Load in the dataset
filename = 'hmaps-new-curve-more-black.csv';
T = readtable(filename);

rows = [1:6];
T = T(rows,:) ; 



%Format dataset into a matrix (8x8 grids x the number of datasets)
numD = size(T,1); %number of underlying dataset

CmapData = table2array(T(1:numD, 2:size(T,2)));
CmapMat = zeros(8,8,numD); %8, 8

for i = 1:numD
    CmapMat(:,:,i) = reshape(CmapData(i,:),8,8); %select the 64 data points and reshape to 8x
end

%Make the left/right flip version
CFlip = fliplr(CmapMat);

%combine the original version and the left/right flip version into a single
%matrix
CAll = cat(3,CmapMat,CFlip);

brewerBlue = flipud(brewermap([],"Blues")); %load in Blue
brewerRed = flipud(brewermap([],"Reds")); % load in Red

% set the color scales and their corresponding names (for naming images)
color_scale={gray, magma_bw_20wh, hot, mako_bw_wh, autumn, winter, viridis, plasma, brewerBlue, brewerRed};
color_scale_str = {'gray', 'magma', 'hot', 'mako', 'autumn', 'winter', 'viridis', 'plasma', 'brewerBlue', 'brewerRed'};

%background color names
bg_clr_str = {'white', 'black'};
%background color coordinates
black = [0 0 0];
white = [1 1 1];

% create map numbers
map_num = T(:,1);
map_num_table = [table2cell(map_num)]';
map_num_str = string(map_num_table);
map_num_str2 = repmat(map_num_str,1,2);

%indicate left/right part of file name
L = repmat('L',numD,1);
R = repmat('R',numD,1);
LR = [L;R];


%% Create colormaps

bg_clr = {white, black};
object_color = {black, white};

labels = {'Left', 'Right'};

%Create the maps 
for colorscale = 1:length(color_scale)
    colormap(flipud(color_scale{colorscale}));
        
    
        for bg = 1:2
            for mapN = 1:numD*2 %number of underlying datasets x 2 for l/r flip  
               
    %           data = CAll(:,:,mapN);   
                fig = figure(1);
                imagesc(CAll(:,:,mapN)); %draw plot
                daspect([1,1,1]);   %make image square [1,1,1]
                    
                %set bg color
                set(fig, 'color', bg_clr{bg}, 'InvertHardcopy', 'off');
                  
                %change axes
                % axis ([x-left, x-right, y-upper, y-lower])
                axis([0.2,9.3,-0.3,8.9]); %<- regular grid 8x8
                %axis([0,215,-25,215]); % <- 200x200 grid
                %axis([5,233,-7.4,225]);
                axis off;
                                           
                %add text
                for x = [1 2]
                    text(4.05 *  x - 2.1, 9.2, labels{x}, 'color', object_color{bg}, 'fontsize', 14) % <- regular grid 8x8
                   % text(40, 220, 'Left', 'color', object_color{bg},
                   % 'fontsize', 14) % <--200x200
                   % text(135, 220, 'Right', 'color', object_color{bg}, 'fontsize', 14)
                end
                      
                %add lines under each side
                % regular grid 8x8:
                %line([0.8 4.2],[8.8 8.8], 'color', object_color{bg});
                %line([4.8 8.2],[8.8 8.8], 'color', object_color{bg});
                % 200x200 grid:
                line([10 90],[210 210], 'color', object_color{bg});
                line([110 190],[210 210], 'color', object_color{bg});
                
                %draw border
                rectangle('Position',[0.5,0.5,8,8], 'edgecolor', object_color{bg}, 'linewidth', 0.5); %<- regular grid 8x8
                %rectangle('Position',[.5,.5,200,200], 'edgecolor', object_color{bg}, 'linewidth', 1); % <- 200x200 grid
    
                %save picture
                set(gcf,'PaperUnits','inches','PaperPosition',[0 0 4.18 4.18]); %was 7/3 7/3
                print(fig, [path out_folder 'ltshift_grid_' color_scale_str{colorscale} '_' bg_clr_str{bg} '_' LR(mapN) '_' map_num_str2{mapN}], '-dpng'); 
                %clf(fig,'reset')     
            end
      end
end
close all


