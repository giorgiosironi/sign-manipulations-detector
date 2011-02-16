classdef FitnessEvaluator
    properties
        estimator;
        tolerance;
    end
    methods
        function obj = FitnessEvaluator(estimator, tolerance)
            obj.estimator = estimator;
            obj.tolerance = tolerance;
        end
        function [inliers, T] = getInliers(self, chromosome)
            sampleSet = chromosome(1:4);
            if (self.testCollinearityForPartsOfPairs(sampleSet))
                inliers = cell(0);
                return;
            end
            consensusSet = chromosome(5:end);
            T = self.estimator.getHomography(sampleSet);
            if (isfloat(T) && T == 0)
                inliers = cell(0);
                return;
            end
            inliers = cell(0);
            for i=1:size(consensusSet, 1)
                consensusPair = consensusSet{i};
                if (self.scorePerfectMatch(consensusPair, T))
                    inliers = [inliers; {consensusPair}];
                end
            end
        end

        function b = testCollinearityForPartsOfPairs(self, somePairs)
            firstPoints = {};
            secondPoints = {};
            length = size(somePairs, 1);
            for i=1:length
                firstPoints = [firstPoints; {somePairs{i}.first}];
                secondPoints = [secondPoints; {somePairs{i}.second}];
            end
            b = self.testCollinearity(firstPoints) || self.testCollinearity(secondPoints);
        end

        function b = testCollinearity(self, points)
            b = 0;
            length = size(points, 1);
            for i=1:length
                for j=i+1:length
                    for k=j+1:length
                        if (points{i}.isCollinearWith(points{j}, points{k}, self.tolerance)) 
                            b = 1;
                            return
                        end
                    end
                end
            end
        end

        function inlier = scorePerfectMatch(self, pair, T)
            transformated = tformfwd(T, pair.first.y, pair.first.x); 
            distance = norm(transformated - [pair.second.y pair.second.x]);
            if (distance < self.tolerance)
                inlier = 1;
            else
                inlier = 0;
            end
        end

    end
end


