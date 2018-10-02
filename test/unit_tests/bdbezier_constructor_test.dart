import "../testing_tools/testing_tools.dart";

void main() {
  group("unnamed constructor", () {
    test("quadratic constructor", () {
      final points = [
        new Vector2(40.0, 40.0),
        new Vector2(30.0, 10.0),
        new Vector2(55.0, 25.0)
      ];
      final curve = new QuadraticBezier(points);

      expect(curve, new TypeMatcher<QuadraticBezier>());
      expect(curve.order, equals(2));
      expect(curve.points, hasLength(3));
    });

    test("cubic constructor", () {
      final points = [
        new Vector2(10.0, 10.0),
        new Vector2(70.0, 95.0),
        new Vector2(25.0, 20.0),
        new Vector2(15.0, 80.0)
      ];
      final curve = new CubicBezier(points);

      expect(curve, new TypeMatcher<CubicBezier>());
      expect(curve.order, equals(3));
      expect(curve.points, hasLength(4));
    });
  });

  group("fromPoints constructor", () {
    test("fromPoints, three entries", () {
      final points = <Vector2>[
        new Vector2(0.0, 0.0),
        new Vector2(250.0, -50.0),
        new Vector2(100.0, 80.0)
      ];
      final curve = new Bezier.fromPoints(points);

      expect(curve, new TypeMatcher<QuadraticBezier>());
      expect(curve.order, equals(2));
      expect(curve.points, hasLength(3));
    });

    test("fromPoints, four entries", () {
      final points = <Vector2>[
        new Vector2(0.0, 0.0),
        new Vector2(170.0, 90.0),
        new Vector2(25.0, 20.0),
        new Vector2(100.0, -100.0)
      ];
      final curve = new Bezier.fromPoints(points);

      expect(curve, new TypeMatcher<CubicBezier>());
      expect(curve.order, equals(3));
      expect(curve.points, hasLength(4));
    });

    test("fromPoints, error thrown with five entries", () {
      final points = <Vector2>[
        new Vector2(0.0, 0.0),
        new Vector2(170.0, 90.0),
        new Vector2(25.0, 20.0),
        new Vector2(100.0, -100.0),
        new Vector2(-30.0, 100.0)
      ];
      expect(() => new Bezier.fromPoints(points), throwsA(new TypeMatcher<Error>()));
    });
  });
}
