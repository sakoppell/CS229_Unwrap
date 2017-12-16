function Z=makeZ()
Z=[];

for a0=-1:1
    for a1=max(a0-1,-1):min(a0+1,1)
        for a2=max(a1-1,-1):min(a1+1,1)
            for a3=max(a2-1,-1):min(a2+1,1)
                for a4=max(a3-1,-1):min(a3+1,1)
                    for a5=max(a4-1,-1):min(a4+1,1)
                        for a6=max(a5-1,-1):min(a5+1,1)
                            for a7=max(a6-1,-1):min(a6+1,1)
                                if(abs(a0-a7)<2)
                                    Znew=zeros(3);
                                    Znew(1,2)=a0;
                                    Znew(1,3)=a1;
                                    Znew(2,3)=a2;
                                    Znew(3,3)=a3;
                                    Znew(3,2)=a4;
                                    Znew(3,1)=a5;
                                    Znew(2,1)=a6;
                                    Znew(1,1)=a7;
                                    Z=cat(3,Z,Znew);
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

% Znew=-2*ones(4,4,length(Z));
% for i=1:length(Z)
%     Znew(1:3,1:3,i)=Z(:,:,i);
% end
% Z=Znew;
% Z=reshape(Z,15*4,77*4);
end