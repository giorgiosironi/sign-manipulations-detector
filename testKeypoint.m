function test_suite = testKeypoint
initTestSuite;

function testConstructorAcceptsAllParameters
keypoint = Keypoint(1, 2, 3, 4, [6; 7; 8]);
assertEqual(1, keypoint.x);
assertEqual(2, keypoint.y);
assertEqual(3, keypoint.scale);
assertEqual(4, keypoint.orientation);
assertEqual(4, keypoint.orientation);
assertEqual([6; 7; 8], keypoint.descriptor);

function testConstructorAcceptsAlsoOnlyXAndY
keypoint = Keypoint(1, 2);
assertEqual(1, keypoint.x);
assertEqual(2, keypoint.y);

function testPropertiesAreNotModifiable
assertExceptionThrown(@propertiesAreNotModifiable, 'MATLAB:class:SetProhibited');

function propertiesAreNotModifiable()
keypoint = Keypoint(1, 2, 3, 4, []);
keypoint.x = 3;

function testDiscoversCollinearity
keypoint = Keypoint(1, 1);
b = Keypoint(2, 2);
c = Keypoint(3, 3);
assertTrue(keypoint.isCollinearWith(b, c));
assertFalse(keypoint.isCollinearWith(b, Keypoint(40, 50)));
assertFalse(keypoint.isCollinearWith(b, Keypoint(-20, -40)));
assertTrue(keypoint.isCollinearWith(b, Keypoint(3.1, 3), 1));
assertFalse(keypoint.isCollinearWith(b, Keypoint(4.1, 3), 1));

function testCalculatesDistance
a = Keypoint(1, 1);
b = Keypoint(2, 2);
assertElementsAlmostEqual(sqrt(2), a.distanceFrom(b));
