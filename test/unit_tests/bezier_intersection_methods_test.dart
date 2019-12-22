import '../testing_tools/testing_tools.dart';

void main() {
  group('intersectionsWithCurve', () {
    test('quadratic intersectionsWithCurve', () {
      final curveA = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(50.0, 50.0), Vector2(100.0, 0.0)]);

      final curveB = QuadraticBezier(
          [Vector2(0.0, 50.0), Vector2(50.0, -100.0), Vector2(100.0, 50.0)]);

      var resultA = curveA.intersectionsWithCurve(curveB);
      expect(resultA, hasLength(2));

      var resultB = curveB.intersectionsWithCurve(curveA);
      expect(resultB, hasLength(2));
    });

    test('cubic intersectionsWithCurve', () {
      final curveA = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(0.0, 50.0),
        Vector2(100.0, 50.0),
        Vector2(100.0, 0.0)
      ]);

      final curveB = CubicBezier([
        Vector2(-10.0, 15.0),
        Vector2(10.0, 25.0),
        Vector2(90.0, 25.0),
        Vector2(110.0, 15.0)
      ]);

      var resultA = curveA.intersectionsWithCurve(curveB);
      expect(resultA, hasLength(2));

      var resultB = curveB.intersectionsWithCurve(curveA);
      expect(resultB, hasLength(2));
    });

    test('cubic intersectionsWithCurve with quadratic curve', () {
      final curveA = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(0.0, 50.0),
        Vector2(100.0, 50.0),
        Vector2(100.0, 0.0)
      ]);

      final curveB = QuadraticBezier(
          [Vector2(-10.0, 15.0), Vector2(50.0, 25.0), Vector2(110.0, 15.0)]);

      var resultA = curveA.intersectionsWithCurve(curveB);
      expect(resultA, hasLength(2));

      var resultB = curveB.intersectionsWithCurve(curveA);
      expect(resultB, hasLength(2));
    });

    test('quadratic intersectionsWithCurve, one intersection', () {
      final curveA = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(50.0, 100.0), Vector2(100.0, 0.0)]);

      final curveB = QuadraticBezier(
          [Vector2(50.0, 0.0), Vector2(150.0, 300.0), Vector2(250.0, 0.0)]);

      final resultA = curveA.intersectionsWithCurve(curveB);
      expect(resultA, hasLength(1));

      final resultB = curveB.intersectionsWithCurve(curveA);
      expect(resultB, hasLength(1));
    });

    test('quadratic intersectionsWithCurve, two intersections', () {
      final curveA = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(50.0, 100.0), Vector2(100.0, 0.0)]);

      final curveB = QuadraticBezier(
          [Vector2(25.0, 100.0), Vector2(75.0, -100.0), Vector2(125.0, 100.0)]);

      final resultA = curveA.intersectionsWithCurve(curveB);
      expect(resultA, hasLength(2));

      final resultB = curveB.intersectionsWithCurve(curveA);
      expect(resultB, hasLength(2));
    });

    test('quadratic intersectionsWithCurve, four intersections', () {
      final curveA = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(50.0, 200.0), Vector2(100.0, 0.0)]);

      final curveB = QuadraticBezier(
          [Vector2(-50.0, 0.0), Vector2(250.0, 50.0), Vector2(-50.0, 100.0)]);

      final resultA = curveA.intersectionsWithCurve(curveB);
      expect(resultA, hasLength(4));

      final resultB = curveB.intersectionsWithCurve(curveA);
      expect(resultB, hasLength(4));
    });

    test(
        'quadratic intersectionsWithCurve with looped cubic near self-intersection point, two intersections',
        () {
      final curveA = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(50.0, 100.0), Vector2(100.0, 0.0)]);

      final curveB = CubicBezier([
        Vector2(0.0, 100.0),
        Vector2(200.0, -66.7),
        Vector2(-100.0, -66.7),
        Vector2(100.0, 100.0)
      ]);

      final resultA = curveA.intersectionsWithCurve(curveB);
      expect(resultA, hasLength(2));
      expect(resultA[0].t1, closeToDouble(0.5, 0.003));
      expect(resultA[1].t1, closeToDouble(0.5, 0.003));

      final resultB = curveB.intersectionsWithCurve(curveA);
      expect(resultB, hasLength(2));
      expect(resultB[0].t2, closeToDouble(0.5, 0.003));
      expect(resultB[1].t2, closeToDouble(0.5, 0.003));
    });

    test('cubic intersectionsWithCurve, five intersections', () {
      final curveA = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(50.0, 300.0),
        Vector2(50.0, -200.0),
        Vector2(100.0, 100.0)
      ]);

      final curveB = CubicBezier([
        Vector2(0.0, 100.0),
        Vector2(200.0, -66.7),
        Vector2(-100.0, -66.7),
        Vector2(100.0, 50.0)
      ]);

      final resultA = curveA.intersectionsWithCurve(curveB);
      expect(resultA, hasLength(5));

      final resultB = curveB.intersectionsWithCurve(curveA);
      expect(resultB, hasLength(5));
    });

    test('cubic intersectionsWithCurve(), nine intersections', () {
      final curveA = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(50.0, 300.0),
        Vector2(50.0, -200.0),
        Vector2(100.0, 100.0)
      ]);

      final curveB = CubicBezier([
        Vector2(0.0, 80.0),
        Vector2(350.0, 50.0),
        Vector2(-300.0, 50.0),
        Vector2(100.0, 20.0)
      ]);

      final resultA = curveA.intersectionsWithCurve(curveB);
      expect(resultA, hasLength(9));

      final resultB = curveB.intersectionsWithCurve(curveA);
      expect(resultB, hasLength(9));
    });

    test(
        'quadratic intersectionsWithCurve with other quadratic at shallow angle, one intersection with increased minTValueDifference',
        () {
      final curveA = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(50.0, 20.0), Vector2(100.0, 100.0)]);

      final curveB = QuadraticBezier(
          [Vector2(0.0, 10.0), Vector2(50.0, 25.0), Vector2(100.0, 90.0)]);

      final difference = 0.04;
      final resultA = curveA.intersectionsWithCurve(curveB,
          minTValueDifference: difference);
      expect(resultA, hasLength(1));

      final resultB = curveB.intersectionsWithCurve(curveA,
          minTValueDifference: difference);
      expect(resultB, hasLength(1));
    });

    test(
        'quadratic intersectionsWithCurve with other quadratic at shallow angle, one intersection with decreased curveIntersectionThreshold',
        () {
      final curveA = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(50.0, 20.0), Vector2(100.0, 100.0)]);

      final curveB = QuadraticBezier(
          [Vector2(0.0, 10.0), Vector2(50.0, 25.0), Vector2(100.0, 90.0)]);

      final threshold = 0.05;
      final resultA = curveA.intersectionsWithCurve(curveB,
          curveIntersectionThreshold: threshold);
      expect(resultA, hasLength(1));

      final resultB = curveB.intersectionsWithCurve(curveA,
          curveIntersectionThreshold: threshold);
      expect(resultB, hasLength(1));
    });
  });

  group('intersectionsWithSelf', () {
    test('cubic intersectionsWithSelf, no intersection', () {
      final points = [
        Vector2(10.0, 30.0),
        Vector2(50.0, 50.0),
        Vector2(80.0, 40.0),
        Vector2(100.0, 0.0)
      ];
      final curveA = CubicBezier(points);

      final result = curveA.intersectionsWithSelf();
      expect(result, isEmpty);
    });

    test('cubic intersectionsWithSelf, one intersection', () {
      final points = [
        Vector2(0.0, 0.0),
        Vector2(200.0, 100.0),
        Vector2(-100.0, 100.0),
        Vector2(100.0, 0.0)
      ];
      final curve = CubicBezier(points);

      final result = curve.intersectionsWithSelf();
      expect(result, hasLength(1));
    });

    test('cubic intersectionsWithSelf, one intersection again', () {
      final curve = CubicBezier([
        Vector2(40.0, 0.0),
        Vector2(200.0, 100.0),
        Vector2(-100.0, 100.0),
        Vector2(100.0, 70.0)
      ]);

      final result = curve.intersectionsWithSelf();
      expect(result, hasLength(1));
    });

    test(
        'cubic intersectionsWithSelf with shallow angle, one intersection with reduced curveIntersectionThreshold',
        () {
      final curve = CubicBezier([
        Vector2(10.0, 0.0),
        Vector2(180.0, 200.0),
        Vector2(200.0, 180.0),
        Vector2(0.0, 10.0)
      ]);

      final threshold = 0.15;
      final result =
          curve.intersectionsWithSelf(curveIntersectionThreshold: threshold);
      expect(result, hasLength(1));
    });
  });

  group('intersectionsWithLineSegment', () {
    test(
        'cubic intersectionsWithLineSegment, diagonal line with two intersections',
        () {
      final points = [
        Vector2(10.0, 30.0),
        Vector2(50.0, 50.0),
        Vector2(80.0, 40.0),
        Vector2(100.0, 0.0)
      ];
      final curve = CubicBezier(points);

      final point1 = Vector2(0.0, 38.0);
      final point2 = Vector2(110.0, 2.0);

      final result = curve.intersectionsWithLineSegment(point1, point2);
      expect(result, hasLength(2));
    });

    test(
        'quadratic intersectionsWithLineSegment, diagonal line with two intersections',
        () {
      final points = [
        Vector2(10.0, 500.0),
        Vector2(50.0, 0.0),
        Vector2(90.0, 500.0)
      ];
      final curve = QuadraticBezier(points);

      final point1 = Vector2(0.0, 400.0);
      final point2 = Vector2(100.0, 410.0);

      final result = curve.intersectionsWithLineSegment(point1, point2);
      expect(result, hasLength(2));
    });

    test(
        'quadratic intersectionsWithLineSegment, vertical line with single intersection',
        () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(50.0, 100.0), Vector2(100.0, 0.0)]);
      final p1 = Vector2(30.0, 0.0);
      final p2 = Vector2(30.0, 100.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test(
        'quadratic intersectionsWithLineSegment, horizontal line through left half, single intersection',
        () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(50.0, 100.0), Vector2(100.0, 0.0)]);
      final p1 = Vector2(0.0, 30.0);
      final p2 = Vector2(50.0, 30.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test(
        'quadratic intersectionsWithLineSegment, horizontal line tangent to apex, single intersection',
        () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(50.0, 100.0), Vector2(100.0, 0.0)]);
      final p1 = Vector2(0.0, 50.0);
      final p2 = Vector2(100.0, 50.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test(
        'quadratic intersectionsWithLineSegment, horizontal line just above apex, no intersections',
        () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(50.0, 100.0), Vector2(100.0, 0.0)]);
      final p1 = Vector2(0.0, 50.1);
      final p2 = Vector2(100.0, 50.1);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(0));
    });

    test(
        'quadratic intersectionsWithLineSegment, horizontal line just below apex, two intersections',
        () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(50.0, 100.0), Vector2(100.0, 0.0)]);
      final p1 = Vector2(0.0, 49.9);
      final p2 = Vector2(100.0, 49.9);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(2));
    });

    test(
        'quadratic intersectionsWithLineSegment, horizontal line through diagonal curve, one intersection',
        () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(100.0, 0.0), Vector2(100.0, 100.0)]);
      final p1 = Vector2(0.0, 50.0);
      final p2 = Vector2(100.0, 50.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test(
        'quadratic intersectionsWithLineSegment, vertical line through diagonal curve, one intersection',
        () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(100.0, 0.0), Vector2(100.0, 100.0)]);
      final p1 = Vector2(50.0, 100.0);
      final p2 = Vector2(50.0, 0.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test(
        'quadratic intersectionsWithLineSegment, parallel diagonal line through diagonal curve, two intersection',
        () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(100.0, 0.0), Vector2(100.0, 100.0)]);
      final p1 = Vector2(20.0, 0.0);
      final p2 = Vector2(100.0, 80.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(2));
    });

    test(
        'quadratic intersectionsWithLineSegment, perpendicular diagonal line through diagonal curve, one intersection',
        () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(100.0, 0.0), Vector2(100.0, 100.0)]);
      final p1 = Vector2(100.0, 0.0);
      final p2 = Vector2(0.0, 100.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test(
        'quadratic intersectionsWithLineSegment, slanted diagonal line through diagonal curve, one intersection',
        () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(100.0, 0.0), Vector2(100.0, 100.0)]);
      final p1 = Vector2(100.0, 0.0);
      final p2 = Vector2(50.0, 100.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test(
        'quadratic intersectionsWithLineSegment, slanted line through linear curve, one intersection',
        () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(20.0, 20.0), Vector2(100.0, 100.0)]);
      final p1 = Vector2(0.0, 80.0);
      final p2 = Vector2(100.0, 30.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test(
        'quadratic intersectionsWithLineSegment, perpendicular line through linear curve, one intersection',
        () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(20.0, 20.0), Vector2(100.0, 100.0)]);
      final p1 = Vector2(0.0, 100.0);
      final p2 = Vector2(100.0, 0.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test(
        'cubic intersectionsWithLineSegment, horizontal line, one intersection',
        () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(50.0, 100.0),
        Vector2(50.0, 0.0),
        Vector2(100.0, 100.0)
      ]);
      final p1 = Vector2(0.0, 20.0);
      final p2 = Vector2(100.0, 20.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test(
        'cubic intersectionsWithLineSegment, horizontal line, two intersections',
        () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(20.0, 100.0),
        Vector2(80.0, 200.0),
        Vector2(100.0, 0.0)
      ]);
      final p1 = Vector2(0.0, 20.0);
      final p2 = Vector2(100.0, 20.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(2));
    });

    test(
        'cubic intersectionsWithLineSegment, horizontal line, three intersections',
        () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(50.0, 200.0),
        Vector2(50.0, -100.0),
        Vector2(100.0, 100.0)
      ]);
      final p1 = Vector2(0.0, 50.0);
      final p2 = Vector2(100.0, 50.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(3));
    });

    test('cubic intersectionsWithLineSegment, vertical line, one intersection',
        () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(50.0, 200.0),
        Vector2(50.0, -100.0),
        Vector2(100.0, 100.0)
      ]);
      final p1 = Vector2(50.0, 0.0);
      final p2 = Vector2(50.0, 100.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test(
        'cubic intersectionsWithLineSegment, vertical line with looped curve, three intersection',
        () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(200.0, 100.0),
        Vector2(-100.0, 100.0),
        Vector2(100.0, 0.0)
      ]);
      final p1 = Vector2(40.0, 0.0);
      final p2 = Vector2(40.0, 100.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(3));
    });

    test(
        'cubic intersectionsWithLineSegment, perpendicular line through linear curve, one intersection',
        () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(20.0, 20.0),
        Vector2(50.0, 50.0),
        Vector2(100.0, 100.0)
      ]);
      final p1 = Vector2(100.0, 0.0);
      final p2 = Vector2(00.0, 100.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test(
        'cubic intersectionsWithLineSegment, y axis through typical curve, one intersection',
        () {
      final curve = CubicBezier([
        Vector2(-214.5, 80.0),
        Vector2(-52.0, 80.0),
        Vector2(52.0, 530.0),
        Vector2(214.5, 530.0)
      ]);
      final p1 = Vector2(0.0, 0.0);
      final p2 = Vector2(0.0, 1080.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test(
        'cubic intersectionsWithLineSegment, y axis through typical curve, translated to the right, one intersection',
        () {
      final offset = 429.0;
      final curve = CubicBezier([
        Vector2(-214.5 + offset, 80.0),
        Vector2(-52.0 + offset, 80.0),
        Vector2(52.0 + offset, 530.0),
        Vector2(214.5 + offset, 530.0)
      ]);
      final p1 = Vector2(0.0 + offset, 0.0);
      final p2 = Vector2(0.0 + offset, 1080.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test(
        'cubic intersectionsWithLineSegment, horizontal line through typical curve',
        () {
      final curve = CubicBezier([
        Vector2(214.5, 630.0),
        Vector2(308.25, 630.0),
        Vector2(368.625, 492.5),
        Vector2(429.0, 355.0)
      ]);
      final p1 = Vector2(0.0, 580.0);
      final p2 = Vector2(430.0, 580.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test(
        'cubic intersectionsWithLineSegment, horizontal line through typical curve, translated up',
        () {
      final offset = 6.0;
      final curve = CubicBezier([
        Vector2(214.5, 630.0 + offset),
        Vector2(308.25, 630.0 + offset),
        Vector2(368.625, 492.5 + offset),
        Vector2(429.0, 355.0 + offset)
      ]);
      final p1 = Vector2(0.0, 580.0 + offset);
      final p2 = Vector2(430.0, 580.0 + offset);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test(
        'cubic intersectionsWithLineSegment, horizontal line through typical curve, translated down',
        () {
      final offset = -6.0;
      final curve = CubicBezier([
        Vector2(214.5, 630.0 + offset),
        Vector2(308.25, 630.0 + offset),
        Vector2(368.625, 492.5 + offset),
        Vector2(429.0, 355.0 + offset)
      ]);
      final p1 = Vector2(0.0, 580.0 + offset);
      final p2 = Vector2(430.0, 580.0 + offset);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });
  });
}
