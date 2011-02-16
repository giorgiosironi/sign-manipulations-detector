function test_suite = testRansacMatcher
initTestSuite;

function testMatchesPointsThatSatisfyAnHomographyExcludingOutliers
first_image = generateFixtureImage();
second_image = generateFixtureImage();
% 10 of distance from the real point
pairs = buildPairs(first_image, second_image);
initializations = 10;

for j=1:initializations
    matcher = RansacMatcher(FitnessEvaluator(MatlabHomographyEstimator(), 5), 100, 3);

    pairs = matcher.matchKeypoints(pairs);
    assertEqual([8 1], size(pairs));
    for i=1:4
        assertEqual(pairs{i}.second.x, pairs{i}.first.x);
        assertEqual(pairs{i}.second.y, pairs{i}.first.y);
    end
end

function image = generateFixtureImage
image = cell(8, 1);
image{1} = Keypoint(0, 0);
image{2} = Keypoint(100, 0);
image{3} = Keypoint(0, 100);
image{4} = Keypoint(100, 100);
image{5} = Keypoint(50, 150);
image{6} = Keypoint(150, 50);
image{7} = Keypoint(50, 400);
image{8} = Keypoint(200, 50);

function pairs = buildPairs(first_image, second_image)
N = size(first_image, 1);
pairs = cell(N, 1);
for i=1:N
    pairs{i} = KeypointsPair(first_image{i}, second_image{i});
end


