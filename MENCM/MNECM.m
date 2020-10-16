function [Ynew] = MNECM(train_data,train_target,s)
% Classification margin based on label density
LDP=LD('T',train_target');
% non-equilibrium labels completion matrix
Conf =  NeLC(train_data,train_target,s);
% label completion
Ynew=Conf*LDP;