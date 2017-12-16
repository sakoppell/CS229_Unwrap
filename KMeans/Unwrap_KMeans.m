function [u,accuracy,block_accuracy]=Unwrap_KMeans(Library,Dat,M)

[r,~,~]=size(Library);
%throw away extra data
extra=mod(length(Dat),r);
Dat(:,end-extra+1:end)=[];
Dat(end-extra+1:end,:)=[];

%break Dat into m training neighborhoods
m=(length(Dat)/r)^2;
Dat=reshape(Dat,[r,r,m]);

%wrap
Dat_wrap=mod(M*Dat,1);

%subtract mean. 
% for i=1:m
%     Dat(:,:,i)=Dat(:,:,i)-sum(sum(Dat(:,:,i)));
% end

%N will store the prediction for the number of times
%each pixel wrapped
N=zeros(size(Dat));

for i=1:m
    candidate=Match(Dat_wrap(:,:,i),Library,M);
    N(:,:,i)=candidate*M-mod(candidate*M,1);
end

%now N should be accurate up to some constant offset.
%we'll standardize by adding an offset so that N(1,1)=0
%for the purposes of checking accuracy

for i=1:m
    N(:,:,i)=N(:,:,i)-N(1,1,i);
end

accuracy=0;
block_accuracy=0;
N_act=M*Dat-Dat_wrap;

for i=1:m
    N_act(:,:,i)=N_act(:,:,i)-N_act(1,1,i);
    correct=N(:,:,i)==N_act(:,:,i);
    if correct
        block_accuracy=block_accuracy+1;
    end
    accuracy=accuracy+sum(correct(:));
end

accuracy=accuracy/m/r^2;
block_accuracy=block_accuracy/m;

u=N;
end

