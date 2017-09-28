%% ����binaryΪ���ϵ�ģʽ
%��������
Data = binary;

%����ѵ����Ŀ�꼯��
Admit = logical(Data.admit);

%����ѵ������
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

%��AdmitҲ����Ϊ�����
Admit12 = zeros(m,2);
for i = 1:1:m
    if Admit(i)
       Admit12(i,:) = [true false];
    else
        Admit12(i,:) = [false true];
    end
end

%���ݹ�һ��
%Data(:,1) = (mapstd(Data(:,1)'))';
%Data(:,2) = (mapstd(Data(:,2)'))';
%Data(:,3) = (mapstd(Data(:,3)'))';

%ʹ�á�classificationLearner���õ�������
Data = [Data Admit];


function [rank_1,rank_2,rank_3,rank_4] = Expand_Rank(rank)
    %�����������ķ�������Rank��Ϊ�ĸ�����
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