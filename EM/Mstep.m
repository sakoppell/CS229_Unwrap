function [mu,sigma,phi]=Mstep(X,Z,D,Q)

m=length(X);
n=length(Z);
nD=8;
phi=zeros(n,1);
mu=zeros(nD,1);
sigma=zeros(nD);

sumQ=sum(Q(:));

%optimize the parameters like the mixture of gaussians model
for j=1:n
    phi(j)=sum(Q(:,j))/m;
end

for k=1:8
    mu(k)=sum(sum(Q.*D(:,:,k)));
end
mu=mu/sumQ;

for i=1:nD
    for j=1:nD
        sigma(i,j)=sum(sum(Q.*(D(:,:,i)-mu(i)).*(D(:,:,j)-mu(j))));
    end
end
sigma=sigma/sumQ;

end