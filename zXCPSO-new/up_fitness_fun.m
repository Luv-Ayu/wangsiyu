function fitness=up_fitness_fun(pop)
    x=pop;
    y=main_down(x);
    punish=0;
    if -2*x+3*y > 12
        punish=punish+999;
    end
    if x+y > 14
        punish=punish+999;
    end
    fitness=-x-2*y+punish;
end