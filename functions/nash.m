%% Nash Equilibrium
% * Filename: nash.m
% * Authors: Matt Reimer
% * Created: 02.04.2020
% * Modified: 07.06.2020
% * Purpose: Solve for Nash equilibrium lobbying efforts for the six
% treatments in Deck et al. (2020).


function ne = nash(L0,par,CASE,RC,options)

 % Default residual claimant
  if nargin < 4, RC = []; end

 % Storage
  ne = zeros(numel(par.theta),3);
  
 % Solve for NE using different thetas
  for i = 1:numel(par.theta)
    ne(i,:) = fsolve(@(L) foc(L,par.theta(i),par,CASE,RC),L0,options);
  end


%% First Order Conditions
function y = foc(L0,theta,par,CASE,RC)

  % Common Parameters
  E = par.E; 
  
  % Share Function
  s = @(L) L(1)./(L(1) + L(2) + L(3));
  
  % First derivative of share function
  s_1 = @(L) (L(2) + L(3))./((L(1) + L(2) + L(3)).^2);
  
  % Cross derivative of share function
  s_c = @(L) -(L(1))./((L(1) + L(2) + L(3)).^2);
  
  % Reward function (with H = sT)
  x = @(L,T) E + s(L).*T - L(1);
  
  % First derivative of the reward function (with H = sT)
  x_1 = @(L,T) s_1(L).*T - 1;
  
  % Utility function
  u = @(x) (1/(1-theta)).*(x.^(1-theta));
  
  % First derivative of utility function
  u_1 = @(x) x.^(-theta);
  
  % Switch Cases
  switch CASE
    
    % Case 1: Symmetric Tullock with Known Resource
    case 'one'
      T = par.T;
      
      % General FOC
      f = @(L) u_1(x(L,T)).*x_1(L,T);
      
      % Player-Specific FOC
      y(1) = f([L0(1),L0(2),L0(3)]);
      y(2) = f([L0(2),L0(1),L0(3)]);
      y(3) = f([L0(3),L0(2),L0(1)]);
     
    % Case 2: Symmetric Tullock with Unknown Resource   
    case 'two'
      M = par.M;
      Tbar = par.Tbar;
      
      % General FOC
      f = @(L,T) (1/M)*u_1(x(L,T)).*x_1(L,T);
      
      % Nodes (T) and weights (w) for Gauss-Legendre quadrature 
      [T,w] = qnwlege(100,0,Tbar);
      
      % Player-Specific FOC
      y(1) = w'*f([L0(1),L0(2),L0(3)],T) + ...
        (M-Tbar)* f([L0(1),L0(2),L0(3)],Tbar);
      y(2) = w'*f([L0(2),L0(1),L0(3)],T) + ...
        (M-Tbar)* f([L0(2),L0(1),L0(3)],Tbar);
      
      if isempty(RC)
        y(3) = w'*f([L0(3),L0(2),L0(1)],T) + ...
          (M-Tbar)* f([L0(3),L0(2),L0(1)],Tbar);
      else
        [r,w2] = qnwlege(100,Tbar,M);
        y(3) = w'*f([L0(3),L0(2),L0(1)],T) + ...
          w2'*u_1(x([L0(3),L0(2),L0(1)],Tbar)+r-Tbar)*...
          x_1([L0(3),L0(2),L0(1)],Tbar)*(1/M);
      end
        
    % Case 3: Asymmetric Tullock with Unknown Resource  
    case 'three'
      M = par.M;
      T = par.T;
      
      % Player A
        % Player A lobbying effort vector
        la = [L0(1),L0(2),L0(3)]; 
        % Nodes and weights for quadrature
        [r,w] = qnwlege(100,0,s(la)*T);
        % FOC
        f(1) = - w'*u_1(E+r-la(1))...
            + (M-s(la)*T)*u_1(x(la,T))*x_1(la,T);
          
      % Player B
        % Player B lobbying effort vector
        lb = [L0(2),L0(1),L0(3)]; 
        % Nodes and weights for quadrature
        [r,w] = qnwlege(100,s(la)*T,(s(la)+s(lb))*T);
        % FOC
        f(2) = -s(la)*T*u_1(E-lb(1)) ...
          - w'*u_1(E+r-s(la)*T-lb(1))*(s_c(la)*T + 1)...
          + (M-s(la)*T-s(lb)*T)*u_1(x(lb,T))*x_1(lb,T);
        
      % Player C
        % Player C lobbying effort vector
        lc = [L0(3),L0(2),L0(1)];
        
        if isempty(RC)
          % Nodes and weights for quadrature
          [r,w] = qnwlege(100,(s(la)+s(lb))*T,T);
          % FOC
          f(3) = -(s(la)+s(lb))*T*u_1(E-lc(1))...
            - w'*u_1(E+r-(s(la)+s(lb))*T-lc(1))*((s_c(la)+s_c(lb))*T + 1)...
            + (M-T)*u_1(x(lc,T))*x_1(lc,T);
          
        else
          % Nodes and weights for quadrature
          [r1,w1] = qnwlege(100,(s(la)+s(lb))*T,T);
          [r2,w2] = qnwlege(100,T,M);
          % FOC
          f(3) = -(s(la)+s(lb))*T*u_1(E-lc(1))...
            - w1'*u_1(E+r1-(s(la)+s(lb))*T-lc(1))*((s_c(la)+s_c(lb))*T + 1)...
            + w2'*u_1(x(lc,T)+r2-T)*x_1(lc,T);
        end
        
      % Complimentarity problem
      y(1) = fischers(f(1),L0(1),0);
      y(2) = fischers(f(2),L0(2),0);
      y(3) = fischers(f(3),L0(3),0);
      
  end
  
end

end