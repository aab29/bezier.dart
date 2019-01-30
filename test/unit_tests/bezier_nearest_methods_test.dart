import "../testing_tools/testing_tools.dart";

void main() {
  group("indexOfNearestPoint", () {
    test("one point", () {
      final points = [
        new Vector2(80.0, -40.0)
      ];
      
      expect(indexOfNearestPoint(points, new Vector2(-30.0, -30.0)), equals(0));
      expect(indexOfNearestPoint(points, new Vector2(-7500.0, 48000.0)), equals(0));
      expect(indexOfNearestPoint(points, new Vector2(0.0, 0.0)), equals(0));
      expect(indexOfNearestPoint(points, new Vector2(80.0, -40.0)), equals(0));
    });

    test("two points", () {
      final points = [
        new Vector2(-1.0, -1.0),
        new Vector2(1.0, 1.0)
      ];

      expect(indexOfNearestPoint(points, new Vector2(-1.0, -1.0)), equals(0));
      expect(indexOfNearestPoint(points, new Vector2(1.0, 1.0)), equals(1));
      expect(indexOfNearestPoint(points, new Vector2(0.01, 0.01)), equals(1));
      expect(indexOfNearestPoint(points, new Vector2(-0.01, -0.01)), equals(0));
      expect(indexOfNearestPoint(points, new Vector2(500.0, 500.0)), equals(1));
      expect(indexOfNearestPoint(points, new Vector2(-10.0, -10.0)), equals(0));
      expect(indexOfNearestPoint(points, new Vector2(-10.0, 2.0)), equals(0));
      expect(indexOfNearestPoint(points, new Vector2(7.0, -200.0)), equals(0));
    });

    test("distribution a", () {
      final points = [
        new Vector2(500.0, 10.0),
        new Vector2(0.0, 0.0),
        new Vector2(-400.0, -20.0),
        new Vector2(5.0, 5.0),
        new Vector2(150.0, -350.0)
      ];

      expect(indexOfNearestPoint(points, new Vector2(10.0, 10.0)), equals(3));
      expect(indexOfNearestPoint(points, new Vector2(500.0, 10.0)), equals(0));
      expect(indexOfNearestPoint(points, new Vector2(495.0, 15.0)), equals(0));
      expect(indexOfNearestPoint(points, new Vector2(0.0, 0.0)), equals(1));
      expect(indexOfNearestPoint(points, new Vector2(-1.0, 0.0)), equals(1));
      expect(indexOfNearestPoint(points, new Vector2(1.0, 0.5)), equals(1));
      expect(indexOfNearestPoint(points, new Vector2(-400.0, -20.0)), equals(2));
      expect(indexOfNearestPoint(points, new Vector2(-5000.0, -20.0)), equals(2));
      expect(indexOfNearestPoint(points, new Vector2(-400.0, -17.0)), equals(2));
      expect(indexOfNearestPoint(points, new Vector2(5.0, 5.0)), equals(3));
      expect(indexOfNearestPoint(points, new Vector2(4.0, 4.0)), equals(3));
      expect(indexOfNearestPoint(points, new Vector2(10.0, 10.0)), equals(3));
      expect(indexOfNearestPoint(points, new Vector2(150.0, -350.0)), equals(4));
      expect(indexOfNearestPoint(points, new Vector2(140.0, -340.0)), equals(4));
      expect(indexOfNearestPoint(points, new Vector2(150.0, -9900.0)), equals(4));
      expect(indexOfNearestPoint(points, new Vector2(90.0, 250.0)), equals(3));
      expect(indexOfNearestPoint(points, new Vector2(0.0, 125.0)), equals(3));
      expect(indexOfNearestPoint(points, new Vector2(0.0, -125.0)), equals(1));
      expect(indexOfNearestPoint(points, new Vector2(200.0, 0.0)), equals(3));
      expect(indexOfNearestPoint(points, new Vector2(-100.0, 0.0)), equals(1));
    });

    test("from a look-up table", () {
      final curve = new CubicBezier([
        new Vector2(-100.0, 25.0),
        new Vector2(-65.0, -110.0),
        new Vector2(0.0, 20.0),
        new Vector2(95.0, -100.0)
      ]);

      final points = curve.positionLookUpTable(intervalsCount: 200);

      expect(indexOfNearestPoint(points, new Vector2(0.0, 0.0)), equals(122));
      expect(indexOfNearestPoint(points, new Vector2(800.0, 800.0)), equals(180));
      expect(indexOfNearestPoint(points, new Vector2(-1000.0, 1000.0)), equals(0));
      expect(indexOfNearestPoint(points, new Vector2(0.0, 100.0)), equals(0));
      expect(indexOfNearestPoint(points, new Vector2(-100.0, 0.0)), equals(13));
      expect(indexOfNearestPoint(points, new Vector2(100.0, 0.0)), equals(172));
      expect(indexOfNearestPoint(points, new Vector2(-40.0, -10.0)), equals(81));
      expect(indexOfNearestPoint(points, new Vector2(-100.0, 25.0)), equals(0));
      expect(indexOfNearestPoint(points, new Vector2(95.0, -100.0)), equals(200));
      expect(indexOfNearestPoint(points, new Vector2(95.0, -190.0)), equals(200));
    });
  });

  group("nearestTValue", () {
    test("quadratic", () {
      final curve = new QuadraticBezier([
        new Vector2(90.0, 0.0),
        new Vector2(-10.0, -50.0),
        new Vector2(-45.0, 45.0)
      ]);
      
      expect(curve.nearestTValue(new Vector2(90.0, 0.0)), equals(0.0));
      expect(curve.nearestTValue(new Vector2(-45.0, 45.0)), equals(1.0));
      expect(curve.nearestTValue(new Vector2(-10.0, -50.0)), closeToDouble(0.518));
      expect(curve.nearestTValue(new Vector2(91.0, 5.0)), equals(0.0));
      expect(curve.nearestTValue(new Vector2(-48.0, 48.0)), equals(1.0));
      expect(curve.nearestTValue(new Vector2(0.0, 0.0)), closeToDouble(0.586));
      expect(curve.nearestTValue(curve.pointAt(0.034)), closeToDouble(0.034));
      expect(curve.nearestTValue(curve.pointAt(0.5)), closeToDouble(0.5));
      expect(curve.nearestTValue(curve.pointAt(0.666)), closeToDouble(0.666));
      expect(curve.nearestTValue(curve.pointAt(0.75)), closeToDouble(0.75));
      expect(curve.nearestTValue(curve.pointAt(0.77)), closeToDouble(0.77));
      expect(curve.nearestTValue(curve.pointAt(0.99)), closeToDouble(0.99));
    });
  });
}
