path(path, '../');
photo = rgb2gray(imread('abc_real.jpg'));
photo = single(im2bw(photo, 0.15) * 255);
world = single(imread('abc_world_small.tiff'));
world = world(:, :, 1);

detector = SiftDetector(10);
matcher = SiftMatcher(1.5);
secondMatcher = RansacMatcher(FitnessEvaluator(MatlabHomographyEstimator(), 15), 1000, 15);

authenticityEvaluation;

