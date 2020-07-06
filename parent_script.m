%% Parent Script
% * Filename: parent_script.m
% * Authors: Matt Reimer
% * Created: 02.04.2020
% * Modified: 07.06.2020
% * Purpose: Solve for Nash equilibrium lobbying efforts for the six
% treatments in Deck et al. (2020).
%
%% Description
% This script solves for the Nash equilibrium lobbying efforts using a 
% Constant Relative Risk Aversion (CRRA) utility function:
% 
% $$u(c) = \frac{1}{1 - \theta} c^{1-\theta}$$ for $$ \theta > 0, \theta
% \neq 1$$ and $$u(c) = ln(c)$$ for $$ \theta
% = 1.$$
% 
%% Preliminaries
 clc, clear
 close all
 directory = 'Documents/GitHub/Contests-Uncertain-Resources';
 cd(userpath)
 cd(directory)
 addpath(genpath(pwd)) 
  
%% Common Parameters
 % CRRA parameter
  par.theta = [0:0.05:0.95,1.05:0.05:2];
 % Endowment
  par.E = 60; 
 % Resource upper bound (M)
  par.M = 240;
 % Solver options
  options = optimoptions('fsolve','Display','off',...
        'FunctionTolerance',1e-12,'OptimalityTolerance',1e-12,...
        'MaxFunctionEvaluations',1e3);
 % Storage
  y = zeros(numel(par.theta),3,6);
  
%% Treatment 1: Fixed Prize
 % Target
  par.T = 120; 
 % Case
  CASE = 'one';
 % Initial guess for lobbying effort
  L0 = 30*ones(1,3);
 % Nash Equilbrium
  y(:,:,1) = nash(L0,par,CASE,[],options);
 
%% Treatment 2: Full Uncertain Prize
 % Target
  par.Tbar = par.M;
 % Case
  CASE = 'two';
 % Initial guess for lobbying effort
  L0 = 30*ones(1,3);
 % Nash Equilbrium
  y(:,:,2) = nash(L0,par,CASE,[],options);

%% Treatment 3: Partial Uncertain Prize
 % Target
  par.Tbar = 120;
 % Case
  CASE = 'two';
 % Initial guess for lobbying effort
  L0 = 30*ones(1,3);
 % Nash Equilbrium
  y(:,:,3) = nash(L0,par,CASE,[],options);
 
%% Treatment 4: Asymmetric Full Uncertain Prize
 % Target
  par.T = 240;
 % Case
  CASE = 'three';
 % Initial guess for lobbying effort
  L0 = [20 20 0];
 % Nash Equilbrium
  y(:,:,4) = nash(L0,par,CASE,[],options);
 
 %% Treatment 5: Asymmetric Partial Uncertain Prize (No Residual Claimant)
 % Target
  par.T = 120;
 % Case
  CASE = 'three';
 % Initial guess for lobbying effort
  L0 = [20 20 20];
 % Nash Equilbrium
  y(:,:,5) = nash(L0,par,CASE,[],options);
 
 %% Treatment 6: Asymmetric Partial Uncertain Prize (With Residual Claimant)
 % Target
  par.T = 120;
 % Case
  CASE = 'three';
 % Initial guess for lobbying effort
  L0 = [20 20 20];
 % Nash Equilbrium
  y(:,:,6) = nash(L0,par,CASE,'yes',options);
  
%% Figures
 % Plot 1: NE by treatment, for each player
 h1 = figure1(y,par.theta);
 
 % Plot 2: NE by player, for each treatment
 h2 = figure2(y,par.theta);
 
 % Plot 2 Alternative: NE by player, for each treatment
 h2_alt = figure2_alt(y,par.theta);
       
    
    
