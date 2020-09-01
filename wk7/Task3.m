%% Question 3.a
syms x1 x2 l1 l2 l3 b1
f = (x1-1)^2+(x2-2)^2;
g1 = x1;
g2 = x2;
g3 = -x1-x2+2;
h1 = -x1+x2-1;

L = f+l1*g1+l2*g2+l3*g3-b1*h1;
L_diff = jacobian(L, [x1 x2]) == 0;
f1 = l1*g1 == 0;
f2 = l2*g2 == 0;
f3 = l3*g3 == 0;
f4 = b1*h1 == 0;

soln = solve(L_diff, f1, f2, f3, f4, [x1 x2 l1 l2 l3 b1]);
x1 = soln.x1;
x2 = soln.x2;
f = (x1-1).^2+(x2-1).^2;
f_mina = min(f);
indice = find(f == f_mina);
x1_a = x1(indice);
x2_a = x2(indice);
disp('the min of function:');disp(f_mina);disp(' x1:');disp(x1_a);disp(' x2:');disp(x2_a);

%% Question 3.b
clear;
syms x1 x2 l1 l2 l3
f = 3*x1+sqrt(3)*x2;
g1 = -x1+5.73;
g2 = -x2+7.17;
g3 = -3+18/x1+6*sqrt(3)/x2;

L = f + l1*g1+l2*g2+l3*g3;
L_diff = jacobian(L, [x1 x2]) == 0;
f1 = l1*g1 == 0;
f2 = l2*g2 == 0;
f3 = l3*g3 == 0;

soln = solve(L_diff, f1, f2, f3, [x1 x2 l1 l2 l3]);
x1 = double(soln.x1);
x2 = double(soln.x2);
% x1 = x1(4);
% x2 = x2(4);
f = 3.*x1+sqrt(3).*x2;
f_minb = min(f);
indice = find (f == f_minb);
x1_b = x1(indice);
x2_b = x2(indice);
disp('the min of function:');disp(f_minb);disp(' x1_b:');disp(x1_b);disp(' x2_b:');disp(x2_b);
