function [TT] = LD(model,T)
T = T';
[n,nc] = size(T);     % nc ==> num_class n==> num_instance

%% TD 
PTDW = sum(T==1)/sum(sum(T==1))+1;
NTDW = sum(T==-1)/sum(sum(T==-1))+1;

PTT = T; PTT(PTT==-1) = 0;
PTD = PTT.*repmat(PTDW,n,1);
PD = PTD;
PD(PD==0)=-1;

NTT = T; NTT(NTT==1) = 0;
NTD = NTT.*repmat(NTDW,n,1);
ND = NTD;
ND(ND==0)=1;

TD = PTD + NTD;

if model == 'P'
    TT = PD;
elseif model == 'N'
    TT = ND;
elseif model == 'T'
    TT = TD;
else
    disp('Input Error!!!');
end
    