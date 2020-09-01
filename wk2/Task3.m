
clear;clc;close all;
tau = 0.01;
syms x y
f =(y-x^2)^2+(1-x)^2;
Grad = gradient(f, [x,y]);
Hess = hessian(f, [x,y]);
Hess_inv = inv(Hess);

[x,y] = meshgrid(-5:.1:5);
f = ObjFunction(x,y);
figure(1);s = surf(x,y,f,'FaceAlpha',0.5); grid on; hold on;
xlabel('x');ylabel('y');
point = [-1; -1]; T = 0;
z1 = ObjFunction(point(1),point(2));
T=T+1; disp([T point(1) point(2)]); plot3(point(1),point(2),z1, 'r*');
z2 = 10;%initial value to satisfy the loop condition
coordinate = point;
while abs(z2-z1) > 0.005
    z1 = ObjFunction(point(1),point(2));
    syms x y
    Grad1 = double(subs(Grad, [x,y], [point(1),point(2)]));
    Hess1 = double(subs(Hess, [x,y], [point(1),point(2)]));
    Hess_inv1 = inv(Hess1);
     
    point = (point) - Hess_inv1*(Grad1);%gradient method, newton method
    z2 = ObjFunction(point(1),point(2));
    coordinate = [coordinate, point];
    T=T+1;disp([T double(point(1)) double(point(2))]); plot3(point(1),point(2),z2, 'r*');
end

figure(2);
iterationNum = 1:1:7;
plot(iterationNum, coordinate(1,:),'b');hold on;grid on;
plot(iterationNum, coordinate(2,:),'r');

function [f]=ObjFunction(x, y)
f=(y-x.^2).^2+(1-x).^2;
end

