function test_suite = testImageCutter
initTestSuite;

function testCutsImageAlongTheTopLeftKeypoint
cutter = ImageCutter();
im = [1 2 3; 4 5 6; 7 8 9];
points = cell(1);
points{1} = Keypoint(2, 2);
newImage = cutter.cut(im, points);
assertEqual(5, newImage(1, 1));

function testCutsImageAlongTheBottomRightKeypointToo
cutter = ImageCutter();
im = [1 2 3 4; 5 6 7 8; 9 10 11 12; 13 14 15 16];
points = cell(2, 1);
points{1} = Keypoint(2, 2);
points{2} = Keypoint(3, 3);
newImage = cutter.cut(im, points);
assertEqual([2 2], size(newImage));
assertEqual(11, newImage(2, 2));

function testRoundsCoordinatesOfKeypoints
cutter = ImageCutter();
im = [1 2 3; 4 5 6; 7 8 9];
points = cell(1);
points{1} = Keypoint(2.1, 1.9);
newImage = cutter.cut(im, points);
assertEqual(5, newImage(1, 1));

