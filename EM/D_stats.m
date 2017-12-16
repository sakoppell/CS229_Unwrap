%Calculate distributions of 1st and 2nd derivatives in image
n=512;
n_bins=200;
scale=.5;
%W_train=perlin2D(n);
W_train=a.potSum/max(a.potSum(:));
imagesc(W_train)
d1short_bins=zeros(1,n_bins);
d1long_bins=zeros(1,n_bins);
d2short_bins=zeros(1,n_bins);
d2long_bins=zeros(1,n_bins);

for i=2:n-1
    for j=2:n-1
        x=W_train(i-1:i+1,j-1:j+1);
        d1short=ceil(d1(x,1,2)*n_bins/2*scale+n_bins/2);
        d1short_bins(d1short)=d1short_bins(d1short)+1;
        d1short=ceil(d1(x,2,3)*n_bins/2*scale+n_bins/2);
        d1short_bins(d1short)=d1short_bins(d1short)+1;
        d1short=ceil(d1(x,3,2)*n_bins/2*scale+n_bins/2);
        d1short_bins(d1short)=d1short_bins(d1short)+1;
        d1short=ceil(d1(x,2,1)*n_bins/2*scale+n_bins/2);
        d1short_bins(d1short)=d1short_bins(d1short)+1;
        
        d2short=ceil(d2(x,1,2)*n_bins/2*scale+n_bins/2);
        d2short_bins(d2short)=d2short_bins(d2short)+1;
        d2short=ceil(d2(x,2,1)*n_bins/2*scale+n_bins/2);
        d2short_bins(d2short)=d2short_bins(d2short)+1;
        
        d1long=ceil(d1(x,1,1)*n_bins/2*scale+n_bins/2);
        d1long_bins(d1long)=d1long_bins(d1long)+1;
        d1long=ceil(d1(x,1,3)*n_bins/2*scale+n_bins/2);
        d1long_bins(d1long)=d1long_bins(d1long)+1;
        d1long=ceil(d1(x,3,3)*n_bins/2*scale+n_bins/2);
        d1long_bins(d1long)=d1long_bins(d1long)+1;
        d1long=ceil(d1(x,3,1)*n_bins/2*scale+n_bins/2);
        d1long_bins(d1long)=d1short_bins(d1long)+1;
        
        d2long=ceil(d2(x,1,1)*n_bins/2*scale+n_bins/2);
        d2long_bins(d2long)=d2long_bins(d2long)+1;
        d2long=ceil(d2(x,1,3)*n_bins/2*scale+n_bins/2);
        d2long_bins(d2long)=d2long_bins(d2long)+1;
    end
end

d1long_bins(n_bins/2+1)=0;
d1short_bins(n_bins/2+1)=0;
d1long_bins(n_bins/2)=0;
d1short_bins(n_bins/2)=0;

d1short=d1short/(n-2)^2;
d2short=d2short/(n-2)^2;
d1long=d1long/(n-2)^2;
d2long=d2long/(n-2)^2;

plot(log(d1short_bins))
hold
plot(log(d1long_bins))

%conclusion: for perlin,
%log(d1) ~ -x^2/sigma^2, with sigma~0.077
%log(d2) ~ -x^2/sigma^2, with sigma~0.049
%for HIV, the result is like a gaussian near the center and
%a lorentzian (?) near the tails.