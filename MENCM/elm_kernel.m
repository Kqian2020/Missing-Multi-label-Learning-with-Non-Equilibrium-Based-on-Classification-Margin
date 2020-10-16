function [ret] = elm_kernel(test_data,test_target,train_data,train_target,C,kernel_type,kernel_para)
    n = size(train_target,2);

    Omega_train = kernel_matrix(train_data,kernel_type,kernel_para);
    OutputWeight=((Omega_train+speye(n)/C)\(train_target')); 

%%%%%%%%%%% Calculate the output of testing input

    Omega_test = kernel_matrix(train_data,kernel_type,kernel_para,test_data);
    TY=(Omega_test'*OutputWeight)';    %   TY: the actual output of the testing data

%%%%%%%%%%evaluation 
  ret =  evalt(TY,test_target, (max(TY(:))-min(TY(:)))/2);