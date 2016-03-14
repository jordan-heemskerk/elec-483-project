function DHTcraig

cimage = input('Enter name of image: ','s');
initialimage=imread(cimage);
initialimage=double(initialimage);
figure,imshow(uint8(initialimage));
[xm,xn]=size(initialimage);
T=hadamard(8); 
y=blkproc(initialimage,[8 8],'P1*x*P2',T,T); 
m=[1 1 1 1 1 0 0 0

    1 1 1 1 0 0 0 0

    1 1 1 0 0 0 0 0

    1 1 0 0 0 0 0 0

    1 0 0 0 0 0 0 0

    0 0 0 0 0 0 0 0

    0 0 0 0 0 0 0 0

    0 0 0 0 0 0 0 0];
yy=blkproc(y,[8 8],'round(x.*P1)',m);
y1=im2col(yy,[8 8],'distinct'); 
xb=size(y1,2); 
order = [1 9 2 3 10 17 25 18 11 4 5 12 19 26 33 41 34 27 20 13 6 7 14 21 28 35 42 49 57 50 43 36 29 22 15 8 16 23 30 37 44 51 58 59 52 45 38 31 24 32 39 46 53 60 61 54 47 40 48 55 62 63 56 64];
y2 = y1(order, :);
eob = max(y2(:)) + 1; 
num = numel(y2) + size(y2, 2);
r = zeros(num, 1);
 count = 0;
 for j = 1: xb
 i = max(find(y2(:, j)));
  if isempty(i)
      i = 0;

  end
     p = count + 1;
     q = p + i;
     r(p: q) = [y2(1: i, j); eob];
     count = count + i + 1;
 end
 r((count + 1): end) = [];
 rev = order;
 
 
 for k = 1:length(order)

    rev(k) = find(order == k);

 end

 
     z = zeros(64, xb);

k = 1;

for j = 1: xb

    for i = 1: 64

       if k<=size(r,1)

        if r(k) == eob

            k = k + 1;

            break;

        else

            z(i, j) = r(k);

            k = k + 1;

        end

       end

    end

end

z = z(rev, :); 
x1 = col2im(z, [8, 8], [xm, xn], 'distinct');
x = blkproc(x1, [8, 8], 'P1*x*P2',T, T);

x=uint8(x./(8*8));

figure,imshow(x);

M=double(x)-initialimage;

M=M.^2;

EMS=(sum(sum(M)))/(xm*xn)

PSNR=10*log10((255*255)/EMS)

ratio=xm*xn/(count+1)  
     
 
