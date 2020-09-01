%% Bracketing
clc; close all;
tau = 0.01;
x=linspace(0,1,101);
f=Objfunction(x);
figure(1); plot(x,f); grid on; hold on;
xlabel('x'); ylabel('f');
rho=[0.01 0.02 0.03]; i=rho*tau; T=0;
g=Objfunction(i);
plot(i(end),g(end),'*'); disp(i);
while (1)
   if g(1)<g(2) && g(2)>g(3)
       i = [i(1) i(3)];break;
   elseif g(1)<g(2) && g(2)<g(3)
       i(1:2)=i(2:3); g(1:2)=g(2:3);
       i(3)=i(3)*2; g(3)=Objfunction(i(3));
   end
   T=T+1; disp(T);
   plot(i(end),g(end),'*'); disp(i);
end

%% Fibonacci method
clear variable;
clear g

x = linspace(i(1),i(2),101);
f = Objfunction(x);
figure(2);plot(x,f);grid on;hold on;
xlabel('x');ylabel('y');

zL=0; zH=1; rng=zH-zL; T=0;
F(1)=0; F(2)=1;
while 1/F(end)>tau
  F(end+1)=F(end)+F(end-1);
end
F(1:2)=[]; disp(F); N=size(F,2)-1;
for k=1:N
  rho(k)=1-F(N-k+1)/F(N-k+2);
end
rho(end)=rho(end)-tau; disp(rho); disp(' ');
z(1)=zL+rho(T+1)*rng; [g(1)]=Objfunction(z(1));
z(2)=zH-rho(T+1)*rng; [g(2)]=Objfunction(z(2));
T=T+1; disp('Fibonacci method:');disp([T z]); plot(z,g,'*');

while T<N
  if g(1)>g(2)
    zH=z(2); rng=zH-zL; g(2)=g(1); z(2)=z(1);
    z(1)=zL+rho(T+1)*rng; [g(1)]=Objfunction(z(1));
  elseif g(2)>g(1)
    zL=z(1); rng=zH-zL; g(1)=g(2); z(1)=z(2);
    z(2)=zH-rho(T+1)*rng; [g(2)]=Objfunction(z(2));
  else
    break;
  end
  T=T+1; disp([T z]); plot(z,g,'*');
end
R(1)=Objfunction(z(1));
R(2)=Objfunction(z(2));
title(['Fibonacci method:','\lambda1=',num2str(z(1)),' f=',num2str(g(1))]);
disp(' ');

%% Bisection method
% x=linspace(i(1),i(2),101);
% f=Objfunction(x);
% figure(3); plot(x,f); grid on; hold on;
% xlabel('x'); ylabel('f');
% rho=0.5; zL=0; zH=1; T=0;
% z=(zL+zH)/2; g=Objfunction(z); df=dObjfunction(z);
% T=T+1;disp('Bisection method:'); disp([T z]); plot(z,g,'*');
% while abs(df) > tau
%     if df > 0
%         zL = z;
%     elseif df < 0
%         zH = z;
%     end
%     z=rho*(zL+zH);
%     g=Objfunction(z); 
%     df=dObjfunction(z);
%     T=T+1; disp([T z]); plot(z,g,'*');
% end
% disp(' '); disp([z g]);
% title(['Bisection method:','\lambda1=',num2str(z),' f=',num2str(g)]);
% 
 function [f] = Objfunction(x)
 f = 0.75./(1+x.^2)+0.65.*x.*atan(1./x)-0.65;
 end

function [df] = dObjfunction(x)
df = (13.*atan(1./x))/20 - (3.*x)./(2.*(x.^2 + 1)^2) - 13/(20.*x.*(1./x.^2 + 1));
end