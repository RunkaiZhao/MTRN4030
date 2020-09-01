clear;clc;close all;
tau = 0.01;
syms x y
f =(x-1)^2+(y-2)^2;
Grad = gradient(f, [x,y]);
Hess = hessian(f, [x,y]);
Hess_inv = inv(Hess);

[x,y] = meshgrid(-5:.1:5,-5:.1:5);
f = Objfunction(x,y);
figure(1);s = surf(x,y,f,'FaceAlpha',0.5); grid on; hold on;
xlabel('x');ylabel('y');
point = [-3, -3]; T = 0;
z1 = Objfunction(point(1),point(2));
T=T+1; disp([T point]); plot3(point(1),point(2),z1, 'r*');
z2 = 10;%initial value to satisfy the loop condition
coordinate = point';
while abs(z2-z1) > 0.005
    z1 = Objfunction(point(1),point(2));
    syms x y
    Grad1 = double(subs(Grad, [x,y], [point(1),point(2)]));
    Hess1 = double(subs(Hess, [x,y], [point(1),point(2)]));
    Hess_inv1 = inv(Hess1);
     
    point = (point) - (Grad1')*Hess_inv1;%gradient method, newton method
    z2 = Objfunction(point(1),point(2));
    coordinate = [coordinate, point'];
    T=T+1;disp([T double(point(1)) double(point(2))]); plot3(point(1),point(2),z2, 'r*');
end

figure(2);
iterationNum = 1:1:3;
plot(iterationNum, coordinate(1,:),'b');hold on;grid on;
plot(iterationNum, coordinate(2,:),'r');

function [f]=Objfunction(x, y)
f=(x-1).^2+(y-2).^2;
end
