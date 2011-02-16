classdef HomographyEstimator
    methods
        function obj = HomographyEstimator
        end
        function T = getHomography(self, pairs)
            costMatrix = CostMatrix([]);
            for i=1:size(pairs, 1)
                costMatrix = costMatrix.combineWith(pairs{i}.getCostMatrix());
            end
            h = costMatrix.getMinimumVector();
            A = [h(1:3)'; h(4:6)'; h(7:9)']';
            if (cond(A) > 1000000) 
                T = 0;
                return;
            end
            T = maketform('projective', A);
        end
    end
end
