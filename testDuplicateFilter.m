function test_suite = testDuplicateFilter
initTestSuite;

function testFilterOutsPairsWhichAreIdenticalInPositionApartFromATolerance
pairs = {KeypointsPair(Keypoint(10, 20), Keypoint(30, 40))};
pairs = [pairs; {KeypointsPair(Keypoint(10, 20), Keypoint(30, 40))}];
filter = DuplicateFilter(0.1);
pairs = filter.filter(pairs);
assertEqual([1 1], size(pairs));
assertEqual(10, pairs{1}.first.x);

