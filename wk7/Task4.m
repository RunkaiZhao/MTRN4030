%% Question 4.c

A = [0,1;0 0];
B = [0;1];
C = [1,0;0,1];
D = [0;0];
Qu = 1;
Q1 = [1 2 5];
K = zeros(3,2);
SYS = ss(A,B,C,D);


    Q = Q1(3);
    Qx = [Q^2,0;0,0];
    [K,S,E]=lqr(SYS,Qx,Qu);
