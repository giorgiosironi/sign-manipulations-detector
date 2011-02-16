function test_suite = testSiftDetector
initTestSuite;

function testExtractsAKeypointFromAnImage
image = imread('original.tiff');
image = single(image(:, :, 1));
detector = SiftDetector(1);
keypoints = detector.findKeypoints(image);
keypoint = keypoints{1};
assertEqual(238, round(keypoint.x));
assertEqual(104, round(keypoint.y));
assertEqual(2, round(keypoint.scale));
assertEqual(1, round(keypoint.orientation));
descriptor = keypoint.descriptor;
assertEqual(128, size(descriptor, 1));
whos descriptor(8)
whos 0
assertEqual(0, double(descriptor(8)));
assertEqual(151, double(descriptor(9)));

