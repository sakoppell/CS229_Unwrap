function [Q,D]=Estep(X,Z,mu,sigma,phi,M)

m=length(X);
n=length(Z);
%Q(i,j) is p(z^j given x^i)
Q=zeros(m,n);
D=zeros(m,n,8);

%gnf=1/sqrt((2*pi)^12*det(sigma));
fprintf('E step: ');
for i=1:m
    for j=1:n
            %calculate derivatives (make a function to calculate all at the same time)
            thisD=dd((X(:,:,i)+Z(:,:,j))/M);
            D(i,j,:)=thisD;
            %calculate D(mu,sigma)
            pD=exp((thisD-mu)'*(sigma^-1)*(thisD-mu));
            Q(i,j)=pD;
    end
    %normalize Q(i,:)
    Q(i,:)=Q(i,:).*phi';
    sumQ=sum(Q(i,:));
    if sumQ>0
        Q(i,:)=Q(i,:)/sumQ;
    end
    if mod(i,m/10)==0
        fprintf(' %d ',11-i/m*10);
    end
    %fprintf('E step: %d of %d \n',i,m);
end
fprintf('\n');
end