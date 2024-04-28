function fitness=fitness_fun_method1(pop)
    x=pop(1);
    y=pop(2);
    punish=0;
    p=9;
    if -2*x+3*y > 12
        punish=punish+p*(-2*x+3*y-12);
    end
    if x+y > 14
        punish=punish+p*(x+y-14);
    end
    fitness=-x-2*y+punish;
end