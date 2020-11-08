%% Plot - Computational cost
figure;
yyaxis left
plot(M,itt);
title("Computational cost as funciton of the mesh size","Interpreter","latex");
ylabel("Number of iterations", "Interpreter","latex")
xlabel("Mesh size M","Interpreter","latex")

yyaxis right
plot(M,time);
ylabel("Time to converge [s]","Interpreter","latex")