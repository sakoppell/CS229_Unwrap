%calculate all derivatives in 3x3 square W
function D=dd(W)
% D=zeros(12,1);
% D(1)=W(2,2)-W(1,1);
% D(2)=W(2,2)-W(2,1);
% D(3)=W(2,2)-W(3,1);
% D(4)=W(2,2)-W(3,2);
% D(5)=W(3,3)-W(2,2);
% D(6)=W(2,3)-W(2,2);
% D(7)=W(1,3)-W(2,2);
% D(8)=W(1,2)-W(2,2);
% D(8)=W(1,2)-W(2,2);
D=zeros(8,1);
D(1)=W(3,3)-W(1,1);
D(2)=W(2,3)-W(2,1);
D(3)=W(1,3)-W(3,1);
D(4)=W(1,2)-W(3,2);
D(5)=W(1,1)-2*W(2,2)+W(3,3);
D(6)=W(1,2)-2*W(2,2)+W(3,2);
D(7)=W(1,3)-2*W(2,2)+W(3,1);
D(8)=W(2,1)-2*W(2,2)+W(2,3);
% D(9)=W(1,1)-2*W(2,2)+W(3,3);
% D(10)=W(1,2)-2*W(2,2)+W(3,2);
% D(11)=W(1,3)-2*W(2,2)+W(3,1);
% D(12)=W(2,1)-2*W(2,2)+W(2,3);
end