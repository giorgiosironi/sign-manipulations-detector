function test_suite = testKeypointsPair
initTestSuite;

function testPicksAKeypointInTheOriginalList
pairsSet = cell(1);
pairsSet{1} = 42;
selector = PairsSelector(pairsSet, 1);
subsets = selector.getSubsets(1);
assertEqual(pairsSet, subsets{1});

function testPicksARandomSubsetFromTheList
pairsSet = cell(4, 1);
pairsSet{1} = 15;
pairsSet{2} = 30;
pairsSet{3} = 45;
pairsSet{4} = 60;
selector = PairsSelector(pairsSet, 1);
result = selector.getSubsets(2);
assertEqual([2 1], size(result{1}));
% does Matlab have something like in_array($value, $array)?
firstSubset = result{1};
assertEqual(mod(firstSubset{1}, 15), 0);
assertEqual(mod(firstSubset{2}, 15), 0);

function testPicksNSubsetsFromTheList
pairsSet = cell(1);
pairsSet{1} = 42;
selector = PairsSelector(pairsSet, 10);
result = selector.getSubsets(1);
assertEqual([10 1], size(result));
for i=1:10
    subset = result{i};
    assertEqual(42, subset{1});
end

