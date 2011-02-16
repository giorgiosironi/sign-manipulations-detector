path(path, '../');
photo = rgb2gray(imread('sans_tampered.png'));
photo = single(im2bw(photo, 0.1) * 255);
world = single(rgb2gray(imread('sans_world.png')));

detector = SiftDetector(10);
matcher = SiftMatcher(1.5);
secondMatcher = RansacMatcher(FitnessEvaluator(MatlabHomographyEstimator(), 5), 1000, 15);

authenticityEvaluation;

