%% FIGURE: Nash Equilibrium by Treatment, for each Player

function h = figure1(y,theta)

  h = figure('Name','Nash Equilibrium Lobbying Efforts By Player',...
      'Units','normalized','Position',[0.2727    0.2972    0.2652    0.4382]);
  

  % Subplot 1: Player A
  % Create axes 
    axes1 = axes('Parent',h,'Position',[0.075,0.6,0.37,0.35]);
    hold(axes1,'on');
    plot(theta',[y(:,1,1),y(:,1,2),y(:,1,3),y(:,1,4),y(:,1,5),y(:,1,6)],...
      'LineWidth',2); grid on;
    xlabel('CRRA (\theta)'); ylabel('Lobby Effort (L)');
    ylim([0 30])
    title('Player A');

  % Subplot 2: Player B
  % Create axes 
   axes2 = axes('Parent',h,'Position',[0.56,0.6,0.37,0.35]);  
   hold(axes2,'on');
    plot(theta',[y(:,2,1),y(:,2,2),y(:,2,3),y(:,2,4),y(:,2,5),y(:,2,6)],...
      'LineWidth',2); grid on;
    xlabel('CRRA (\theta)'); ylabel('Lobby Effort (L)');
    ylim([0 30])
    title('Player B');    
    
  % Subplot 3: Player C
  % Create axes 
   axes3 = axes('Parent',h,'Position',[0.075,0.136,0.37,0.35]);
   hold(axes3,'on');
    plot(theta',[y(:,3,1),y(:,3,2),y(:,3,3),y(:,3,4),y(:,3,5),y(:,3,6)],...
      'LineWidth',2); grid on;
    xlabel('CRRA (\theta)'); ylabel('Lobby Effort (L)');
    ylim([0 30])
    title('Player C');
    
  % Subplot 4: Total
  % Create axes 
   axes4 = axes('Parent',h,'Position',[0.56,0.136,0.37,0.35]);
   hold(axes4,'on');
   sub = plot(theta',[sum(y(:,:,1),2),sum(y(:,:,2),2),sum(y(:,:,3),2),...
       sum(y(:,:,4),2),sum(y(:,:,5),2),sum(y(:,:,6),2)],...
      'LineWidth',2); grid on;
    xlabel('CRRA (\theta)'); ylabel('Lobby Effort (L)');
    ylim([0 90])
    title('All Players (Total)');
    
 % Create Legend
  axes5 = axes('Parent',h,'Position',[0 0 1 0.2]);    
  axis off   
  legend1 = legend(axes5,'show',sub,{'Treatment 1','Treatment 2','Treatment 3','Treatment 4',...
    'Treatment 5','Treatment 6'},'FontSize',11);
  set(legend1,'Orientation','horizontal','Position',[0.3,0.03,0.4,0.04]); 
  
end