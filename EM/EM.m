%initializations:
M=3; %number of times to wrap
maxiter=10;
Z=makeZ();
n=length(Z);
phi=ones(n,1)/n;
mu=zeros(8,1);
sigma=eye(8);

phi_save=zeros(n,maxiter+1);
phi_save(:,1)=phi;
mu_save=zeros(8,maxiter+1);
mu_save(:,1)=mu;
sigma_save=zeros(8,8,maxiter+1);
sigma_save(:,:,1)=sigma;
accuracy = zeros(maxiter,1);
block_accuracy=zeros(maxiter,1);
epsSig=zeros(maxiter,1);
epsQ=zeros(maxiter,1);

pixelBlocks=80;
X=perlin2D(3*pixelBlocks);
X_wrap=mod(M*X,1);
m=pixelBlocks^2;
X=reshape(X,3,3,m);
X_wrap=reshape(X_wrap,3,3,m);


Q=zeros(m,n);
for iter=1:maxiter
    %E Step
    [Q_new,D]=Estep(X_wrap,Z,mu,sigma,phi,M);
    epsQ(iter)=sum(sum(abs(Q-Q_new)));
    Q=Q_new;
    %M Step
    [mu,sigma_new,phi]=Mstep(X_wrap,Z,D,Q);
    mu_save(:,iter+1)=mu;sigma_save(:,:,iter+1)=sigma_new;phi_save(:,iter)=phi;
    epsSig(iter)=sum(sum(sigma-sigma_new));
    sigma=sigma_new;
    fprintf('finished iter %d of %d with epsQ=%e, epsSig=%e\n',iter,maxiter,epsQ(iter),epsSig(iter));
    
    %Calculate accuracy for this step
    
    %set X_out=X_wrap+Z_out, with Z_out(i) coresponding to max(Q(i,:))
    Xind=zeros(m);
    Xout=zeros(3,3,m);
    block_accuracy(iter)=0;
    accuracy(iter)=0;
    for i=1:m
        [~,Xind(i)]=max(Q(i,:));
        Xout(:,:,i)=X_wrap(:,:,i)+Z(Xind(i));
        offset = X(2,2,i)*M-X_wrap(2,2,i);
        if(X(:,:,i)*M==Xout(:,:,i)+offset)
            block_accuracy(iter)=block_accuracy(iter)+1;
        end
        for j=1:3
            for k=1:3
                if X(j,k,i)*M==Xout(j,k,i)+offset
                    accuracy(iter)=accuracy(iter)+1;
                end
            end
        end
    end
    
    accuracy(iter)=accuracy(iter)/m/9;
    block_accuracy(iter)=block_accuracy(iter)/m;
    fprintf('accuracy: %f\nblock accuracy: %f\n',accuracy(iter),block_accuracy(iter));
    
end
%stitch images...
