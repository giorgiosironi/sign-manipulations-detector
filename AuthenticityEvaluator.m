classdef AuthenticityEvaluator
    properties
        errorCalculator;
        verifier;
        estimator;
        imageCutter;
    end
    methods
        function obj = AuthenticityEvaluator(errorCalculator, verifier, estimator, imageCutter)
            obj.errorCalculator = errorCalculator;
            obj.verifier = verifier;
            obj.estimator = estimator;
            obj.imageCutter = imageCutter;
        end
        function [rmsMinimum, rmsMedium, rectifiedMinimum, T] = getError(self, photo, world, pairs, pairsSelector)
            world_keypoints = self.verifier.getSecondImageKeypoints(pairs);
            %worldCut = self.imageCutter.cut(world, world_keypoints);
            worldCut = world;

            rmsMinimum = 1000000;
            rmsMedium = 0;
            rmsCount = 0;
            rectifiedMinimum = [];
            subsets = pairsSelector.getSubsets(4);
            for i=1:size(subsets, 1)
                try
                    T = self.estimator.getHomography(subsets{i});
                catch ME
                    continue;
                end
                rectified = imtransform(photo, T, 'XData', [1 size(world, 2)], 'YData', [1 size(world, 1)], 'FillValues', 255);
                %rectifiedCut = self.imageCutter.cut(rectified, world_keypoints);
                rectifiedCut = rectified;
                rms = self.errorCalculator.getRMS(rectifiedCut, worldCut);
                if (rms < rmsMinimum)
                    rmsMinimum = rms;
                    rectifiedMinimum = rectifiedCut;
                end
                rmsMedium = rmsMedium + rms;
                rmsCount = rmsCount + 1;
            end
            rmsMedium = rmsMedium / rmsCount;
        end
    end
end
