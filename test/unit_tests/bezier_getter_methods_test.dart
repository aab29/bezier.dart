import '../testing_tools/testing_tools.dart';

void main() {
  group('startPoint', () {
    test('quadratic startPoint', () {
      final curve = QuadraticBezier(
          [Vector2(10.0, 10.0), Vector2(70.0, 95.0), Vector2(15.0, 80.0)]);
      expect(curve.startPoint, closeToVector(Vector2(10.0, 10.0)));
    });

    test('cubic startPoint', () {
      final curve = CubicBezier([
        Vector2(90.0, 80.0),
        Vector2(50.0, 10.0),
        Vector2(40.0, 85.0),
        Vector2(95.0, 30.0)
      ]);
      expect(curve.startPoint, closeToVector(Vector2(90.0, 80.0)));
    });
  });

  group('endPoint', () {
    test('quadratic endPoint', () {
      final curve = QuadraticBezier(
          [Vector2(10.0, 10.0), Vector2(70.0, 95.0), Vector2(15.0, 80.0)]);
      expect(curve.endPoint, closeToVector(Vector2(15.0, 80.0)));
    });

    test('cubic endPoint', () {
      final curve = CubicBezier([
        Vector2(90.0, 80.0),
        Vector2(50.0, 10.0),
        Vector2(40.0, 85.0),
        Vector2(95.0, 30.0)
      ]);
      expect(curve.endPoint, closeToVector(Vector2(95.0, 30.0)));
    });
  });

  group('derivativePoints', () {
    test('quadratic derivativePoints', () {
      final curve = QuadraticBezier(
          [Vector2(10.0, 10.0), Vector2(70.0, 95.0), Vector2(15.0, 80.0)]);

      final firstDerivativePoints = curve.derivativePoints();
      expect(firstDerivativePoints, hasLength(2));
      expect(firstDerivativePoints[0], closeToVector(Vector2(120.0, 170.0)));
      expect(firstDerivativePoints[1], closeToVector(Vector2(-110.0, -30.0)));

      final secondDerivativePoints = curve.derivativePoints(derivativeOrder: 2);
      expect(secondDerivativePoints, hasLength(1));
      expect(secondDerivativePoints[0], closeToVector(Vector2(-230.0, -200.0)));

      expect(curve.derivativePoints(derivativeOrder: 3), isEmpty);
    });

    test('cubic derivativePoints', () {
      final points = [
        Vector2(90.0, 80.0),
        Vector2(50.0, 10.0),
        Vector2(40.0, 85.0),
        Vector2(95.0, 30.0)
      ];

      final curve = CubicBezier(points);

      final dpoints1 = curve.derivativePoints();
      expect(dpoints1, hasLength(3));
      expect(dpoints1[0], closeToVector(Vector2(-120.0, -210.0)));
      expect(dpoints1[1], closeToVector(Vector2(-30.0, 225.0)));
      expect(dpoints1[2], closeToVector(Vector2(165.0, -165.0)));

      final dpoints2 = curve.derivativePoints(derivativeOrder: 2);
      expect(dpoints2, hasLength(2));
      expect(dpoints2[0], closeToVector(Vector2(180.0, 870.0)));
      expect(dpoints2[1], closeToVector(Vector2(390.0, -780.0)));

      final dpoints3 = curve.derivativePoints(derivativeOrder: 3);
      expect(dpoints3, hasLength(1));
      expect(dpoints3[0], closeToVector(Vector2(210.0, -1650.0)));
    });

    test('quadratic derivativePoints, second test', () {
      final points = [
        Vector2(40.0, 40.0),
        Vector2(30.0, 10.0),
        Vector2(55.0, 25.0)
      ];
      final curve = QuadraticBezier(points);

      final dpoints1 = curve.derivativePoints();
      expect(dpoints1, hasLength(2));
      expect(dpoints1[0], closeToVector(Vector2(-20.0, -60.0)));
      expect(dpoints1[1], closeToVector(Vector2(50.0, 30.0)));

      final dpoints2 = curve.derivativePoints(derivativeOrder: 2);
      expect(dpoints2, hasLength(1));
      expect(dpoints2[0], closeToVector(Vector2(70.0, 90.0)));
    });
  });

  group('isClockwise', () {
    test('quadratic isClockwise', () {
      final clockwiseCurve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(50.0, 100.0), Vector2(100.0, 0.0)]);

      expect(clockwiseCurve.isClockwise, isTrue);

      final counterclockwiseCurve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(50.0, -100.0), Vector2(100.0, 0.0)]);

      expect(counterclockwiseCurve.isClockwise, isFalse);

      final linearCurve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(20.0, 20.0), Vector2(100.0, 100.0)]);

      expect(linearCurve.isClockwise, isFalse);
    });

    test('cubic isClockwise', () {
      final clockwiseCurve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(100.0, 250.0),
        Vector2(-50.0, 20.0),
        Vector2(100.0, 0.0)
      ]);

      expect(clockwiseCurve.isClockwise, isTrue);

      final counterclockwiseCurve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(-100.0, -250.0),
        Vector2(50.0, 20.0),
        Vector2(100.0, 0.0)
      ]);

      expect(counterclockwiseCurve.isClockwise, isFalse);

      final linearCurve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(33.0, 33.0),
        Vector2(66.0, 66.0),
        Vector2(100.0, 100.0)
      ]);

      expect(linearCurve.isClockwise, isFalse);
    });

    test('cubic isClockwise, clockwise curve', () {
      final points = [
        Vector2(50.0, 10.0),
        Vector2(40.0, 85.0),
        Vector2(95.0, 30.0),
        Vector2(90.0, 80.0)
      ];
      final curve = CubicBezier(points);
      expect(curve.isClockwise, isTrue);
    });

    test('quadratic isClockwise, clockwise curve', () {
      final points = [
        Vector2(-40.0, -40.0),
        Vector2(30.0, 10.0),
        Vector2(55.0, 25.0)
      ];
      final curve = QuadraticBezier(points);
      expect(curve.isClockwise, isTrue);
    });

    test('cubic isClockwise, counter-clockwise curve', () {
      final points = [
        Vector2(10.0, 10.0),
        Vector2(70.0, 95.0),
        Vector2(25.0, 20.0),
        Vector2(15.0, 80.0)
      ];
      final curve = CubicBezier(points);
      expect(curve.isClockwise, isFalse);
    });

    test('quadratic isClockwise, counter-clockwise curve', () {
      final points = [
        Vector2(55.0, 25.0),
        Vector2(40.0, 40.0),
        Vector2(30.0, 10.0)
      ];
      final curve = QuadraticBezier(points);
      expect(curve.isClockwise, isFalse);
    });

    test(
        'quadratic isClockwise, diagonal degenerate curve with control point beyond end point',
        () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(100.0, 100.0), Vector2(20.0, 20.0)]);
      expect(curve.isClockwise, isFalse);
    });

    test(
        'quadratic isClockwise, diagonal degenerate curve with control point before start point',
        () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(-100.0, -100.0), Vector2(20.0, 20.0)]);
      expect(curve.isClockwise, isTrue);
    });

    test(
        'quadratic isClockwise, horizontal degenerate curve with control point beyond end point',
        () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(100.0, 0.0), Vector2(20.0, 0.0)]);
      expect(curve.isClockwise, isFalse);
    });

    test(
        'quadratic isClockwise, horizontal degenerate curve with control point before start point',
        () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(-100.0, 0.0), Vector2(20.0, 0.0)]);
      expect(curve.isClockwise, isTrue);
    });
  });

  group('isLinear', () {
    test('quadratic isLinear', () {
      final linearCurve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(20.0, 20.0), Vector2(100.0, 100.0)]);

      expect(linearCurve.isLinear, isTrue);

      final nonlinearCurve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(20.0, 20.0), Vector2(-50.0, 100.0)]);

      expect(nonlinearCurve.isLinear, isFalse);
    });

    test('cubic isLinear', () {
      final linearCurve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(33.0, 33.0),
        Vector2(66.0, 66.0),
        Vector2(100.0, 100.0)
      ]);

      expect(linearCurve.isLinear, isTrue);

      final nonLinearCurve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(-40.0, 100.0),
        Vector2(66.0, -50.0),
        Vector2(100.0, 100.0)
      ]);

      expect(nonLinearCurve.isLinear, isFalse);
    });

    test('cubic isLinear, linear curve', () {
      final points = [
        Vector2(10.0, 10.0),
        Vector2(20.0, 20.0),
        Vector2(50.0, 50.0),
        Vector2(180.0, 180.0)
      ];
      final curve = CubicBezier(points);
      expect(curve.isLinear, isTrue);
    });

    test('quadratic isLinear, linear curve', () {
      final points = [
        Vector2(-10.0, -10.0),
        Vector2(20.0, 20.0),
        Vector2(90.0, 90.0)
      ];
      final curve = QuadraticBezier(points);
      expect(curve.isLinear, isTrue);
    });

    test('cubic isLinear, non-linear curve', () {
      final points = [
        Vector2(10.0, 10.0),
        Vector2(20.0, 20.001),
        Vector2(50.0, 50.0),
        Vector2(180.0, 180.0)
      ];
      final curve = CubicBezier(points);
      expect(curve.isLinear, isFalse);
    });

    test('quadratic isLinear, not linear curve', () {
      final points = [
        Vector2(10.0, 10.0),
        Vector2(20.0, 20.0),
        Vector2(50.001, 50.0)
      ];
      final curve = QuadraticBezier(points);
      expect(curve.isLinear, isFalse);
    });

    test('quadratic isLinear, diagonal degenerate curve', () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(-100.0, -100.0), Vector2(20.0, 20.0)]);
      expect(curve.isLinear, isTrue);
    });

    test('quadratic isLinear, horizontal degenerate curve', () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(-100.0, 0.0), Vector2(20.0, 0.0)]);
      expect(curve.isLinear, isTrue);
    });

    test('cubic isLinear, diagonal degenerate curve', () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(-100.0, -30.0),
        Vector2(100.0, 30.0),
        Vector2(10.0, 3.0)
      ]);
      expect(curve.isLinear, isTrue);
    });

    test('cubic isLinear, horizontal degenerate curve', () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(-100.0, 0.0),
        Vector2(100.0, 0.0),
        Vector2(10.0, 0.0)
      ]);
      expect(curve.isLinear, isTrue);
    });
  });

  group('length', () {
    test('cubic length', () {
      final points = [
        Vector2(10.0, 10.0),
        Vector2(70.0, 95.0),
        Vector2(25.0, 20.0),
        Vector2(15.0, 80.0)
      ];
      final curve = CubicBezier(points);
      expect(curve.length, closeToDouble(95.80310376637526));
    });

    test('quadratic length', () {
      final points = [
        Vector2(10.0, 10.0),
        Vector2(70.0, 95.0),
        Vector2(15.0, 80.0)
      ];
      final curve = QuadraticBezier(points);
      expect(curve.length, closeToDouble(102.64876949628173));
    });

    test('cubic length, linear curve', () {
      final points = [
        Vector2(0.0, 0.0),
        Vector2(-70.0, -70.0),
        Vector2(-80.0, -80.0),
        Vector2(-100.0, -100.0)
      ];
      final curve = CubicBezier(points);
      expect(curve.length, closeToDouble(141.42135469034142));
    });

    test('quadratic length, linear curve', () {
      final points = [
        Vector2(-70.0, -70.0),
        Vector2(-80.0, -80.0),
        Vector2(-100.0, -100.0)
      ];
      final curve = QuadraticBezier(points);
      expect(curve.length, closeToDouble(42.426406480714064));
    });

    test('quadratic length, degenerate curve', () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(100.0, 0.0), Vector2(50.0, 0.0)]);
      expect(curve.length, closeToDouble(83.32994626641911));
    });

    test('cubic length, degenerate curve', () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(-100.0, 0.0),
        Vector2(100.0, 0.0),
        Vector2(50.0, 0.0)
      ]);
      expect(curve.length, closeToDouble(123.15958331479517));
    });
  });

  group('isSimple', () {
    test('cubic isSimple, simple curve', () {
      final points = [
        Vector2(100.0, 100.0),
        Vector2(90.0, 80.0),
        Vector2(30.0, 20.0),
        Vector2(0.0, 0.0)
      ];
      final curve = CubicBezier(points);

      expect(curve.isSimple, isTrue);
    });

    test('cubic isSimple, non-simple curve', () {
      final points = [
        Vector2(105.0, 70.0),
        Vector2(50.0, 50.0),
        Vector2(50.0, 80.0),
        Vector2(135.0, 95.0)
      ];
      final curve = CubicBezier(points);

      expect(curve.isSimple, isFalse);
    });

    test('quadratic isSimple, simple curve', () {
      final points = [
        Vector2(20.0, 20.0),
        Vector2(60.0, 60.0),
        Vector2(100.0, 100.0)
      ];
      final curve = QuadraticBezier(points);

      expect(curve.isSimple, isTrue);
    });

    test('quadratic isSimple, non-simple curve', () {
      final points = [
        Vector2(20.0, 60.0),
        Vector2(100.0, 20.0),
        Vector2(0.0, 100.0)
      ];
      final curve = QuadraticBezier(points);

      expect(curve.isSimple, isFalse);
    });

    test(
        'cubic isSimple, non-simple curve with near-parallel endpoint normal vectors',
        () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(50.0, 100.0),
        Vector2(50.0, -99.0),
        Vector2(100.0, 0.0)
      ]);

      expect(curve.isSimple, isFalse);
    });

    test('quadratic isSimple, simple curve border case', () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(50.0, 28.86), Vector2(100.0, 0.0)]);

      expect(curve.isSimple, isTrue);
    });

    test('quadratic isSimple, non-simple curve border case', () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(50.0, 28.87), Vector2(100.0, 0.0)]);

      expect(curve.isSimple, isFalse);
    });

    test('cubic isSimple, simple curve border case', () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(25.0, -20.0),
        Vector2(112.18, -20.0),
        Vector2(100.0, -100.0)
      ]);

      expect(curve.isSimple, isTrue);
    });

    test('cubic isSimple, non-simple curve border case', () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(25.0, -20.0),
        Vector2(112.19, -20.0),
        Vector2(100.0, -100.0)
      ]);

      expect(curve.isSimple, isFalse);
    });

    test('cubic isSimple, simple curve with points close together', () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(0.5, 0.2),
        Vector2(0.995, 0.398),
        Vector2(1.4851, 0.594)
      ]);

      expect(curve.isSimple, isTrue);
    });

    test('quadratic isSimple, diagonal degenerate curve', () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(100.0, 30.0), Vector2(50.0, 15.0)]);
      expect(curve.isSimple, isFalse);
    });

    test('quadratic isSimple, horizontal degenerate curve', () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(100.0, 0.0), Vector2(50.0, 0.0)]);
      expect(curve.isSimple, isFalse);
    });

    test(
        'cubic isSimple, diagonal degenerate curve, both control points on outside',
        () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(-100.0, -30.0),
        Vector2(100.0, 30.0),
        Vector2(50.0, 15.0)
      ]);
      expect(curve.isSimple, isTrue);
    });

    test(
        'cubic isSimple, horizontal degenerate curve, both control points on outside',
        () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(-2000.0, 0.0),
        Vector2(2500.0, 0.0),
        Vector2(50.0, 0.0)
      ]);
      expect(curve.isSimple, isTrue);
    });

    test(
        'cubic isSimple, horizontal degenerate curve, both control points going past opposite endpoint',
        () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(2000.0, 0.0),
        Vector2(-2500.0, 0.0),
        Vector2(50.0, 0.0)
      ]);
      expect(curve.isSimple, isTrue);
    });

    test(
        'cubic isSimple, horizontal degenerate curve, one control point on outside',
        () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(-2000.0, 0.0),
        Vector2(25.0, 0.0),
        Vector2(50.0, 0.0)
      ]);
      expect(curve.isSimple, isFalse);
    });

    test(
        'cubic isSimple, horizontal degenerate curve, one control point going past opposite endpoint',
        () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(2000.0, 0.0),
        Vector2(25.0, 0.0),
        Vector2(50.0, 0.0)
      ]);
      expect(curve.isSimple, isTrue);
    });

    test(
        'cubic isSimple, horizontal degenerate curve, one control point on outside, other going past opposite endpoint',
        () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(2000.0, 0.0),
        Vector2(2500.0, 0.0),
        Vector2(50.0, 0.0)
      ]);
      expect(curve.isSimple, isFalse);
    });

    test(
        'quadratic isSimple, degenerate curve with control point overlapping end point',
        () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(100.0, 0.0), Vector2(100.0, 0.0)]);
      expect(curve.isSimple, isTrue);
    });

    test(
        'cubic isSimple, linear degenerate curve with one control point overlapping adjacent end point',
        () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(0.0, 0.0),
        Vector2(25.0, 0.0),
        Vector2(100.0, 0.0)
      ]);
      expect(curve.isSimple, isTrue);
    });

    test(
        'cubic isSimple, simple non-linear degenerate curve with one control point overlapping adjacent end point',
        () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(0.0, 0.0),
        Vector2(50.0, 5.0),
        Vector2(100.0, 0.0)
      ]);
      expect(curve.isSimple, isTrue);
    });

    test(
        'cubic isSimple, non-simple non-linear degenerate curve with one control point overlapping adjacent end point',
        () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(0.0, 0.0),
        Vector2(2500.0, 10.0),
        Vector2(100.0, 0.0)
      ]);
      expect(curve.isSimple, isFalse);
    });

    test(
        'cubic isSimple, degenerate curve with both control points overlapping adjacent end point',
        () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(0.0, 0.0),
        Vector2(100.0, 0.0),
        Vector2(100.0, 0.0)
      ]);
      expect(curve.isSimple, isTrue);
    });
  });
}
