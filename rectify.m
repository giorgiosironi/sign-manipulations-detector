clear;
original = imread('original.tiff');
original = original(:, :, 1);
imshow(original);
x = [120 135 178 277];
y = [135 215 442 65];
% [y, x] = getpts();
A = [x(1) y(1)]';
B = [x(2) y(2)]';
C = [x(3) y(3)]';
D = [x(4) y(4)]';
perspective = imread('perspective.tiff');
perspective = perspective(:, :, 1);
imshow(perspective);
x = [89 103 181 268];
y = [172 259 435 78];
% [y, x] = getpts();
a = [x(1) y(1)]';
b = [x(2) y(2)]';
c = [x(3) y(3)]';
d = [x(4) y(4)]';

from = [flipud(a)'; flipud(b)'; flipud(c)'; flipud(d)']
imshow(perspective);
hold;
plot(from(:, 1), from(:, 2), 'rx');
to = [flipud(A'); flipud(B)'; flipud(C)'; flipud(D)'];
figure;
imshow(original);
hold;
plot(to(:, 1), to(:, 2), 'rx');

H = maketform('projective', from, to);
[rectified, xdata, ydata] = imtransform(perspective, H);
figure;
imshow(rectified);
%, 'XData', xdata, 'YData', ydata);

%keypoints = [A B C D]% - repmat([xdata(1) ydata(1)]', 1, 4);
%plot(keypoints(2, :), keypoints(1, :), 'bo');
