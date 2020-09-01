
%%
Num_supply = 2;
Num_demand = 3;
soln = zeros(Num_supply, Num_demand);
Origin = [2000 2500];
Destination = [1500 2000 1000];

i = 1;
j = 1;

while i < 3
    while j < 4
        if Origin(i) > Destination(j)
            soln(i,j) = min(Origin(i), Destination(j));
            Origin(i) = Origin(i)-Destination(j);
            Destination(j)=0;
        elseif Origin(i) < Destination(j)
            soln(i,j) = min(Origin(i), Destination(j));
            Destination(j) = Destination(j)-Origin(i);
            Origin(i)=0;
        elseif Origin(i) == Destination(j)
            soln(i,j)=Origin(i);
            Destination(j) = Destination(j)-Origin(i);
            Origin(i)=0;
        end
%             disp('Origin: ');
%             disp(Origin);
%             disp('Destination: ')
%             disp(Destination);
        disp(soln);
        j = j+1;
    end
    j = 1;
    i = i+1;
end

disp('solution:');
disp(soln);
%% 
Aeq = [1 1 1 0 0 0
       0 0 0 1 1 1
       1 0 0 1 0 0
       0 1 0 0 1 0
       0 0 1 0 0 1];
beq = [2000 2500 1500 2000 1000];
A =[];
b =[];
f = [8 6 10 10 4 9];
lb=[0 0 0 0 0 0];
ub=[];
x = linprog(f,A,b, Aeq, beq,lb,ub);

