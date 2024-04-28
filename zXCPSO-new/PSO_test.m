%% �������
clc
clear
close all
warning off
%% ������Ⱥ����
sizepop =5000;                       
dim =2;                             
ger = 100;                              
x_max = 14*ones(1,dim);             
x_min = -8*ones(1,dim);             
v_max = 7*ones(1,dim);              
v_min = -7*ones(1,dim);             
w=0.9;                              
c_1 = 1.6;                          
c_2 = 1.8;                           
%% ��Ⱥ��ʼ��
pop=x_min+rand(sizepop,dim).*(x_max-x_min);     % ��ʼ����Ⱥ
pop_v=v_min+rand(sizepop,dim).*(v_max-v_min);   % ��ʼ����Ⱥ�ٶ�        
pop_zbest=pop(1,:);                             % ��ʼ��Ⱥ������λ��
pop_gbest=pop;                                  % ��ʼ����������λ��
fitness=zeros(1,sizepop);                       % ���и������Ӧ��
fitness_zbest=inf;                              % ��ʼ��Ⱥ��������Ӧ��
fitness_gbest=inf*ones(1,sizepop);              % ��ʼ������������Ӧ��
% ��ʼ����Ӧ��
for k=1:sizepop
    % ������Ӧ��ֵ
    fitness(k)=sum(pop(k,:).^2);
    if fitness(k)<fitness_zbest
        fitness_zbest=fitness(k);
        pop_zbest=pop(k,:);
    end
end
history_pso=zeros(1,ger);            % ����Ⱥ��ʷ������Ӧ��ֵ
%% ���������Ž�
iter=1;
while iter <= ger
    for k=1:sizepop
        % �����ٶȲ����ٶȽ��б߽紦�� 
        pop_v(k,:)= w * pop_v(k,:) + c_1*rand*(pop_gbest(k,:)-pop(k,:))+c_2*rand*(pop_zbest-pop(k,:));
        for kk=1:dim
            if  pop_v(k,kk) > v_max(kk)
                pop_v(k,kk) = v_max(kk);
            end
            if  pop_v(k,kk) < v_min(kk)
                pop_v(k,kk) = v_min(kk);
            end
        end
        % ����λ�ò���λ�ý��б߽紦��
        pop(k,:)=pop(k,:)+pop_v(k,:);
        for kk=1:dim
            if  pop(k,kk) > x_max(kk)
                pop(k,kk) = x_max(kk);
            end
            if  pop(k,kk) < x_min(kk)
                pop(k,kk) = x_min(kk);
            end
        end
        % ������Ӧ��ֵ
        fitness(k)=sum(pop(k,:).^2);
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
    disp(['PSO��',num2str(iter),'�ε�������ֵ=',num2str(fitness_zbest)])
    iter=iter+1;
end
disp(['���Ž⣺x=',num2str(pop_zbest)])
disp(['���ź���ֵ=',num2str(fitness_zbest)])
plot(history_pso,'linewidth',1)
ylabel('����ֵ')
xlabel('��������')