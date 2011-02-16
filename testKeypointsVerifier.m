function test_suite = testKeypointsVerifier
initTestSuite;

function testGivenAListOfPairsReturnsTheKeypointsOfTheFirstImage
pairs = cell(2, 1);
first = Keypoint(1, 1);
second = Keypoint(2, 4);
pairs{1} = KeypointsPair(first, 0);
pairs{2} = KeypointsPair(second, 0);
verifier = KeypointsVerifier();
keypoints = verifier.getFirstImageKeypoints(pairs);
assertEqual([2 1], size(keypoints));
assertEqual(first, keypoints{1});
assertEqual(second, keypoints{2});

function testGivenAListOfPairsReturnsTheKeypointsOfTheSecondImage
pairs = cell(2, 1);
first = Keypoint(1, 1);
second = Keypoint(2, 4);
pairs{1} = KeypointsPair(0, first);
pairs{2} = KeypointsPair(0, second);
verifier = KeypointsVerifier();
keypoints = verifier.getSecondImageKeypoints(pairs);
assertEqual([2 1], size(keypoints));
assertEqual(first, keypoints{1});
assertEqual(second, keypoints{2});
