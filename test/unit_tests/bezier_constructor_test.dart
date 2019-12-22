import '../testing_tools/testing_tools.dart';

void main() {
  group('unnamed constructor', () {
    test('quadratic constructor', () {
      final points = [
        Vector2(40.0, 40.0),
        Vector2(30.0, 10.0),
        Vector2(55.0, 25.0)
      ];
      final curve = QuadraticBezier(points);

      expect(curve, TypeMatcher<QuadraticBezier>());
      expect(curve.order, equals(2));
      expect(curve.points, hasLength(3));
    });

    test('cubic constructor', () {
      final points = [
        Vector2(10.0, 10.0),
        Vector2(70.0, 95.0),
        Vector2(25.0, 20.0),
        Vector2(15.0, 80.0)
      ];
      final curve = CubicBezier(points);

      expect(curve, TypeMatcher<CubicBezier>());
      expect(curve.order, equals(3));
      expect(curve.points, hasLength(4));
    });
  });

  group('fromPoints constructor', () {
    test('fromPoints, three entries', () {
      final points = <Vector2>[
        Vector2(0.0, 0.0),
        Vector2(250.0, -50.0),
        Vector2(100.0, 80.0)
      ];
      final curve = Bezier.fromPoints(points);

      expect(curve, TypeMatcher<QuadraticBezier>());
      expect(curve.order, equals(2));
      expect(curve.points, hasLength(3));
    });

    test('fromPoints, four entries', () {
      final points = <Vector2>[
        Vector2(0.0, 0.0),
        Vector2(170.0, 90.0),
        Vector2(25.0, 20.0),
        Vector2(100.0, -100.0)
      ];
      final curve = Bezier.fromPoints(points);

      expect(curve, TypeMatcher<CubicBezier>());
      expect(curve.order, equals(3));
      expect(curve.points, hasLength(4));
    });

    test('fromPoints, error thrown with five entries', () {
      final points = <Vector2>[
        Vector2(0.0, 0.0),
        Vector2(170.0, 90.0),
        Vector2(25.0, 20.0),
        Vector2(100.0, -100.0),
        Vector2(-30.0, 100.0)
      ];
      expect(() => Bezier.fromPoints(points), throwsA(TypeMatcher<Error>()));
    });
  });
}
