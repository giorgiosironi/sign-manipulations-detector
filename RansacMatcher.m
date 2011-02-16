classdef RansacMatcher
    properties
        evaluator;
        limit;
        minimumScoreRequired;
    end
    methods
        function obj = RansacMatcher(evaluator, limit, minimumScoreRequired)
            obj.evaluator = evaluator;
            obj.limit = limit;
            obj.minimumScoreRequired = minimumScoreRequired;
        end
        function maximumSolution = matchKeypoints(self, pairs)
            if (size(pairs, 1) < 4)
                error('There are not enough keypoint pairs for matching.');
            end
            maximumScore = 0;
            maximumSolution = cell(0);
            for i=1:self.limit
                candidate = self.randomPair(pairs);
                inliers = self.evaluator.getInliers(candidate);
                score = size(inliers, 1);
                if (score > maximumScore)
                    maximumSolution = [candidate(1:4); inliers];
                    maximumScore = score;
                    if (maximumScore >= self.minimumScoreRequired)
                        break;
                    end
                end
            end
        end
        function pairs = randomPair(self, pairs)
            total = size(pairs, 1);
            indexes = randperm(total);
            pairs = pairs(indexes);
        end
    end
end
