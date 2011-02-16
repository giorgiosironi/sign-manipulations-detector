function test_suite = testGeneticMatcher
initTestSuite;

function testMatchesPointsThatSatisfyAnHomographyIgnoringDescriptors
first_image = generateFixtureImage();
second_image = generateFixtureImage();

detector = GeneticMatcher(FitnessEvaluator(HomographyEstimator(), 5), GeneticCrossover(), GeneticMutator(0.01), 1000, 1000);

pairs = detector.matchKeypoints(first_image, second_image);
for i=1:size(pairs, 1)
%    pairs{i}.first
%    pairs{i}.second
    assertEqual(pairs{i}.second.x, pairs{i}.first.x);
    assertEqual(pairs{i}.second.y, pairs{i}.first.y);
end

function image = generateFixtureImage
image = cell(8, 1);
image{1} = Keypoint(0, 0);
image{2} = Keypoint(100, 0);
image{3} = Keypoint(0, 100);
image{4} = Keypoint(100, 100);
image{5} = Keypoint(600, 700);
image{6} = Keypoint(450, 150);
image{7} = Keypoint(400, 50);
image{8} = Keypoint(50, 200);
