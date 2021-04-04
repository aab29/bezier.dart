import '../testing_tools/testing_tools.dart';

void main() {
  group('indexOfNearestPoint', () {
    test('one point', () {
      final points = [Vector2(80.0, -40.0)];

      expect(indexOfNearestPoint(points, Vector2(-30.0, -30.0)), equals(0));
      expect(indexOfNearestPoint(points, Vector2(-7500.0, 48000.0)), equals(0));
      expect(indexOfNearestPoint(points, Vector2(0.0, 0.0)), equals(0));
      expect(indexOfNearestPoint(points, Vector2(80.0, -40.0)), equals(0));
    });

    test('two points', () {
      final points = [Vector2(-1.0, -1.0), Vector2(1.0, 1.0)];

      expect(indexOfNearestPoint(points, Vector2(-1.0, -1.0)), equals(0));
      expect(indexOfNearestPoint(points, Vector2(1.0, 1.0)), equals(1));
      expect(indexOfNearestPoint(points, Vector2(0.01, 0.01)), equals(1));
      expect(indexOfNearestPoint(points, Vector2(-0.01, -0.01)), equals(0));
      expect(indexOfNearestPoint(points, Vector2(500.0, 500.0)), equals(1));
      expect(indexOfNearestPoint(points, Vector2(-10.0, -10.0)), equals(0));
      expect(indexOfNearestPoint(points, Vector2(-10.0, 2.0)), equals(0));
      expect(indexOfNearestPoint(points, Vector2(7.0, -200.0)), equals(0));
    });

    test('equidistant solutions prefers earlier element', () {
      final points = [Vector2(-100.0, 0.0), Vector2(100.0, 0.0)];

      expect(indexOfNearestPoint(points, Vector2(0.0, 0.0)), equals(0));
    });

    test('empty list throws error', () {
      final points = <Vector2>[];

      expect(() => indexOfNearestPoint(points, Vector2(5.0, 5.0)), throwsArgumentError);
    });

    test('distribution a', () {
      final points = [
        Vector2(500.0, 10.0),
        Vector2(0.0, 0.0),
        Vector2(-400.0, -20.0),
        Vector2(5.0, 5.0),
        Vector2(150.0, -350.0)
      ];

      expect(indexOfNearestPoint(points, Vector2(10.0, 10.0)), equals(3));
      expect(indexOfNearestPoint(points, Vector2(500.0, 10.0)), equals(0));
      expect(indexOfNearestPoint(points, Vector2(495.0, 15.0)), equals(0));
      expect(indexOfNearestPoint(points, Vector2(0.0, 0.0)), equals(1));
      expect(indexOfNearestPoint(points, Vector2(-1.0, 0.0)), equals(1));
      expect(indexOfNearestPoint(points, Vector2(1.0, 0.5)), equals(1));
      expect(indexOfNearestPoint(points, Vector2(-400.0, -20.0)), equals(2));
      expect(indexOfNearestPoint(points, Vector2(-5000.0, -20.0)), equals(2));
      expect(indexOfNearestPoint(points, Vector2(-400.0, -17.0)), equals(2));
      expect(indexOfNearestPoint(points, Vector2(5.0, 5.0)), equals(3));
      expect(indexOfNearestPoint(points, Vector2(4.0, 4.0)), equals(3));
      expect(indexOfNearestPoint(points, Vector2(10.0, 10.0)), equals(3));
      expect(indexOfNearestPoint(points, Vector2(150.0, -350.0)), equals(4));
      expect(indexOfNearestPoint(points, Vector2(140.0, -340.0)), equals(4));
      expect(indexOfNearestPoint(points, Vector2(150.0, -9900.0)), equals(4));
      expect(indexOfNearestPoint(points, Vector2(90.0, 250.0)), equals(3));
      expect(indexOfNearestPoint(points, Vector2(0.0, 125.0)), equals(3));
      expect(indexOfNearestPoint(points, Vector2(0.0, -125.0)), equals(1));
      expect(indexOfNearestPoint(points, Vector2(200.0, 0.0)), equals(3));
      expect(indexOfNearestPoint(points, Vector2(-100.0, 0.0)), equals(1));
    });

    test('from a look-up table', () {
      final curve = CubicBezier([
        Vector2(-100.0, 25.0),
        Vector2(-65.0, -110.0),
        Vector2(0.0, 20.0),
        Vector2(95.0, -100.0)
      ]);

      final points = curve.positionLookUpTable(intervalsCount: 200);

      expect(indexOfNearestPoint(points, Vector2(0.0, 0.0)), equals(122));
      expect(indexOfNearestPoint(points, Vector2(800.0, 800.0)), equals(180));
      expect(indexOfNearestPoint(points, Vector2(-1000.0, 1000.0)), equals(0));
      expect(indexOfNearestPoint(points, Vector2(0.0, 100.0)), equals(0));
      expect(indexOfNearestPoint(points, Vector2(-100.0, 0.0)), equals(13));
      expect(indexOfNearestPoint(points, Vector2(100.0, 0.0)), equals(172));
      expect(indexOfNearestPoint(points, Vector2(-40.0, -10.0)), equals(81));
      expect(indexOfNearestPoint(points, Vector2(-100.0, 25.0)), equals(0));
      expect(indexOfNearestPoint(points, Vector2(95.0, -100.0)), equals(200));
      expect(indexOfNearestPoint(points, Vector2(95.0, -190.0)), equals(200));
    });
  });

  group('nearestTValue', () {
    test('quadratic', () {
      final curve = QuadraticBezier(
          [Vector2(90.0, 0.0), Vector2(-10.0, -50.0), Vector2(-45.0, 45.0)]);

      expect(curve.nearestTValue(Vector2(90.0, 0.0)), equals(0.0));
      expect(curve.nearestTValue(Vector2(-45.0, 45.0)), equals(1.0));
      expect(curve.nearestTValue(Vector2(-10.0, -50.0)), closeToDouble(0.518));
      expect(curve.nearestTValue(Vector2(91.0, 5.0)), equals(0.0));
      expect(curve.nearestTValue(Vector2(-48.0, 48.0)), equals(1.0));
      expect(curve.nearestTValue(Vector2(0.0, 0.0)), closeToDouble(0.586));
      expect(curve.nearestTValue(Vector2(35.0, -20.0)), closeToDouble(0.306));
      expect(curve.nearestTValue(Vector2(-45.0, 10.0)), closeToDouble(0.84));
      expect(curve.nearestTValue(curve.pointAt(0.034)), closeToDouble(0.034));
      expect(curve.nearestTValue(curve.pointAt(0.5)), closeToDouble(0.5));
      expect(curve.nearestTValue(curve.pointAt(0.666)), closeToDouble(0.666));
      expect(curve.nearestTValue(curve.pointAt(0.75)), closeToDouble(0.75));
      expect(curve.nearestTValue(curve.pointAt(0.77)), closeToDouble(0.77));
      expect(curve.nearestTValue(curve.pointAt(0.99)), closeToDouble(0.99));

      final lookUpTable = curve.positionLookUpTable(intervalsCount: 300);

      expect(
          curve.nearestTValue(Vector2(91.0, 5.0),
              cachedPositionLookUpTable: lookUpTable),
          equals(0.0));
      expect(
          curve.nearestTValue(Vector2(-48.0, 48.0),
              cachedPositionLookUpTable: lookUpTable),
          equals(1.0));
      expect(
          curve.nearestTValue(Vector2(0.0, 0.0),
              cachedPositionLookUpTable: lookUpTable),
          closeToDouble(0.58666666666));
      expect(
          curve.nearestTValue(Vector2(24.0, 42.0),
              cachedPositionLookUpTable: lookUpTable),
          closeToDouble(0.57233333333));

      expect(
          curve.nearestTValue(Vector2(0.0, 0.0),
              cachedPositionLookUpTable: lookUpTable, stepSize: 0.4),
          closeToDouble(0.58733333333));
      expect(
          curve.nearestTValue(Vector2(0.0, 0.0),
              cachedPositionLookUpTable: lookUpTable, stepSize: 0.01),
          closeToDouble(0.5866999999999));
      expect(curve.nearestTValue(Vector2(0.0, 0.0), stepSize: 0.01),
          closeToDouble(0.586599999999));
    });

    test('quadratic, equidistant solutions prefers earlier t value', () {
      final curve = QuadraticBezier([
        Vector2(-1.0, 0.0),
        Vector2(0.0, 100.0),
        Vector2(1.0, 0.0),
      ]);

      expect(curve.nearestTValue(Vector2(0.0, 0.0)), equals(0.0));
      expect(curve.nearestTValue(Vector2(0.0, 20.0)), closeToDouble(0.112));
    });

    test('cubic', () {
      final curve = CubicBezier([
        Vector2(-100.0, -100.0),
        Vector2(-80.0, 50.0),
        Vector2(70.0, -50.0),
        Vector2(100.0, 100.0)
      ]);

      expect(curve.nearestTValue(Vector2(-100.0, -100.0)), equals(0.0));
      expect(curve.nearestTValue(Vector2(100.0, 100.0)), equals(1.0));
      expect(curve.nearestTValue(Vector2(-80.0, 50.0)), closeToDouble(0.328));
      expect(curve.nearestTValue(Vector2(70.0, -50.0)), closeToDouble(0.666));
      expect(curve.nearestTValue(Vector2(-110.0, -110.0)), equals(0.0));
      expect(curve.nearestTValue(Vector2(150.0, 190.0)), equals(1.0));
      expect(curve.nearestTValue(Vector2(0.0, 0.0)), closeToDouble(0.514));
      expect(curve.nearestTValue(Vector2(17.0, -80.0)), closeToDouble(0.492));
      expect(curve.nearestTValue(Vector2(-55.0, -55.0)), closeToDouble(0.192));
      expect(curve.nearestTValue(Vector2(25.0, -90.0)), closeToDouble(0.51));
      expect(curve.nearestTValue(curve.pointAt(0.01)), closeToDouble(0.01));
      expect(curve.nearestTValue(curve.pointAt(0.11)), closeToDouble(0.11));
      expect(curve.nearestTValue(curve.pointAt(0.34)), closeToDouble(0.34));
      expect(curve.nearestTValue(curve.pointAt(0.5)), closeToDouble(0.5));
      expect(curve.nearestTValue(curve.pointAt(0.55)), closeToDouble(0.55));
      expect(curve.nearestTValue(curve.pointAt(0.83)), closeToDouble(0.83));
      expect(curve.nearestTValue(curve.pointAt(0.99)), closeToDouble(0.99));

      final lookUpTable = curve.positionLookUpTable(intervalsCount: 10);

      expect(
          curve.nearestTValue(Vector2(-110.0, -110.0),
              cachedPositionLookUpTable: lookUpTable),
          equals(0.0));
      expect(
          curve.nearestTValue(Vector2(150.0, 190.0),
              cachedPositionLookUpTable: lookUpTable),
          equals(1.0));
      expect(
          curve.nearestTValue(Vector2(0.0, 0.0),
              cachedPositionLookUpTable: lookUpTable),
          closeToDouble(0.51));
      expect(
          curve.nearestTValue(Vector2(40.0, -40.0),
              cachedPositionLookUpTable: lookUpTable),
          closeToDouble(0.6));

      expect(
          curve.nearestTValue(Vector2(40.0, -40.0),
              cachedPositionLookUpTable: lookUpTable, stepSize: 0.4),
          closeToDouble(0.62));
      expect(
          curve.nearestTValue(Vector2(40.0, -40.0),
              cachedPositionLookUpTable: lookUpTable, stepSize: 0.01),
          closeToDouble(0.602));
      expect(curve.nearestTValue(Vector2(40.0, -40.0), stepSize: 0.01),
          closeToDouble(0.6024));
    });
  });
}
