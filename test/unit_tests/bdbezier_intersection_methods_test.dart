import "../testing_tools/testing_tools.dart";

void main() {
  group("intersectionsWithCurve", () {
    test("quadratic intersectionsWithCurve", () {
      final curveA = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 50.0),
        new Vector2(100.0, 0.0)
      ]);

      final curveB = new QuadraticBezier([
        new Vector2(0.0, 50.0),
        new Vector2(50.0, -100.0),
        new Vector2(100.0, 50.0)
      ]);

      var resultA = curveA.intersectionsWithCurve(curveB);
      expect(resultA, hasLength(2));

      var resultB = curveB.intersectionsWithCurve(curveA);
      expect(resultB, hasLength(2));
    });

    test("cubic intersectionsWithCurve", () {
      final curveA = new BDCubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(0.0, 50.0),
        new Vector2(100.0, 50.0),
        new Vector2(100.0, 0.0)
      ]);

      final curveB = new BDCubicBezier([
        new Vector2(-10.0, 15.0),
        new Vector2(10.0, 25.0),
        new Vector2(90.0, 25.0),
        new Vector2(110.0, 15.0)
      ]);

      var resultA = curveA.intersectionsWithCurve(curveB);
      expect(resultA, hasLength(2));

      var resultB = curveB.intersectionsWithCurve(curveA);
      expect(resultB, hasLength(2));
    });

    test("cubic intersectionsWithCurve with quadratic curve", () {
      final curveA = new BDCubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(0.0, 50.0),
        new Vector2(100.0, 50.0),
        new Vector2(100.0, 0.0)
      ]);

      final curveB = new QuadraticBezier([
        new Vector2(-10.0, 15.0),
        new Vector2(50.0, 25.0),
        new Vector2(110.0, 15.0)
      ]);

      var resultA = curveA.intersectionsWithCurve(curveB);
      expect(resultA, hasLength(2));

      var resultB = curveB.intersectionsWithCurve(curveA);
      expect(resultB, hasLength(2));
    });

    test("quadratic intersectionsWithCurve, one intersection", () {
      final curveA = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 100.0),
        new Vector2(100.0, 0.0)
      ]);

      final curveB = new QuadraticBezier([
        new Vector2(50.0, 0.0),
        new Vector2(150.0, 300.0),
        new Vector2(250.0, 0.0)
      ]);

      final resultA = curveA.intersectionsWithCurve(curveB);
      expect(resultA, hasLength(1));

      final resultB = curveB.intersectionsWithCurve(curveA);
      expect(resultB, hasLength(1));

    });

    test("quadratic intersectionsWithCurve, two intersections", () {
      final curveA = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 100.0),
        new Vector2(100.0, 0.0)
      ]);

      final curveB = new QuadraticBezier([
        new Vector2(25.0, 100.0),
        new Vector2(75.0, -100.0),
        new Vector2(125.0, 100.0)
      ]);

      final resultA = curveA.intersectionsWithCurve(curveB);
      expect(resultA, hasLength(2));

      final resultB = curveB.intersectionsWithCurve(curveA);
      expect(resultB, hasLength(2));
    });

    test("quadratic intersectionsWithCurve, four intersections", () {
      final curveA = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 200.0),
        new Vector2(100.0, 0.0)
      ]);

      final curveB = new QuadraticBezier([
        new Vector2(-50.0, 0.0),
        new Vector2(250.0, 50.0),
        new Vector2(-50.0, 100.0)
      ]);

      final resultA = curveA.intersectionsWithCurve(curveB);
      expect(resultA, hasLength(4));

      final resultB = curveB.intersectionsWithCurve(curveA);
      expect(resultB, hasLength(4));
    });

    test("quadratic intersectionsWithCurve with looped cubic near self-intersection point, two intersections", () {
      final curveA = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 100.0),
        new Vector2(100.0, 0.0)
      ]);

      final curveB = new BDCubicBezier([
        new Vector2(0.0, 100.0),
        new Vector2(200.0, -66.7),
        new Vector2(-100.0, -66.7),
        new Vector2(100.0, 100.0)
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

    test("cubic intersectionsWithCurve, five intersections", () {
      final curveA = new BDCubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 300.0),
        new Vector2(50.0, -200.0),
        new Vector2(100.0, 100.0)
      ]);

      final curveB = new BDCubicBezier([
        new Vector2(0.0, 100.0),
        new Vector2(200.0, -66.7),
        new Vector2(-100.0, -66.7),
        new Vector2(100.0, 50.0)
      ]);

      final resultA = curveA.intersectionsWithCurve(curveB);
      expect(resultA, hasLength(5));

      final resultB = curveB.intersectionsWithCurve(curveA);
      expect(resultB, hasLength(5));
    });

    test("cubic intersectionsWithCurve(), nine intersections", () {
      final curveA = new BDCubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 300.0),
        new Vector2(50.0, -200.0),
        new Vector2(100.0, 100.0)
      ]);

      final curveB = new BDCubicBezier([
        new Vector2(0.0, 80.0),
        new Vector2(350.0, 50.0),
        new Vector2(-300.0, 50.0),
        new Vector2(100.0, 20.0)
      ]);

      final resultA = curveA.intersectionsWithCurve(curveB);
      expect(resultA, hasLength(9));

      final resultB = curveB.intersectionsWithCurve(curveA);
      expect(resultB, hasLength(9));
    });

    test("quadratic intersectionsWithCurve with other quadratic at shallow angle, one intersection with increased minTValueDifference", () {
      final curveA = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 20.0),
        new Vector2(100.0, 100.0)
      ]);

      final curveB = new QuadraticBezier([
        new Vector2(0.0, 10.0),
        new Vector2(50.0, 25.0),
        new Vector2(100.0, 90.0)
      ]);

      final difference = 0.04;
      final resultA = curveA.intersectionsWithCurve(curveB, minTValueDifference: difference);
      expect(resultA, hasLength(1));

      final resultB = curveB.intersectionsWithCurve(curveA, minTValueDifference: difference);
      expect(resultB, hasLength(1));
    });

    test("quadratic intersectionsWithCurve with other quadratic at shallow angle, one intersection with decreased curveIntersectionThreshold", () {
      final curveA = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 20.0),
        new Vector2(100.0, 100.0)
      ]);

      final curveB = new QuadraticBezier([
        new Vector2(0.0, 10.0),
        new Vector2(50.0, 25.0),
        new Vector2(100.0, 90.0)
      ]);

      final threshold = 0.05;
      final resultA = curveA.intersectionsWithCurve(curveB, curveIntersectionThreshold: threshold);
      expect(resultA, hasLength(1));

      final resultB = curveB.intersectionsWithCurve(curveA, curveIntersectionThreshold: threshold);
      expect(resultB, hasLength(1));
    });

  });

  group("intersectionsWithSelf", () {
    test("cubic intersectionsWithSelf, no intersection", () {
      final points = [
        new Vector2(10.0, 30.0),
        new Vector2(50.0, 50.0),
        new Vector2(80.0, 40.0),
        new Vector2(100.0, 0.0)
      ];
      final curveA = new BDCubicBezier(points);

      final result = curveA.intersectionsWithSelf();
      expect(result, isEmpty);
    });

    test("cubic intersectionsWithSelf, one intersection", () {
      final points = [
        new Vector2(0.0, 0.0),
        new Vector2(200.0, 100.0),
        new Vector2(-100.0, 100.0),
        new Vector2(100.0, 0.0)
      ];
      final curve = new BDCubicBezier(points);

      final result = curve.intersectionsWithSelf();
      expect(result, hasLength(1));
    });

    test("cubic intersectionsWithSelf, one intersection again", () {
      final curve = new BDCubicBezier([
        new Vector2(40.0, 0.0),
        new Vector2(200.0, 100.0),
        new Vector2(-100.0, 100.0),
        new Vector2(100.0, 70.0)
      ]);

      final result = curve.intersectionsWithSelf();
      expect(result, hasLength(1));
    });

    test("cubic intersectionsWithSelf with shallow angle, one intersection with reduced curveIntersectionThreshold", () {
      final curve = new BDCubicBezier([
        new Vector2(10.0, 0.0),
        new Vector2(180.0, 200.0),
        new Vector2(200.0, 180.0),
        new Vector2(0.0, 10.0)
      ]);

      final threshold = 0.15;
      final result = curve.intersectionsWithSelf(curveIntersectionThreshold: threshold);
      expect(result, hasLength(1));
    });
  });

  group("intersectionsWithLineSegment", () {
    test("cubic intersectionsWithLineSegment, diagonal line with two intersections", () {
      final points = [
        new Vector2(10.0, 30.0),
        new Vector2(50.0, 50.0),
        new Vector2(80.0, 40.0),
        new Vector2(100.0, 0.0)
      ];
      final curve = new BDCubicBezier(points);

      final point1 = new Vector2(0.0, 38.0);
      final point2 = new Vector2(110.0, 2.0);

      final result = curve.intersectionsWithLineSegment(point1, point2);
      expect(result, hasLength(2));
    });

    test("quadratic intersectionsWithLineSegment, diagonal line with two intersections", () {
      final points = [
        new Vector2(10.0, 500.0),
        new Vector2(50.0, 0.0),
        new Vector2(90.0, 500.0)
      ];
      final curve = new QuadraticBezier(points);

      final point1 = new Vector2(0.0, 400.0);
      final point2 = new Vector2(100.0, 410.0);

      final result = curve.intersectionsWithLineSegment(point1, point2);
      expect(result, hasLength(2));
    });

    test("quadratic intersectionsWithLineSegment, vertical line with single intersection", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 100.0),
        new Vector2(100.0, 0.0)
      ]);
      final p1 = new Vector2(30.0, 0.0);
      final p2 = new Vector2(30.0, 100.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test("quadratic intersectionsWithLineSegment, horizontal line through left half, single intersection", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 100.0),
        new Vector2(100.0, 0.0)
      ]);
      final p1 = new Vector2(0.0, 30.0);
      final p2 = new Vector2(50.0, 30.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test("quadratic intersectionsWithLineSegment, horizontal line tangent to apex, single intersection", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 100.0),
        new Vector2(100.0, 0.0)
      ]);
      final p1 = new Vector2(0.0, 50.0);
      final p2 = new Vector2(100.0, 50.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test("quadratic intersectionsWithLineSegment, horizontal line just above apex, no intersections", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 100.0),
        new Vector2(100.0, 0.0)
      ]);
      final p1 = new Vector2(0.0, 50.1);
      final p2 = new Vector2(100.0, 50.1);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(0));
    });

    test("quadratic intersectionsWithLineSegment, horizontal line just below apex, two intersections", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 100.0),
        new Vector2(100.0, 0.0)
      ]);
      final p1 = new Vector2(0.0, 49.9);
      final p2 = new Vector2(100.0, 49.9);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(2));
    });

    test("quadratic intersectionsWithLineSegment, horizontal line through diagonal curve, one intersection", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(100.0, 0.0),
        new Vector2(100.0, 100.0)
      ]);
      final p1 = new Vector2(0.0, 50.0);
      final p2 = new Vector2(100.0, 50.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test("quadratic intersectionsWithLineSegment, vertical line through diagonal curve, one intersection", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(100.0, 0.0),
        new Vector2(100.0, 100.0)
      ]);
      final p1 = new Vector2(50.0, 100.0);
      final p2 = new Vector2(50.0, 0.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test("quadratic intersectionsWithLineSegment, parallel diagonal line through diagonal curve, two intersection", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(100.0, 0.0),
        new Vector2(100.0, 100.0)
      ]);
      final p1 = new Vector2(20.0, 0.0);
      final p2 = new Vector2(100.0, 80.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(2));
    });

    test("quadratic intersectionsWithLineSegment, perpendicular diagonal line through diagonal curve, one intersection", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(100.0, 0.0),
        new Vector2(100.0, 100.0)
      ]);
      final p1 = new Vector2(100.0, 0.0);
      final p2 = new Vector2(0.0, 100.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test("quadratic intersectionsWithLineSegment, slanted diagonal line through diagonal curve, one intersection", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(100.0, 0.0),
        new Vector2(100.0, 100.0)
      ]);
      final p1 = new Vector2(100.0, 0.0);
      final p2 = new Vector2(50.0, 100.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test("quadratic intersectionsWithLineSegment, slanted line through linear curve, one intersection", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(20.0, 20.0),
        new Vector2(100.0, 100.0)
      ]);
      final p1 = new Vector2(0.0, 80.0);
      final p2 = new Vector2(100.0, 30.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test("quadratic intersectionsWithLineSegment, perpendicular line through linear curve, one intersection", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(20.0, 20.0),
        new Vector2(100.0, 100.0)
      ]);
      final p1 = new Vector2(0.0, 100.0);
      final p2 = new Vector2(100.0, 0.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test("cubic intersectionsWithLineSegment, horizontal line, one intersection", () {
      final curve = new BDCubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 100.0),
        new Vector2(50.0, 0.0),
        new Vector2(100.0, 100.0)
      ]);
      final p1 = new Vector2(0.0, 20.0);
      final p2 = new Vector2(100.0, 20.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test("cubic intersectionsWithLineSegment, horizontal line, two intersections", () {
      final curve = new BDCubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(20.0, 100.0),
        new Vector2(80.0, 200.0),
        new Vector2(100.0, 0.0)
      ]);
      final p1 = new Vector2(0.0, 20.0);
      final p2 = new Vector2(100.0, 20.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(2));
    });

    test("cubic intersectionsWithLineSegment, horizontal line, three intersections", () {
      final curve = new BDCubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 200.0),
        new Vector2(50.0, -100.0),
        new Vector2(100.0, 100.0)
      ]);
      final p1 = new Vector2(0.0, 50.0);
      final p2 = new Vector2(100.0, 50.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(3));
    });

    test("cubic intersectionsWithLineSegment, vertical line, one intersection", () {
      final curve = new BDCubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 200.0),
        new Vector2(50.0, -100.0),
        new Vector2(100.0, 100.0)
      ]);
      final p1 = new Vector2(50.0, 0.0);
      final p2 = new Vector2(50.0, 100.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

    test("cubic intersectionsWithLineSegment, vertical line with looped curve, three intersection", () {
      final curve = new BDCubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(200.0, 100.0),
        new Vector2(-100.0, 100.0),
        new Vector2(100.0, 0.0)
      ]);
      final p1 = new Vector2(40.0, 0.0);
      final p2 = new Vector2(40.0, 100.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(3));
    });

    test("cubic intersectionsWithLineSegment, perpendicular line through linear curve, one intersection", () {
      final curve = new BDCubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(20.0, 20.0),
        new Vector2(50.0, 50.0),
        new Vector2(100.0, 100.0)
      ]);
      final p1 = new Vector2(100.0, 0.0);
      final p2 = new Vector2(00.0, 100.0);

      final result = curve.intersectionsWithLineSegment(p1, p2);
      expect(result, hasLength(1));
    });

  });
}
