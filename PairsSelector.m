classdef PairsSelector
    properties
        points;
        subsetsNumber;
    end
    methods
        function obj = PairsSelector(wholeSet, subsetsNumber)
            obj.points = wholeSet;
            obj.subsetsNumber = subsetsNumber;
        end
        function subsets = getSubsets(self, elementsNumber)
            subsets = cell(self.subsetsNumber, 1);
            for i=1:self.subsetsNumber
                total = size(self.points, 1);
                indexes = randperm(total);
                selectedIndexes = indexes(1:elementsNumber);
                subsets{i} = self.points(selectedIndexes, :);
            end
        end
    end
end
