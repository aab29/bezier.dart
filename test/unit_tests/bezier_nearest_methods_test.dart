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
  });
}
