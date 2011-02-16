function plotPair(photo, world, pair)
figure(1);
hold off;
colormap gray;
imagesc(photo);
hold on;
plot(pair.first.y, pair.first.x, 'ro');
figure(2);
hold off;
imshow(world);
hold on;
plot(pair.second.y, pair.second.x, 'ro');

