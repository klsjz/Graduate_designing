  %clc
%clear

%% 训练数据预测数据提取及归一化
%下载输入输出数据
%load data input output

%从1到2000间随机排序
%k=rand(1,104);
%[m,n]=sort(k);

%找出训练数据和预测数据
%
% input=conflict_out_original(1:2500,1:199)';
% target=conflict_out(1:2500,1:199)';
% for i=1:2500
%    miss(i)=sum(target(17:199,i));
% end
input_train=input(1:199,1:1000);
output_train=miss(1,1:1000);
input_test=input(1:199,1001:2500);
output_test=miss(1,1001:2500);

%[test,testps]=mapminmax(output_test);

%选连样本输入输出数据归一化
[input_train,inputs]=mapminmax(input_train);
[output_train,outputs]=mapminmax(output_train);

%% BP网络训练
% %初始化网络结构
%net=newff(input_train,output_train,[5,5],{'tansig','purelin'},'trainscg'); %traingda,traincgb.trainscg,trainlm
net=newff(input_train,output_train,[2,6],{'tansig','purelin'},'trainlm'); %traingda,traincgb.trainscg,trainlm
%net=newff(input_train,output_train,10,{'tansig'},'traincgb');
net.trainParam.epochs=50000;
net.trainParam.lr=0.05;
%net.trainParam.show=100;

% net.trainParam.goal=0.00000000057;
net.trainParam.goal=2e-10;
% net.trainParam.min_grad=2.00e-8;

net.divideFcn = '';

%网络训练
net=train(net,input_train,output_train);

%% BP网络预测
%预测数据归一化
input_test = mapminmax('apply',input_test,inputs);
%output_test=mapminmax(output_test);
 
%网络预测输出
an=sim(net,input_test);
an=mapminmax('reverse',an,outputs); 
j=0;
for i=1:1500
   if output_test(i)~=0    
       j=j+1; 
       error(j) = abs((an(i)-output_test(i)))/abs((output_test(i)));
   end
end
[m,n]=size(error);
sumerror = sum(error);
avgerror=sumerror/j;



%网络输出反归一

plot(an,'r');
hold on;
plot(output_test,'b');
hold on;

plot(error,'k');
hold off;