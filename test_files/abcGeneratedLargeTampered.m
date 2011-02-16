path(path, '../');
photo = single(imread('abc_tampered_large.tiff'));
photo = photo(:, :, 1);
world = single(imread('abc_world_large.tiff'));
world = world(:, :, 1);

detector = SiftDetector(10);
matcher = SiftMatcher(3);
secondMatcher = RansacMatcher(FitnessEvaluator(MatlabHomographyEstimator(), 15), 1000, 15);

authenticityEvaluation;
