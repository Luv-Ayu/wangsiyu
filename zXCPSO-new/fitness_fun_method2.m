function fitness=fitness_fun_method2(pop)
    x=pop(1);
    y=pop(2);
    if -2*x+3*y > 12
        fitness=999;
    end
    if x+y > 14
        fitness=999;
    end
    if -2*x+3*y <= 12 && x+y <= 14
        fitness=-x-2*y;
    end
end