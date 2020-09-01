clc;close all;
i = 1;

while i < 50 || i == 50
    inv = i*100;
    
x1 = linspace(2, 14, inv);
x2 = linspace(0.2, 0.8, inv);
[x1, x2] = meshgrid(x1,x2);
f = 9.82.*x1.*x2+2.*x1;
% figure(1);surf(x1, x2, f, 'FaceAlpha',0.5); grid on; hold on;
% xlabel('x1');ylabel('x2');zlabel('f')
% contour(x1,x2,f);
g1 = (2500./(pi.*x1.*x2))-500;
g2 = (2500./(pi.*x1.*x2))-(((pi^2)*0.85*(10^6))*(x1.^2+x2.^2))/(8*(250^2));
filter_g1 = find(g1>0);
filter_g2 = find(g2>0);
x1(filter_g1) = NaN;
x1(filter_g2) = NaN;
x2(filter_g1) = NaN;
x2(filter_g2) = NaN;
f = 9.82.*x1.*x2+2.*x1;
% figure(2);surf(x1, x2, f, 'FaceAlpha','0.2'); grid on; hold on;
% xlabel('x1');ylabel('x2');zlabel('f')
% contour(x1,x2,f);
min_solution(i) = min(min(f));
% min_index = find(f==min_solution);
% [row, col] = ind2sub(size(f),min_index);
% x1_min = x1(row,col);
% x2_min = x2(row,col);
% plot3(x1_min,x2_min,min_solution,'*r');
% string = sprintf('%0.2f %0.2f %0.2f', x1_min, x2_min, min_solution);
% text( x1_min, x2_min, string);
% title(['x1=',num2str(x1_min),' x2=',num2str(x2_min), ' f=',num2str(min_solution)]);

i = i+1;
end

t = 1:1:50;
figure;plot(t,min_solution);


