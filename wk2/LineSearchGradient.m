function []=LineSearchGradient() 

% program management
clc; dbstop if error;

% objective function
% syms x;
% f=1-sin(2*x)
% df=diff(f,x)
% d2f=diff(df,x)
% x_=solve(df==0)
% eval(x_)
% clear f x;

% tolerance of optimum
global tau;
tau=0.001;

%GoldenSection;
FibonacciMethod;
% BisectionMethod;
% NewtonMethod;
% SecantMethod;
%  Bracketing;
% GradientDescent;
% SteepestDescent;

% Golden section
function []=GoldenSection()
global tau;
clc; close all;
% setup, show opt problem
x=linspace(0,1,101);
f=ObjFunction(x);
figure; plot(x,f); grid on; hold on;
xlabel('x'); ylabel('f');
tL=dbstack; tL=tL.name; title(tL); 
% setup parameter
rho=(3-sqrt(5))/2; zL=0; zH=1; rng=zH-zL; T=0;
z(1)=zL+rho*rng; [g(1)]=ObjFunction(z(1));
z(2)=zH-rho*rng; [g(2)]=ObjFunction(z(2));
T=T+1; disp([T z]); plot(z,g,'*');
% main loop
while rng>tau,
  if g(1)<g(2),
    zH=z(2); rng=zH-zL; g(2)=g(1); z(2)=z(1);
    z(1)=zL+rho*rng; [g(1)]=ObjFunction(z(1));
  elseif g(2)<g(1),
    zL=z(1); rng=zH-zL; g(1)=g(2); z(1)=z(2);
    z(2)=zH-rho*rng; [g(2)]=ObjFunction(z(2));
  else
    break;
  end;
  T=T+1; disp([T z]); plot(z,g,'*');
end;
z=mean(z); g=mean(g); disp(' '); disp([z g]);

% Fibonacci method
function []=FibonacciMethod()
global tau;
clc; close all;
% setup, show opt problem
x=linspace(0,1,101);
f=ObjFunction(x);
figure; plot(x,f); grid on; hold on;
xlabel('x'); ylabel('f');
tL=dbstack; tL=tL.name; title(tL); 
% setup parameter
zL=0; zH=1; rng=zH-zL; T=0;
F(1)=0; F(2)=1;
while 1/F(end)>tau,
  F(end+1)=F(end)+F(end-1);
end; 
F(1:2)=[]; disp(F); N=size(F,2)-1;
for k=1:N,
  rho(k)=1-F(N-k+1)/F(N-k+2);
end; 
rho(end)=rho(end)-tau; disp(rho); disp(' ');
z(1)=zL+rho(T+1)*rng; [g(1)]=ObjFunction(z(1));
z(2)=zH-rho(T+1)*rng; [g(2)]=ObjFunction(z(2));
T=T+1; disp([T z]); plot(z,g,'*');
% main loop
while T<N,
  if g(1)<g(2),
    zH=z(2); rng=zH-zL; g(2)=g(1); z(2)=z(1);
    z(1)=zL+rho(T+1)*rng; [g(1)]=ObjFunction(z(1));
  elseif g(2)<g(1),
    zL=z(1); rng=zH-zL; g(1)=g(2); z(1)=z(2);
    z(2)=zH-rho(T+1)*rng; [g(2)]=ObjFunction(z(2));
  else
    break;
  end;
  T=T+1; disp([T z]); plot(z,g,'*');
end;
z=mean(z); g=mean(g); disp(' '); disp([z g]);

% Bisection Method
function []=BisectionMethod()
global tau;
clc; close all;
% setup, show opt problem
x=linspace(0,1,101);
f=ObjFunction(x);
figure; plot(x,f); grid on; hold on;
xlabel('x'); ylabel('f');
tL=dbstack; tL=tL.name; title(tL); 
% setup parameter
rho=0.5; zL=0; zH=1; T=0;
z=(zL+zH)/2; g=ObjFunction(z); df=dObjFunction(z);
T=T+1; disp([T z]); plot(z,g,'*');
% main loop
while abs(df)>tau,
  if df>0,
    zH=z;
  elseif df<0,
    zL=z;
  end; 
  z=rho*(zL+zH);
  g=ObjFunction(z); 
  df=dObjFunction(z);
  T=T+1; disp([T z]); plot(z,g,'*');
end;
disp(' '); disp([z g]);

% Newton Method
function []=NewtonMethod()
global tau;
clc; close all;
% setup, show opt problem
x=linspace(0,1,101);
f=ObjFunction(x);
figure; plot(x,f); grid on; hold on;
xlabel('x'); ylabel('f');
tL=dbstack; tL=tL.name; title(tL); 
% setup parameter
zL=0; zH=1; rng=zH-zL; T=0; 
z=zL+rand*rng;
g=ObjFunction(z);
df=dObjFunction(z);
T=T+1; disp([T z]); plot(z,g,'*');
% main loop
while abs(df)>tau,
  df=dObjFunction(z);
  d2f=d2ObjFunction(z);
  z0=z; z=z0-df/(d2f+eps);%+eps
  while (z<zL || z>zH),
   z=zL+rand*rng; 
  end;
  g=ObjFunction(z);
  T=T+1; disp([T z]); plot(z,g,'*');
end;
disp(' '); disp([z g]);

