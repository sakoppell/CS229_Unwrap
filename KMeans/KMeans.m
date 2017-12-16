%k means to generate representative neighborhoods
%nC: number of centroids
%r: diameter of neighborhoods
%Dat: training data
function Library=KMeans(nC,r,Dat)

%throw away extra data
extra=mod(length(Dat),r);
Dat(:,end-extra+1:end)=[];
Dat(end-extra+1:end,:)=[];

%break Dat into m training neighborhoods
m=(length(Dat)/r)^2;
Dat=reshape(Dat,[r,r,m]);

%make translation invariant and subtract mean;
for i=1:m
    Dat(:,:,i)=abs(fft2(Dat(:,:,i)));
    Dat(1,1,i)=0;%subtract mean
end


%initialize cenroids
Library=zeros(r,r,nC);
%(pick without replacement from all the training examples)
startC=datasample([1:m],nC,'Replace',false);
for i=1:nC
    Library(:,:,i)=Dat(:,:,startC(i));
end


paint=zeros(1,m);

for i=1:30
    %paint data
    for j=1:m
        bestLoss=Inf;
        bestIndex=1;
        for k=1:nC
            l=loss(Library(:,:,k),Dat(:,:,j));
            if(l<bestLoss)
                bestLoss=l;
                bestIndex=k;
            end
        end
        paint(j)=bestIndex;
    end
    
    %calculate centriods
    newC=zeros(r,r,nC);
    newCcount=zeros(nC,1);
    for j=1:m
        newC(:,:,paint(j))=newC(:,:,paint(j))+Dat(:,:,j);
        newCcount(paint(j))=newCcount(paint(j))+1;
    end
    eps=zeros(1,nC);
    for k=1:nC
        newC(:,:,k)=newC(:,:,k)./newCcount(k);
        if isnan(newC(1,1,k))
            newC(:,:,k)=Library(:,:,k);
        end
        eps(k)=eps(k)+loss(Library(:,:,k),newC(:,:,k));
    end
    
    fprintf('iter %d of %d. eps = %f\n',i,30,sum(eps));
    Library=newC;
end

for i=1:nC
    Library(:,:,i)=ifft2(Library(:,:,i));
end

end



function l=loss(R,R0)
%R=R-mean(R(:));
%R0=R0-mean(R0(:));
R=(R-R0).^2;
l=sqrt(sum(R(:)));
end