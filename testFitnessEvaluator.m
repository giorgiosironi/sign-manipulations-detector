function test_suite = testFitnessEvaluator
initTestSuite;

function testFitnessOfPerfectlyMatchedPointsIsHigh
first_image = generateFixtureImage();
second_image = generateAffinelyTransformedFixtureImage();
chromosome = buildChromosome(first_image, second_image);
evaluator = FitnessEvaluator(MatlabHomographyEstimator(), 10);
assertEqual([4 1], size(evaluator.getInliers(chromosome)));

function testFitnessOfNotMatchedPointsIsLow
first_image = generateFixtureImage();
second_image = generateFixtureImage();
second_image = flipud(second_image());
chromosome = buildChromosome(first_image, second_image);
evaluator = FitnessEvaluator(MatlabHomographyEstimator(), 10);
assertEqual([0 0], size(evaluator.getInliers(chromosome)));

function testFitnessOfPairsWithCollinearPointsIsVeryLow
image = cell(5, 1);
image{1} = Keypoint(0, 0);
image{2} = Keypoint(100, 100);
image{3} = Keypoint(200, 200);
image{4} = Keypoint(100, 500);
image{5} = Keypoint(800, 700);
second_image = generateFixtureImage();
second_image = second_image(1:5);
chromosome = buildChromosome(image, second_image);
evaluator = FitnessEvaluator(MatlabHomographyEstimator(), 10);
assertEqual([0 0], size(evaluator.getInliers(chromosome)));

function c = buildChromosome(first_image, second_image)
N = size(first_image, 1);
c = cell(N, 1);
for i=1:N
    c{i} = KeypointsPair(first_image{i}, second_image{i});
end

function image = generateFixtureImage
image = cell(8, 1);
image{1} = Keypoint(0, 0);
image{2} = Keypoint(100, 0);
image{3} = Keypoint(0, 100);
image{4} = Keypoint(100, 100);
image{5} = Keypoint(700, 700);
image{6} = Keypoint(150, 150);
image{7} = Keypoint(400, 0);
image{8} = Keypoint(0, 200);

function image = generateAffinelyTransformedFixtureImage()
image = generateFixtureImage();
for i=1:size(image, 1)
    image{i} = Keypoint(image{i}.x * 2, image{i}.y * 4);
end
