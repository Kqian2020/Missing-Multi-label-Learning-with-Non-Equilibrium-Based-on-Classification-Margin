function Conf= NeLC(train_data,train_target,s)

[num_class,~]=size(train_target);
[num_training,~]=size(train_data);

b=zeros(num_class*num_class,num_training);
c=zeros(num_class*num_class,num_training);
e=zeros(num_class*num_class,num_training);
f=zeros(num_class*num_class,num_training);

for j=1:num_training
    for i=1:num_class
        for k=1:num_class
            t=(i-1)*num_class+k;
            if(train_target(i,j)==1&&train_target(k,j)==-1)
                b(t,j)=1;
            elseif(train_target(i,j)==-1&&train_target(k,j)==1)
                c(t,j)=1;
            elseif(train_target(i,j)==1&&train_target(k,j)==0)
                e(t,j)=1;
            elseif(train_target(i,j)==-1&&train_target(k,j)==0)
                f(t,j)=1;
            end
            Out_b(t,1)=-1/(((s+sum(b(t,:)))/(s*2+num_training))*log2((s+sum(b(t,:)))/(s*2+sum(train_target(i,:)==ones(1,num_training)))));
            Out_c(t,1)=-1/(((s+sum(c(t,:)))/(s*2+num_training))*log2((s+sum(c(t,:)))/(s*2+sum(train_target(i,:)==-ones(1,num_training)))));
            Out_e(t,1)=-1/(((s+sum(e(t,:)))/(s*2+num_training))*log2((s+sum(e(t,:)))/(s*2+sum(train_target(i,:)==zeros(1,num_training)))));
            Out_f(t,1)=-1/(((s+sum(f(t,:)))/(s*2+num_training))*log2((s+sum(f(t,:)))/(s*2+sum(train_target(i,:)==zeros(1,num_training)))));
        end
    end
end

% I = zeros(num_class,num_class);
for i=1:num_class
    for k=1:num_class
        t=(i-1)*num_class+k;
        T_b(i,k)=Out_b(t,1);
        T_c(i,k)=Out_c(t,1);
        T_e(i,k)=Out_e(t,1);
        T_f(i,k)=Out_f(t,1);
        I(i,k) = p_entropy([train_target(i,:);train_target(k,:)]');
    end
end

T_b1=T_b;
T_c1=T_c;
T_e1=T_e;
T_f1=T_f;

T_b1(logical(eye(size(T_b1))))=0;
T_c1(logical(eye(size(T_c1))))=0;
T_e1(logical(eye(size(T_e1))))=0;
T_f1(logical(eye(size(T_f1))))=0;

T_5 = T_b1./repmat(sum(T_b1,2),1,size(T_b1,2));
T_6 = T_c1./repmat(sum(T_c1,2),1,size(T_c1,2));%%按行求和
T_7 = T_e1./repmat(sum(T_e1,2),1,size(T_e1,2));
T_8 = T_f1./repmat(sum(T_f1,2),1,size(T_f1,2));

Smooth = 1;
Y_train_target = train_target==1;
N_train_target = train_target==-1;
temp_Ci = sum(Y_train_target(:));
temp_NCi = sum(N_train_target(:));
temp = temp_Ci+temp_NCi;
Prior = (Smooth+temp_Ci)/(Smooth*2+temp);
PriorN = (Smooth+temp_NCi)/(Smooth*2+temp);

Conf=(-(T_5+T_7).*PriorN+(T_6+T_8).*(Prior));
Conf(logical(eye(size(Conf))))=1;%%对角线元素置为1