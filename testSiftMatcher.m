function test_suite = testSiftMatcher
initTestSuite;

function testExtractsAKeypointFromAnImage
first_image = cell(2, 1);
first_image{1} = Keypoint(0, 0, 0, 0, [1; 2; 3]);
first_image{2} = Keypoint(1, 0, 0, 0, [2; 4; 6]);
second_image = cell(2, 1);
second_image{1} = Keypoint(2, 0, 0, 0, [2; 4; 6]);
second_image{2} = Keypoint(3, 0, 0, 0, [1; 2; 3]);

detector = SiftMatcher();
pairs = detector.matchKeypoints(first_image, second_image);
assertEqual(2, size(pairs, 1));
assertEqual(0, pairs{1}.first.x);
assertEqual(3, pairs{1}.second.x);
assertEqual(1, pairs{2}.first.x);
assertEqual(2, pairs{2}.second.x);

