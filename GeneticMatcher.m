classdef GeneticMatcher
    properties
        evaluator;
        crossover;
        mutator;
        limit;
        population;
        elitism = 1;
    end
    methods
        function obj = GeneticMatcher(evaluator, crossover, mutator, limit, population)
            obj.evaluator = evaluator;
            obj.crossover = crossover;
            obj.mutator = mutator;
            obj.limit = limit;
            obj.population = population;
        end
        function pairs = matchKeypoints(self, first_image, second_image)
            chromosomes = cell(self.population, 1);
            for j=1:self.population
                chromosomes{j} = self.getRandomChromosome(first_image, second_image);
            end
%            chromosomes{4} = self.buildPairs(first_image, second_image);
            for i=1:self.limit
                fitness = [];
                for j=1:self.population
                    fitness = [fitness; self.evaluator.getFitness(chromosomes{j})];
                end
                [fitness, indexes] = sort(fitness, 1, 'descend');
                fitness(1:5)
                if (fitness(1) == (size(first_image, 1) - 4) * 2)
                    break;
                end
                chromosomes = chromosomes(indexes);
                new_chromosomes = cell(self.population, 1);
                for j=1:self.elitism
                    new_chromosomes{j} = chromosomes{j};
                end

                for j=self.elitism+1:self.population
                    new_chromosomes{j} = self.crossover.cross(self.rouletteWheel(chromosomes, fitness), self.rouletteWheel(chromosomes, fitness));
                    if (fitness(1) == 0) 
                        new_chromosomes{j} = self.mutator.mutate(new_chromosomes{j});
                    end
                end
                chromosomes = new_chromosomes;
            end
            i
            pairs = chromosomes{1};
        end
        
        function chromosome = getRandomChromosome(self, first_image, second_image)
            first_image = self.randomize(first_image);
            second_image = self.randomize(second_image);
            chromosome = self.buildPairs(first_image, second_image);
        end

        function pairs = buildPairs(self, first_image, second_image)
            firstN = size(first_image, 1);
            secondN = size(second_image, 1);
            maxN = min(firstN, secondN);
            pairs = cell(0);
            for i=1:maxN
                result = cell(1); 
                result{1} = KeypointsPair(first_image{i}, second_image{i});
                pairs = [pairs; result];
            end
        end

        function points = randomize(self, points)
            total = size(points, 1);
            indexes = randperm(total);
            points = points(indexes);
        end

        function chromosome = rouletteWheel(self, chromosomes, fitness)
            % http://www.mathworks.com/matlabcentral/newsreader/view_thread/255206
            p = fitness'/sum(fitness);
            e = min([0 cumsum(p)],1);
            e(end) = 1;
            p = diff(e);

            selected = randsample(self.population, 1, true, p);
            chromosome = chromosomes{selected};
        end

    end
end
