classdef SignManipulationsDetector
    properties
        detector;
        matcher;
        secondMatcher;
        duplicateFilter;
        verifier;
        plotter;
        plotStrategy;
        authenticityEvaluator;
    end
    methods
        function obj = SignManipulationsDetector(detector, matcher, secondMatcher, plotStrategy)
            obj.detector = detector;
            obj.matcher = matcher;
            obj.secondMatcher = secondMatcher;
            obj.duplicateFilter = DuplicateFilter(3);
            obj.verifier = KeypointsVerifier();
            obj.plotter = KeypointsPlotter();
            if (nargin > 3) 
                obj.plotStrategy = plotStrategy;
            else
                obj.plotStrategy = 0;
            end
            obj.authenticityEvaluator = AuthenticityEvaluator(ErrorCalculator(), obj.verifier, MatlabHomographyEstimator(), ImageCutter());
        end

        function [photoKeypointsNumber, pairsNumber, rmsMinimum, rmsMedium, rectifiedMinimum] = evaluate(self, photo, world)
            photo_keypoints = self.detector.findKeypoints(photo);
            photoKeypointsNumber = size(photo_keypoints, 1);
            world_keypoints = self.detector.findKeypoints(world);

            pairs = self.matcher.matchKeypoints(photo_keypoints, world_keypoints);
            pairsNumber = size(pairs, 1);
            pairs = self.duplicateFilter.filter(pairs);
            pairsNumber = [pairsNumber; size(pairs, 1)];
            pairs = self.secondMatcher.matchKeypoints(pairs);
            pairsNumber = [pairsNumber; size(pairs, 1)];

            photo_keypoints = self.verifier.getFirstImageKeypoints(pairs);
            if (self.plotStrategy)
                figure;
                imshow(photo);
                self.plotter.plot(photo_keypoints);
            end

            world_keypoints = self.verifier.getSecondImageKeypoints(pairs);
            if (self.plotStrategy)
                figure;
                imshow(world);
                self.plotter.plot(world_keypoints);
            end

            [rmsMinimum, rmsMedium, rectifiedMinimum] = self.authenticityEvaluator.getError(photo, world, pairs, PairsSelector(pairs, 100));
            if (self.plotStrategy)
                figure;
                colormap gray;
                imagesc(rectifiedMinimum);
            end
        end
    end
end
