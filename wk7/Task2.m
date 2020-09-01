%% Question 2.a
clear;
syms x y lamda
[x, y] = meshgrid(-3:0.5:3,-3:0.5:3);
f = x.*y.*(2+x);
g = x.^2+y.^2-2;
figure(1);
surf(x,y,f,'FaceAlpha',0.3);grid on;hold on;
fp=fimplicit(@(x,y)x.^2+y.^2-2, 'Color', 'r');hold on;
syms x y lamda
f = x.*y.*(2+x);
g = x.^2+y.^2-2;
L = f+lamda*g;
vector_cond = jacobian(L, [x y lamda]) == 0;
soln = solve(vector_cond, [x y lamda]);

x = real(double(soln.x));
y = real(double(soln.y));
lamda = real(double(soln.lamda));

f = x.*y.*(2+x);

indexMax = find(f == max(f));
indexMin = find(f == min(f));
plot3(x(indexMax),y(indexMax),max(f), 'b*');hold on;
plot3(x(indexMin),y(indexMin),min(f), 'b*');

str={'max'};text(1.0717,1,9,str);
str={'min'};text(1.0717,-1,-9,str);
xlabel('x');ylabel('y'),zlabel('f');
%% Question 2.b
clear;
syms x1 x2 x3 lamda
f = x1.*x2.*x3;
g = x1.*x3+x1.*x2+x2.*x3-5;
L = f+lamda*g;
vector_cond = jacobian(L, [x1 x2 x3 lamda]) == 0;
soln = solve(vector_cond, [x1 x2 x3 lamda]);
x1 = real(double(soln.x1));
x2 = real(double(soln.x2));
x3 = real(double(soln.x3));
f = x1.*x2.*x3;
disp(max(f));

%% Question 2.c
clear;
syms x1 x2 x3 lamda
P = 8*x1*x2*x3^2-200*(x1+x2+x3);
g = x1+x2+x3-100;
L = P+lamda*g;
vector_cond = jacobian(L, [x1 x2 x3 lamda]) == 0;
soln = solve(vector_cond, [x1 x2 x3 lamda]);
x1 = real(double(soln.x1));
x2 = real(double(soln.x2));
x3 = real(double(soln.x3));
P = 8.*x1.*x2.*x3.^2-200.*(x1+x2+x3);
disp(max(P));
