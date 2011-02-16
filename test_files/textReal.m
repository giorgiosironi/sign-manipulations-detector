path(path, '../');
photo = rgb2gray(imread('text_real.jpg'));
photo = single(im2bw(photo, 0.12) * 255);
world = single(rgb2gray(imread('text_world.png')));

detector = SiftDetector(10);
matcher = SiftMatcher(1.5);
secondMatcher = RansacMatcher(FitnessEvaluator(MatlabHomographyEstimator(), 15), 1000, 15);

authenticityEvaluation;

