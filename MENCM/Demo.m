%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This is an examplar file on how the MNECM program could be used.
%
% The experimental datasets are also available at：
% Yahoo Web Pages(http://www.kecl.ntt.co.jp/as/members/ueda/yahoo.tar)
% Mulan (http://mulan.sourceforge.net/datasets-mlc.html)
% 
% Please feel free to contact me (chengyshaq@163.com), if you have any problem about this programme.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;clc
addpath('evl');

%smooth parameter
s=1;
%non-Equilibrium parameter
alpha = 0.3;
%regularization 
C=1;
%kernel parameter
kernel_para=1;
%kernel type
kernel_type='RBF_kernel';
%r
p=1;

load('Birds.mat');
Ytrn = train_target;
%get missing label
[J] = genObv(Ytrn,p);
Ytrain=J.*train_target;
% train
[Ynew] = MNECM(train_data,Ytrain,s);

[ret] = elm_kernel(test_data,test_target,train_data,Ynew,C,kernel_type,kernel_para);

