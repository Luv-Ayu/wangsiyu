function best_y=main_down(x)
    y=sdpvar(1);
    Constraints=[-3*x+y <= -3 , 3*x+y <= 30 ];
    objective=-y;
    ops=sdpsettings('verbose', 0 , 'solver', 'cplex');
    optimize(Constraints,objective,ops);
    best_y=value(y);
end