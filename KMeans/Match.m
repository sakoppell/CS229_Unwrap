%match a pixel neighborhood to an image from the library
function bestCandidate=Match(neighborhood,Library,M)

[n,~]=size(neighborhood);

neighborhood=neighborhood-mean(neighborhood(:));

bestLossL=Inf;
bestIndexL=1;

for i=1:length(Library)
    candidate=Library(:,:,i);
    bestLossT=Inf;
    bestIndexT=[1,1];
    for j=1:n
        for k=1:n
            l=loss(neighborhood,mod(candidate*M,1));
            if(l<bestLossT)
                bestLossT=l;
                bestIndexT=[j,k];
            end
            candidate=candidate([n,1:n-1],:);
        end
        candidate=candidate(:,[n,1:n-1]);
    end
    if bestLossT<bestLossL
        bestLossL=bestLossT;
        bestIndexL=[n,bestIndexT];
    end
end

bestCandidate=Library(:,:,bestIndexL(1));
for j=1:bestIndexL(2)
    for k=1:bestIndexL(3)
        bestCandidate=bestCandidate([n,1:n-1],:);
    end
    bestCandidate=bestCandidate(:,[n,1:n-1]);
end

end

function l=loss(R,R0)
R=(R-R0).^2;
l=sqrt(sum(R(:)));
end