%% FIGURE: Nash Equilibrium by Player, for each Treatment

function g = figure2(y,theta)

g = figure('Name','Nash Equilibrium Lobbying Efforts by Treatment',...
      'Units','normalized','Position',[0.2633    0.2097    0.2602    0.6118]);
  
  % Subplot 1: Treatment 1
  % Create axes 
    axes1 = axes('Parent',g,'Position',[0.075,0.73,0.37,0.25]);
    hold(axes1,'on');
    sub = plot(theta',[y(:,1,1)+0.2,y(:,2,1),y(:,3,1)-0.2],'LineWidth',2); grid on;
    xlabel('CRRA (\theta)'); ylabel('Lobby Effort (L)');
    ylim([0 30])
    title('Treatment 1');    
    
  % Subplot 2: Treatment 2
  % Create axes 
    axes2 = axes('Parent',g,'Position',[0.56,0.73,0.37,0.25]);
    hold(axes2,'on');
    plot(theta',[y(:,1,2)+0.2,y(:,2,2),y(:,3,2)-0.2],'LineWidth',2); grid on;
    xlabel('CRRA (\theta)'); ylabel('Lobby Effort (L)');
    ylim([0 30])
    title('Treatment 2'); 

  % Subplot 3: Treatment 3
  % Create axes 
    axes3 = axes('Parent',g,'Position',[0.075,0.41,0.37,0.25]);
    hold(axes3,'on');
    plot(theta',[y(:,1,3)+0.2,y(:,2,3),y(:,3,3)-0.2],'LineWidth',2); grid on;
    xlabel('CRRA (\theta)'); ylabel('Lobby Effort (L)');
    ylim([0 30])
    title('Treatment 3'); 
    
  % Subplot 4: Treatment 4
  % Create axes 
    axes4 = axes('Parent',g,'Position',[0.56,0.41,0.37,0.25]);
    hold(axes4,'on');
    plot(theta',[y(:,1,4),y(:,2,4),y(:,3,4)],'LineWidth',2); grid on;
    xlabel('CRRA (\theta)'); ylabel('Lobby Effort (L)');
    ylim([0 30])
    title('Treatment 4'); 
    
  % Subplot 5: Treatment 5
  % Create axes 
    axes5 = axes('Parent',g,'Position',[0.075,0.09,0.37,0.25]);
    hold(axes5,'on');
    plot(theta',[y(:,1,5),y(:,2,5),y(:,3,5)],'LineWidth',2); grid on;
    xlabel('CRRA (\theta)'); ylabel('Lobby Effort (L)');
    ylim([0 30])
    title('Treatment 5'); 
    
  % Subplot 6: Treatment 6
  % Create axes 
    axes6 = axes('Parent',g,'Position',[0.56,0.09,0.37,0.25]);
    hold(axes6,'on');
    plot(theta',[y(:,1,6),y(:,2,6),y(:,3,6)],'LineWidth',2); grid on;
    xlabel('CRRA (\theta)'); ylabel('Lobby Effort (L)');
    ylim([0 30])
    title('Treatment 6'); 
    
  % Create Legend
  axes7 = axes('Parent',g,'Position',[0 0 1 0.2]);    
  axis off   
  legend1 = legend(axes7,'show',sub,{'Player A','Player B','Player C'},...
    'FontSize',12);
  set(legend1,'Orientation','horizontal','Position',[0.3,0.015,0.4,0.03]);
  
end