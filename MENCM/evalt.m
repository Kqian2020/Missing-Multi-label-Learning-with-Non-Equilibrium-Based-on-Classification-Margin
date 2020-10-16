function [ Result ] = evalt(Fpred,Ygnd,thr)
 Ypred = sign(Fpred-thr);

 %% Average Precision
AvgPrec = Average_precision(Fpred,Ygnd);
Result.AveragePrecision = AvgPrec;

%% Coverage
Cvg = coverage(Fpred,Ygnd);
Result.Coverage = Cvg;

%% Hamming Loss
HL = Hamming_loss(Ypred,Ygnd);
Result.HammingLoss = HL;

%% One Error
OE = One_error(Fpred,Ygnd);
Result.OneError = OE;
%% Ranking Loss
RkL = Ranking_loss(Fpred,Ygnd);
Result.RankingLoss = RkL;
%% Top
Result.Top1 = topRate(Fpred',Ygnd',1);
Result.Top3 = topRate(Fpred',Ygnd',3);
Result.Top5 = topRate(Fpred',Ygnd',5);
%% AUC
Result.AvgAuc = avgauc(Fpred,Ygnd);