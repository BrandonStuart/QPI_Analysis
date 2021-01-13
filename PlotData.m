%% Define variables

points = header.points;
x_points = header.grid_dim(1);
y_points = header.grid_dim(2);
x_dim = header.grid_settings(3);
y_dim = header.grid_settings(4);
x = linspace(0,x_dim,x_points);
y = linspace(0,y_dim,y_points);
voltage = linspace(-800,800,201);
midV = zeros(points-1,1);
for k = 1:(points-1)
    midV(k) = (voltage(k) + voltage(k+1))/2;
end


%% Define colour map plots
m = 1000; % 1000 evenly spaced colour points
cm_viridis = viridis(m); % Default matlibplot colour map
cm_inferno = inferno(m);
cm_magma = magma(m);

%% Plot Data (UBC colours: [0 10/256 62/256])
% Uncomment for loop to plot all voltages withing V_low to V_high,
% otherwise leave commented and only plot at index

index = 93;

% V_low = -60;
% V_high = 800;
% [c, index] = min(abs(V_low - midV(:)));
% [c, index_end] = min(abs(V_high - midV(:)));

% ---- Uncomment start here for multiplot ---- % 

% for index = index_start:index_end

    clf
   
%     clims = [min(min(QPI_symm_crop(:,:,index))) 0.05*max(max(QPI_symm_crop(:,:,index)))];
%     figure(1)
%     imagesc(QPI_symm_crop(:,:,index),clims)
%     pbaspect([1 1 1])
%     [a,b] = ginput(2);

% ---- Uncomment end here for multiplot ---- %

    % Set string for saving and plotting at the specified voltage
    volstr = num2str(midV(index));

    % Set plotting limits, depends on measurement settings
    clims = [min(min(QPI_symm_crop_45(:,:,index))) 0.05*max(max(QPI_symm_crop_45(:,:,index)))];

    % Initialise figure
    fig1 = figure(1);
    set(fig1,'Position',[150 50 800 800])
    set(gca,'position',[0 0 1 1])
    % Plot data
    imagesc(QPI_symm_crop_45(:,:,index), clims)
    colormap(flipud(cm_magma))
    hold on 
    % Create scalebar
    plot3([3.5e-8 4.5e-8], [47.5e-9 47.5e-9], [1, 1], 'LineWidth', 7, 'Color', [1 1 1])
    text(4e-8, 47e-9, 1 , '10 nm', ...
                                        'HorizontalAlignment','center', ...
                                        'VerticalAlignment','bottom','FontSize',24, ...
                                        'Color','w','FontName','Rawline')                            
    text(x_dim/2, y_dim/25, 1, strcat(volstr, ' mV'), ...
                                        'HorizontalAlignment','center', ...
                                        'VerticalAlignment','middle','FontSize',48, ...
                                        'Color',[1 1 1],'FontName','Rawline')                                
    pbaspect([1 1 1])
    % Plot colourbar
    colorbar('Position',[2/800 2/800 0.1 0.4],'Ticks',[],'Color',[0 10/256 62/256],'LineWidth',4) % UBC color: [0 10/256 62/256]
    axis off
    
    % Ensures no white border or oversize image
    set(gcf, 'InvertHardCopy', 'off');
    
    % Save file (Specify location of course)
    basefile = strcat(volstr,'.png');
    saveas(figure(1),fullfile('C:\Users\brand\Documents\Data\ZrSiTe\2018-07-09\QPI_45',basefile));
    
% end % Uncomment for multiplot to close for loop