path(path, '../');
photo = rgb2gray(imread('sign_tampered.jpg'));
photo = single(im2bw(photo, 0.25) * 255);
world = single(rgb2gray(imread('sign_world.png')));

detector = SiftDetector(10);
matcher = SiftMatcher(1.5);
secondMatcher = RansacMatcher(FitnessEvaluator(MatlabHomographyEstimator(), 15), 1000, 15);

authenticityEvaluation;


