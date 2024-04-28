%% 清除变量
clc
clear
close all
warning off
%% 设置种群参数
sizepop = 200;                      % 初始种群个数
dim = 2;                            % 空间维数
ger = 200;                          % 最大迭代次数    
x_max = 14*ones(1,dim);             % 位置上限
x_min = zeros(1,dim);               % 位置下限
v_max = 7*ones(1,dim);              % 速度上限
v_min = -7*ones(1,dim);             % 速度下限
w=0.9;                              % 惯性权重
c_1 = 1.5;                          % 自我学习因子
c_2 = 1.5;                          % 群体学习因子 
%% 种群初始化
pop=x_min+rand(sizepop,dim).*(x_max-x_min);     % 初始化种群
pop_v=v_min+rand(sizepop,dim).*(v_max-v_min);   % 初始化种群速度        
pop_zbest=pop(1,:);                             % 初始化群体最优位置
pop_gbest=pop;                                  % 初始化个体最优位置
fitness=zeros(1,sizepop);                       % 所有个体的适应度
fitness_zbest=inf;                              % 初始化群体最优适应度
fitness_gbest=inf*ones(1,sizepop);              % 初始化个体最优适应度
% 初始的适应度
for k=1:sizepop
    % 计算适应度值
    fitness(k)=fitness_fun_method2(pop(k,:));
    if fitness(k)<fitness_zbest
        fitness_zbest=fitness(k);
        pop_zbest=pop(k,:);
    end
end
history_pso=zeros(1,ger);            % 粒子群历史最优适应度值
%% 迭代求最优解
iter=1;
while iter <= ger
    for k=1:sizepop
        % 更新速度并对速度进行边界处理 
        pop_v(k,:)= w * pop_v(k,:) + c_1*rand*(pop_gbest(k,:)-pop(k,:))+c_2*rand*(pop_zbest-pop(k,:));
        for kk=1:dim
            if  pop_v(k,kk) > v_max(kk)
                pop_v(k,kk) = v_max(kk);
            end
            if  pop_v(k,kk) < v_min(kk)
                pop_v(k,kk) = v_min(kk);
            end
        end
        % 更新位置并对位置进行边界处理
        pop(k,:)=pop(k,:)+pop_v(k,:);
        for kk=1:dim
            if  pop(k,kk) > x_max(kk)
                pop(k,kk) = x_max(kk);
            end
            if  pop(k,kk) < x_min(kk)
                pop(k,kk) = x_min(kk);
            end
        end
        % 更新适应度值
        fitness(k)=fitness_fun_method2(pop(k,:));
        if fitness(k)<fitness_zbest
            fitness_zbest=fitness(k);
            pop_zbest=pop(k,:);
        end
        if fitness(k)<fitness_gbest(k)
            fitness_gbest(k)=fitness(k);
            pop_gbest(k,:)=pop(k,:);
        end
    end
    history_pso(iter)=fitness_zbest;
    disp(['PSO第',num2str(iter),'次迭代最优适应度=',num2str(fitness_zbest)])
    iter=iter+1;
end
disp(['最优解：x=',num2str(pop_zbest)])
disp(['最优函数值=',num2str(fitness_zbest)])
plot(history_pso,'linewidth',1)
ylabel('最优适应度值')
xlabel('迭代次数')