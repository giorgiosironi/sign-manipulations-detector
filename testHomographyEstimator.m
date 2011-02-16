function test_suite = testHomographyEstimator
initTestSuite;

function testProducesAnHomographyMatrixForDilations
pairs = cell(4);
pairs{1} = KeypointsPair(Keypoint(0, 0), Keypoint(0, 0));
pairs{2} = KeypointsPair(Keypoint(100, 0), Keypoint(200, 0));
pairs{3} = KeypointsPair(Keypoint(100, 100), Keypoint(200, 200));
pairs{4} = KeypointsPair(Keypoint(0, 100), Keypoint(0, 200));

estimator = HomographyEstimator();
T = estimator.getHomography(pairs);
[x, y] = tformfwd(T, 10, 30);
assertElementsAlmostEqual(20, x);
assertElementsAlmostEqual(60, y);

function testProducesAnHomographyMatrixForRotations
pairs = cell(4);
pairs{1} = KeypointsPair(Keypoint(0, 0), Keypoint(100, 0));
pairs{2} = KeypointsPair(Keypoint(100, 0), Keypoint(100, 100));
pairs{3} = KeypointsPair(Keypoint(100, 100), Keypoint(0, 100));
pairs{4} = KeypointsPair(Keypoint(0, 100), Keypoint(0, 0));

estimator = HomographyEstimator();
T = estimator.getHomography(pairs);
[x, y] = tformfwd(T, 50, 50);
assertElementsAlmostEqual(50, x);
assertElementsAlmostEqual(50, y);


