function test_suite = testKeypointsPair
initTestSuite;

function testConstructorAcceptsTwoKeypoints
first = Keypoint(1, 2);
second = Keypoint(1, 2);
pair = KeypointsPair(first, second);

function testCalculatesCostMatrix
first = Keypoint(1, 2);
second = Keypoint(3, 4);
pair = KeypointsPair(first, second);
costMatrix = pair.getCostMatrix();
assertEqual([2 9], size(costMatrix.A));
expected = [0 0 0, -1 -2 -1, 4 8 4; 1 2 1, 0 0 0, -3 -6 -3];
assertEqual(expected, costMatrix.A);


