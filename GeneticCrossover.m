classdef GeneticCrossover
    properties
        fixed = 4;
    end
    methods
        function chromosome = cross(self, a, b)
            length = size(a, 1);
            singlePoint = randsample(length-self.fixed, 1) + self.fixed;
            chromosome = cell(0);
            for k=1:singlePoint
                chromosome = [chromosome; a(k)];
            end
            firstToInsert = cell(0);
            secondToInsert = cell(0);
            for k=1:length
                if (~self.alreadyInChromosomeAsFirst(chromosome(1:singlePoint), b{k}.first))
                    firstToInsert = [firstToInsert; {b{k}.first}];
                end
                if (~self.alreadyInChromosomeAsSecond(chromosome(1:singlePoint), b{k}.second))
                    secondToInsert = [secondToInsert; {b{k}.second}];
                end
            end
            for k=1:length-singlePoint
                chromosome{singlePoint+k} = KeypointsPair(firstToInsert{k}, secondToInsert{k});
            end
        end

        function b = alreadyInChromosomeAsFirst(self, chromosome, keypoint)
            b = 0;
            for k=1:size(chromosome, 1)
                if (chromosome{k}.first == keypoint)
                    b = 1;
                end
            end
        end

        function b = alreadyInChromosomeAsSecond(self, chromosome, keypoint)
            b = 0;
            for k=1:size(chromosome, 1)
                if (chromosome{k}.second == keypoint)
                    b = 1;
                end
            end
        end
    end
end