% Secant Method
function []=SecantMethod()
global tau;
clc; close all;
% setup, show opt problem
x=linspace(0,1,101);
f=ObjFunction(x);
figure; plot(x,f); grid on; hold on;
xlabel('x'); ylabel('f');
tL=dbstack; tL=tL.name; title(tL); 
% setup parameter
zL=0; zH=1; rng=zH-zL; T=0; 
z(1)=zL+rand*rng; z(2)=z(1)+sign(randn)*eps;
g=ObjFunction(z); dg=dObjFunction(z); 
T=T+1; disp([T z(end)]); plot(z,g,'*');
% main loop
while min(abs(dg))>tau,
  y=z(2)-(z(2)-z(1))/(dg(2)-dg(1)+eps)*dg(2);
  z(1)=z(2); z(2)=y;
  while z(end)<zL || z(end)>zH,
    z(end)=zL+rand*rng;
  end;
  dg=dObjFunction(z);
  g=ObjFunction(z);
  T=T+1; disp([T z(end)]); plot(z(end),g(end),'*');
end;
disp(' '); disp([z(end) g(end)]);

% Bracketing
function []=Bracketing()
global tau;
clc; close all;
% setup, show opt problem
x=linspace(0,1,101);
f=ObjFunction(x);
figure; plot(x,f); grid on; hold on;
xlabel('x'); ylabel('f');
tL=dbstack; tL=tL.name; title(tL); 
% setup parameter
rho=[1 1.1 1.21]; z=rho*tau; T=0;
g=ObjFunction(z);
plot(z(end),g(end),'*'); disp(z);
% main loop
while (1),
  if g(1)>g(2) && g(2)<g(3),
    z=[z(1) z(3)]; break;
  elseif g(1)>g(2) && g(2)>g(3),
    z(1:2)=z(2:3); g(1:2)=g(2:3); 
    z(3)=z(3)*2; g(3)=ObjFunction(z(3));
  end;
  T=T+1; disp(T);
  plot(z(end),g(end),'*'); disp(z);
end;

% Gradient Descent
function []=GradientDescent()
global tau;
clc; close all;
[x,y]=meshgrid(-5:0.5:5,-5:0.5:5);
f=4*x.^2-4*x.*y+2*y.^2;
figure; surf(x,y,f,'facecolor','none'); hold on; grid on;
contour(x,y,f,50); view(-30,30);
xlabel('x'); ylabel('y'); zlabel('f'); 
tL=dbstack; tL=tL.name; title(tL); drawnow;
a=0.15; z=[2;3]; dz=2*tau; 
f=4*z(1)^2-4*z(1)*z(2)+2*z(2)^2;
g=[8*z(1)-4*z(2); -4*z(1)+4*z(2)];
T=1; disp([T z(:,end)' f g']);
plot3(z(1,end),z(2,end),f,'o','markerfacecolor','r');
% main loop
while dz>tau,
  z(:,end+1)=z(:,end)-a*g;
  dz=max(abs(z(:,end)-z(:,end-1)));
  f(end+1)=4*z(1,end)^2-4*z(1,end)*z(2,end)+2*z(2,end)^2;
  g=[8*z(1,end)-4*z(2,end); -4*z(1,end)+4*z(2,end)];
  T=T+1; disp([T z(:,end)' f(end) g']);
  plot3(z(1,end),z(2,end),f(end),'o','linewidth',2);
  if size(z,2)>1,
    plot3(z(1,end-1:end),z(2,end-1:end),f(end-1:end));
  end; drawnow;
end;

% Steepest Descent
function []=SteepestDescent()
global tau;
clc; close all;
[x,y]=meshgrid(-5:0.5:5,-5:0.5:5);
f=4*x.^2-4*x.*y+2*y.^2;
figure; surf(x,y,f,'facecolor','none'); hold on; grid on;
contour(x,y,f,50); view(-30,30);
xlabel('x'); ylabel('y'); zlabel('f'); 
tL=dbstack; tL=tL.name; title(tL); drawnow;
syms x y; T=0;
f=4*x^2-4*x*y+2*y^2;
gf=gradient(f,[x;y]);
z=[2;3]; dz=2*tau;
T=T+1; disp([T z(:,end)']);
h(T)=eval(subs(f,{x y},{z(1,end) z(2,end)}));
plot3(z(1,end),z(2,end),h,'o','markerfacecolor','r');
% main loop
while dz>tau,
  syms a;
  z_new=z(:,end)-a*gf;
  q=subs(f,{x y},{z_new(1) z_new(2)});
  dq=diff(q,a); a=solve(dq,a);
  a=subs(a,{x y},{z(1,end) z(2,end)});
  x_update=z(:,end)-a*gf;
  z(:,end+1)=eval(subs(x_update,{x y},{z(1,end) z(2,end)}));
  dz=max(abs(z(:,end)-z(:,end-1)));
  T=T+1; h(T)=eval(subs(f,{x y},{z(1,end) z(2,end)}));
  disp([T z(:,end)' h(end) eval(a)]);
  plot3(z(1,end),z(2,end),h(end),'o','linewidth',2);
  if size(z,2)>1,
    plot3(z(1,end-1:end),z(2,end-1:end),h(end-1:end));
  end; drawnow;
end;



function [f]=ObjFunction(x)
f=1-sin(2*x);

function [df]=dObjFunction(x)
df=-2*cos(2*x);

function [d2f]=d2ObjFunction(x)
d2f=4*sin(2*x);

