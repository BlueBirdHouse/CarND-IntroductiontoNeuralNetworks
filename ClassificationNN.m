%% 处理binary为课上的模式
%备份数据
Data = binary;

%生成训练的目标集合
Admit = logical(Data.admit);

%生成训练集合
m = size(Data,1);
rank_1 = zeros(m,1);
rank_2 = zeros(m,1);
rank_3 = zeros(m,1);
rank_4 = zeros(m,1);
rank_table = table(rank_1,rank_2,rank_3,rank_4);

for i = 1:1:m
    AData = Data(i,:);
    [rank_1,rank_2,rank_3,rank_4] = Expand_Rank(AData.rank);
    rank_table{i,:} = [rank_1 rank_2 rank_3 rank_4];
end
Data = [Data rank_table];
Data.rank = [];
Data.admit = [];
Data = table2array(Data);

%将Admit也分裂为虚变量
Admit12 = zeros(m,2);
for i = 1:1:m
    if Admit(i)
       Admit12(i,:) = [true false];
    else
        Admit12(i,:) = [false true];
    end
end

%数据归一化
%Data(:,1) = (mapstd(Data(:,1)'))';
%Data(:,2) = (mapstd(Data(:,2)'))';
%Data(:,3) = (mapstd(Data(:,3)'))';

%使用“classificationLearner”用到的数据
Data = [Data Admit];


function [rank_1,rank_2,rank_3,rank_4] = Expand_Rank(rank)
    %利用隐变量的方法，将Rank分为四个变量
    switch rank
        case 1
            [rank_1,rank_2,rank_3,rank_4] = deal(1,0,0,0);
        case 2
            [rank_1,rank_2,rank_3,rank_4] = deal(0,1,0,0);
        case 3
            [rank_1,rank_2,rank_3,rank_4] = deal(0,0,1,0);
        case 4
            [rank_1,rank_2,rank_3,rank_4] = deal(0,0,0,1);
    end 
end