clear;clc;close all;
tau = 0.01;

[x, y] = meshgrid(-5:0.1:5,-5:0.1:5);
%f = 10.*((x-2).^2) + x.*y + 10.*((y-1).^2);
f = Objfunction(x,y);
figure; surf(x, y, f, 'FaceAlpha','0.2'); grid on; hold on;
xlabel('x');ylabel('y');
contour(x,y,f);

ratio = (3-sqrt(5))/2; xL=-5; xH=5; yL = -5; yH=5; rangeX=xH-xL; rangeY = yH-yL; N = 0;
a(1) = xL+ratio*rangeX;a(2) = xL+ratio*rangeX; a(3) = xH-ratio*rangeX; a(4) = xH-ratio*rangeX;
b(1) = yL+ratio*rangeX;b(3) = yL+ratio*rangeX; b(2) = yH-ratio*rangeX; b(4) = yH-ratio*rangeX;
c(1) = Objfunction(a(1),b(1));
c(2) = Objfunction(a(1),b(2));
c(3) = Objfunction(a(3),b(1));
c(4) = Objfunction(a(3),b(2));
N = N+1;disp([N c]);
plot3(a,b,c,'*r');

while (rangeX > tau) && (rangeY > tau)
    if c(1) == min(c) %left lower 
        xH = a(3); rangeX = xH-xL; a(3) = a(1); a(1) = xL+ratio*rangeX;
        yH = b(2); rangeY = yH-yL; b(2) = b(1); b(1) = yL+ratio*rangeY;
    elseif c(2) == min(c) %left upper
        xH = a(3); rangeX = xH-xL; a(3) = a(1); a(1) = xL+ratio*rangeX;
        yL = b(1); rangeY = yH-yL; b(1) = b(2); b(2) = yH-ratio*rangeY;
    elseif c(3) == min(c) % right lower
        xL = a(1); rangeX = xH-xL; a(1) = a(3); a(3) = xH - ratio*rangeX;
        yH = b(2); rangeY = yH-yL; b(2) = b(1); b(1) = yL+ratio*rangeY;
    elseif c(4) == min(c) % right upper
        xL = a(1); rangeX = xH-xL; a(1) = a(3); a(3) = xH - ratio*rangeX;
        yL = b(1); rangeY = yH-yL; b(1) = b(2); b(2) = yH-ratio*rangeY;
    else 
        break
    end
    a(2) = a(1);a(4) = a(3);
    b(3) = b(1);b(4) = b(2);
    c(1) = Objfunction(a(1),b(1));
    c(2) = Objfunction(a(1),b(2));
    c(3) = Objfunction(a(3),b(1));
    c(4) = Objfunction(a(3),b(2));
    N = N+1; 
    disp([N c]);
    plot3(a,b,c,'*r');
end

% verification of local minimum
syms x y
f = 10*((x-2)^2) + x*y + 10*((y-1)^2);
df_x = diff(f,x) == 0;
df_y = diff(f,y) == 0;
equ = [df_x df_y];
sp = solve(equ, [x y]);
v = subs(f, [x y], [sp.x sp.y]);
v = double(v);
%second derivative test
Hessian_f = hessian(f, [x,y]);
D = det(Hessian_f);
f_xx = Hessian_f(1);
%the determinant of hessian matrix and f_xx are positive, so (sp.x,sp.y) is
%a local minimum of f.

function [f] = Objfunction(x,y)
f = 10.*((x-2).^2) + x.*y + 10.*((y-1).^2);
end