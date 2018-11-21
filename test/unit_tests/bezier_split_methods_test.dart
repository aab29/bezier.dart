import "../testing_tools/testing_tools.dart";

void main() {
  group("leftSubcurveAt", () {
    test("quadratic leftSubcurveAt", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 100.0),
        new Vector2(100.0, 0.0)
      ]);

      final result1 = curve.leftSubcurveAt(0.5);
      expect(result1, new TypeMatcher<QuadraticBezier>());
      final curve1 = result1 as QuadraticBezier;
      expect(curve1.points[0], closeToVector(new Vector2(0.0, 0.0)));
      expect(curve1.points[1], closeToVector(new Vector2(25.0, 50.0)));
      expect(curve1.points[2], closeToVector(new Vector2(50.0, 50.0)));

      final result2 = curve.leftSubcurveAt(0.8);
      expect(result2, new TypeMatcher<QuadraticBezier>());
      final curve2 = result2 as QuadraticBezier;
      expect(curve2.points[0], closeToVector(new Vector2(0.0, 0.0)));
      expect(curve2.points[1], closeToVector(new Vector2(40.0, 80.0)));
      expect(curve2.points[2], closeToVector(new Vector2(80.0, 32.0)));

      final result3 = curve.leftSubcurveAt(0.3);
      expect(result3, new TypeMatcher<QuadraticBezier>());
      final curve3 = result3 as QuadraticBezier;
      expect(curve3.points[0], closeToVector(new Vector2(0.0, 0.0)));
      expect(curve3.points[1], closeToVector(new Vector2(15.0, 30.0)));
      expect(curve3.points[2], closeToVector(new Vector2(30.0, 42.0)));
    });

    test("cubic leftSubcurveAt", () {
      final curve = new CubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(150.0, 200.0),
        new Vector2(-50.0, -100.0),
        new Vector2(100.0, 0.0)
      ]);

      final result1 = curve.leftSubcurveAt(0.5);
      expect(result1, new TypeMatcher<CubicBezier>());
      final curve1 = result1 as CubicBezier;
      expect(curve1.points[0], closeToVector(new Vector2(0.0, 0.0)));
      expect(curve1.points[1], closeToVector(new Vector2(75.0, 100.0)));
      expect(curve1.points[2], closeToVector(new Vector2(62.5, 75.0)));
      expect(curve1.points[3], closeToVector(new Vector2(50.0, 37.5)));

      final result2 = curve.leftSubcurveAt(0.8);
      expect(result2, new TypeMatcher<CubicBezier>());
      final curve2 = result2 as CubicBezier;
      expect(curve2.points[0], closeToVector(new Vector2(0.0, 0.0)));
      expect(curve2.points[1], closeToVector(new Vector2(120.0, 160.0)));
      expect(curve2.points[2], closeToVector(new Vector2(16.0, 0.0)));
      expect(curve2.points[3],
          closeToVector(new Vector2(46.400001525878906, -19.200000762939453)));

      final result3 = curve.leftSubcurveAt(0.3);
      expect(result3, new TypeMatcher<CubicBezier>());
      final curve3 = result3 as CubicBezier;
      expect(curve3.points[0], closeToVector(new Vector2(0.0, 0.0)));
      expect(curve3.points[1], closeToVector(new Vector2(45.0, 60.0)));
      expect(curve3.points[2], closeToVector(new Vector2(58.5, 75.0)));
      expect(curve3.points[3],
          closeToVector(new Vector2(59.400001525878906, 69.30000305175781)));
    });

    test("quadratic leftSubcurveAt, t > 1.0", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 100.0),
        new Vector2(100.0, 0.0)
      ]);

      final result = curve.leftSubcurveAt(1.1);
      expect(result, new TypeMatcher<QuadraticBezier>());
      final splitCurve = result as QuadraticBezier;
      expect(
          splitCurve.points,
          closeToVectorList([
            new Vector2(0.0, 0.0),
            new Vector2(50.0, 100.0),
            new Vector2(100.0, 0.0)
          ]));
    });

    test("cubic leftSubcurveAt, t > 1.0", () {
      final curve = new CubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(150.0, 200.0),
        new Vector2(-50.0, -100.0),
        new Vector2(100.0, 0.0)
      ]);

      final result = curve.leftSubcurveAt(1.1);
      expect(result, new TypeMatcher<CubicBezier>());
      final splitCurve = result as CubicBezier;
      expect(
          splitCurve.points,
          closeToVectorList([
            new Vector2(0.0, 0.0),
            new Vector2(150.0, 200.0),
            new Vector2(-50.0, -100.0),
            new Vector2(100.0, 0.0)
          ]));
    });

    test("quadratic leftSubcurveAt, t == 0.0", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 100.0),
        new Vector2(100.0, 0.0)
      ]);

      expect(() => curve.leftSubcurveAt(0.0), throwsArgumentError);
    });

    test("cubic leftSubcurveAt, t == 0.0", () {
      final curve = new CubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(150.0, 200.0),
        new Vector2(-50.0, -100.0),
        new Vector2(100.0, 0.0)
      ]);

      expect(() => curve.leftSubcurveAt(0.0), throwsArgumentError);
    });

    test("quadratic leftSubcurveAt, t < 0.0", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 100.0),
        new Vector2(100.0, 0.0)
      ]);

      expect(() => curve.leftSubcurveAt(-0.2), throwsArgumentError);
    });

    test("cubic leftSubcurveAt, t < 0.0", () {
      final curve = new CubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(150.0, 200.0),
        new Vector2(-50.0, -100.0),
        new Vector2(100.0, 0.0)
      ]);

      expect(() => curve.leftSubcurveAt(-0.2), throwsArgumentError);
    });
  });

  group("rightSubcurveAt", () {
    test("quadratic rightSubcurveAt", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 100.0),
        new Vector2(100.0, 0.0)
      ]);

      final result1 = curve.rightSubcurveAt(0.5);
      expect(result1, new TypeMatcher<QuadraticBezier>());
      final curve1 = result1 as QuadraticBezier;
      expect(curve1.points[0], closeToVector(new Vector2(50.0, 50.0)));
      expect(curve1.points[1], closeToVector(new Vector2(75.0, 50.0)));
      expect(curve1.points[2], closeToVector(new Vector2(100.0, 0.0)));

      final result2 = curve.rightSubcurveAt(0.8);
      expect(result2, new TypeMatcher<QuadraticBezier>());
      final curve2 = result2 as QuadraticBezier;
      expect(curve2.points[0], closeToVector(new Vector2(80.0, 32.0)));
      expect(curve2.points[1], closeToVector(new Vector2(90.0, 20.0)));
      expect(curve2.points[2], closeToVector(new Vector2(100.0, 0.0)));

      final result3 = curve.rightSubcurveAt(0.3);
      expect(result3, new TypeMatcher<QuadraticBezier>());
      final curve3 = result3 as QuadraticBezier;
      expect(curve3.points[0], closeToVector(new Vector2(30.0, 42.0)));
      expect(curve3.points[1], closeToVector(new Vector2(65.0, 70.0)));
      expect(curve3.points[2], closeToVector(new Vector2(100.0, 0.0)));
    });

    test("cubic rightSubcurveAt", () {
      final curve = new CubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(150.0, 200.0),
        new Vector2(-50.0, -100.0),
        new Vector2(100.0, 0.0)
      ]);

      final result1 = curve.rightSubcurveAt(0.5);
      expect(result1, new TypeMatcher<CubicBezier>());
      final curve1 = result1 as CubicBezier;
      expect(curve1.points[0], closeToVector(new Vector2(50.0, 37.5)));
      expect(curve1.points[1], closeToVector(new Vector2(37.5, 0.0)));
      expect(curve1.points[2], closeToVector(new Vector2(25.0, -50.0)));
      expect(curve1.points[3], closeToVector(new Vector2(100.0, 0.0)));

      final result2 = curve.rightSubcurveAt(0.8);
      expect(result2, new TypeMatcher<CubicBezier>());
      final curve2 = result2 as CubicBezier;
      expect(curve2.points[0],
          closeToVector(new Vector2(46.400001525878906, -19.200000762939453)));
      expect(curve2.points[1], closeToVector(new Vector2(54.0, -24.0)));
      expect(curve2.points[2], closeToVector(new Vector2(70.0, -20.0)));
      expect(curve2.points[3], closeToVector(new Vector2(100.0, 0.0)));

      final result3 = curve.rightSubcurveAt(0.3);
      expect(result3, new TypeMatcher<CubicBezier>());
      final curve3 = result3 as CubicBezier;
      expect(curve3.points[0],
          closeToVector(new Vector2(59.400001525878906, 69.30000305175781)));
      expect(curve3.points[1], closeToVector(new Vector2(61.5, 56.0)));
      expect(curve3.points[2], closeToVector(new Vector2(-5.0, -70.0)));
      expect(curve3.points[3], closeToVector(new Vector2(100.0, 0.0)));
    });

    test("quadratic rightSubcurveAt, t < 0.0", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 100.0),
        new Vector2(100.0, 0.0)
      ]);

      final result = curve.rightSubcurveAt(-0.2);
      expect(result, new TypeMatcher<QuadraticBezier>());
      final splitCurve = result as QuadraticBezier;
      expect(
          splitCurve.points,
          closeToVectorList([
            new Vector2(0.0, 0.0),
            new Vector2(50.0, 100.0),
            new Vector2(100.0, 0.0)
          ]));
    });

    test("cubic rightSubcurveAt, t < 0.0", () {
      final curve = new CubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(150.0, 200.0),
        new Vector2(-50.0, -100.0),
        new Vector2(100.0, 0.0)
      ]);

      final result = curve.rightSubcurveAt(-0.2);
      expect(result, new TypeMatcher<CubicBezier>());
      final splitCurve = result as CubicBezier;
      expect(
          splitCurve.points,
          closeToVectorList([
            new Vector2(0.0, 0.0),
            new Vector2(150.0, 200.0),
            new Vector2(-50.0, -100.0),
            new Vector2(100.0, 0.0)
          ]));
    });

    test("quadratic rightSubcurveAt, t == 1.0", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 100.0),
        new Vector2(100.0, 0.0)
      ]);

      expect(() => curve.rightSubcurveAt(1.0), throwsArgumentError);
    });

    test("cubic rightSubcurveAt, t == 1.0", () {
      final curve = new CubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(150.0, 200.0),
        new Vector2(-50.0, -100.0),
        new Vector2(100.0, 0.0)
      ]);

      expect(() => curve.rightSubcurveAt(1.0), throwsArgumentError);
    });

    test("quadratic rightSubcurveAt, t > 1.0", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 100.0),
        new Vector2(100.0, 0.0)
      ]);

      expect(() => curve.rightSubcurveAt(1.1), throwsArgumentError);
    });

    test("cubic rightSubcurveAt, t > 1.0", () {
      final curve = new CubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(150.0, 200.0),
        new Vector2(-50.0, -100.0),
        new Vector2(100.0, 0.0)
      ]);

      expect(() => curve.rightSubcurveAt(1.1), throwsArgumentError);
    });
  });

  group("subcurveBetween", () {
    test("cubic subcurveBetween", () {
      final points = [
        new Vector2(10.0, 10.0),
        new Vector2(70.0, 95.0),
        new Vector2(25.0, 20.0),
        new Vector2(15.0, 80.0)
      ];
      final curve = new CubicBezier(points);

      final result1 = curve.subcurveBetween(0.25, 0.75);
      expect(result1, new TypeMatcher<CubicBezier>());
      final curve1 = result1 as CubicBezier;
      expect(curve1.points[0], closeToVector(new Vector2(37.5, 48.359375)));
      expect(curve1.points[1], closeToVector(new Vector2(45.625, 60.078125)));
      expect(curve1.points[2], closeToVector(new Vector2(36.25, 50.234375)));
      expect(curve1.points[3], closeToVector(new Vector2(26.875, 55.703125)));
    });

    test("quadratic subcurveBetween", () {
      final points = [
        new Vector2(70.0, 95.0),
        new Vector2(25.0, 20.0),
        new Vector2(15.0, 80.0)
      ];
      final curve = new QuadraticBezier(points);

      final result1 = curve.subcurveBetween(0.8, 0.9);
      expect(result1, new TypeMatcher<QuadraticBezier>());
      final curve1 = result1 as QuadraticBezier;
      expect(curve1.points[0],
          closeToVector(new Vector2(20.399999618530273, 61.400001525878906)));
      expect(curve1.points[1],
          closeToVector(new Vector2(18.700000762939453, 64.69999694824219)));
      expect(curve1.points[2],
          closeToVector(new Vector2(17.350000381469727, 69.3499984741211)));
    });
  });

  group("simpleSubcurves", () {
    test("cubic simpleSubcurves", () {
      final points = [
        new Vector2(105.0, -70.0),
        new Vector2(50.0, 50.0),
        new Vector2(-10.0, 80.0),
        new Vector2(135.0, 95.0)
      ];
      final curve = new CubicBezier(points);

      final result = curve.simpleSubcurves();
      expect(result, hasLength(5));

      expect(
          result[0].points,
          closeToVectorList([
            new Vector2(105.0, -70.0),
            new Vector2(103.69047546386719, -67.14286041259766),
            new Vector2(102.37812042236328, -64.33673858642578),
            new Vector2(101.06576538085938, -61.580623626708984)
          ]));

      expect(
          result[1].points,
          closeToVectorList([
            new Vector2(101.06576538085938, -61.580623626708984),
            new Vector2(85.5345458984375, -28.9631404876709),
            new Vector2(70.0033187866211, -3.3496689796447754),
            new Vector2(59.170291900634766, 16.937719345092773)
          ]));

      expect(
          result[2].points,
          closeToVectorList([
            new Vector2(59.170291900634766, 16.937719345092773),
            new Vector2(50.306907653808594, 33.53649139404297),
            new Vector2(44.588592529296875, 46.56986999511719),
            new Vector2(44.588592529296875, 56.95686721801758)
          ]));

      expect(
          result[3].points,
          closeToVectorList([
            new Vector2(44.588592529296875, 56.95687484741211),
            new Vector2(44.588592529296875, 65.52561950683594),
            new Vector2(48.48013687133789, 72.29338836669922),
            new Vector2(57.70787048339844, 77.77613830566406)
          ]));

      expect(
          result[4].points,
          closeToVectorList([
            new Vector2(57.70787048339844, 77.77613830566406),
            new Vector2(70.98680114746094, 85.66594696044922),
            new Vector2(95.31587219238281, 90.89474487304688),
            new Vector2(135.0, 95.0)
          ]));
    });

    test("quadratic simpleSubcurves", () {
      final points = [
        new Vector2(50.0, 50.0),
        new Vector2(10.0, 80.0),
        new Vector2(135.0, 85.0)
      ];
      final curve = new QuadraticBezier(points);

      final result = curve.simpleSubcurves();
      expect(result, hasLength(3));

      expect(
          result[0].points,
          closeToVectorList([
            new Vector2(50.0, 50.0),
            new Vector2(40.30303192138672, 57.272727966308594),
            new Vector2(40.30303192138672, 63.07621765136719)
          ]));

      expect(
          result[1].points,
          closeToVectorList([
            new Vector2(40.30303192138672, 63.07621765136719),
            new Vector2(40.30303192138672, 67.79154968261719),
            new Vector2(46.70454788208008, 71.53695678710938)
          ]));

      expect(
          result[2].points,
          closeToVectorList([
            new Vector2(46.70454788208008, 71.53695678710938),
            new Vector2(64.92424011230469, 82.19696807861328),
            new Vector2(135.0, 85.0)
          ]));
    });

    test("quadratic simpleSubcurves, second test", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 100.0),
        new Vector2(100.0, 0.0)
      ]);
      final result = curve.simpleSubcurves();

      expect(result, hasLength(4));

      expect(
          result[0].points,
          closeToVectorList([
            new Vector2(0.0, 0.0),
            new Vector2(24.0, 48.0),
            new Vector2(48.0, 49.91999816894531)
          ]));

      expect(
          result[1].points,
          closeToVectorList([
            new Vector2(48.0, 49.91999816894531),
            new Vector2(49.0, 50.0),
            new Vector2(50.0, 50.0)
          ]));

      expect(
          result[2].points,
          closeToVectorList([
            new Vector2(50.0, 50.0),
            new Vector2(71.5, 50.0),
            new Vector2(93.0, 13.020000457763672)
          ]));

      expect(
          result[3].points,
          closeToVectorList([
            new Vector2(93.0, 13.020000457763672),
            new Vector2(96.5, 7.0),
            new Vector2(100.0, 0.0)
          ]));
    });

    test("cubic simpleSubcurves, wavy curve", () {
      final curve = new CubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 20.0),
        new Vector2(50.0, -20.0),
        new Vector2(100.0, 0.0)
      ]);
      final result = curve.simpleSubcurves();
      expect(result, hasLength(4));
    });

    test("cubic simpleSubcurves, arched curve", () {
      final curve = new CubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 20.0),
        new Vector2(50.0, 20.0),
        new Vector2(100.0, 0.0)
      ]);
      final result = curve.simpleSubcurves();
      expect(result, hasLength(2));
    });

    test("quadratic simpleSubcurves, linear curve", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(5.0, 5.0),
        new Vector2(100.0, 100.0)
      ]);

      final result = curve.simpleSubcurves();
      expect(result, hasLength(1));

      expect(
          result[0].points,
          closeToVectorList([
            new Vector2(0.0, 0.0),
            new Vector2(5.0, 5.0),
            new Vector2(100.0, 100.0)
          ]));
    });

    test("quadratic simpleSubcurves, degenerate curve", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(250.0, 250.0),
        new Vector2(100.0, 100.0)
      ]);

      final result = curve.simpleSubcurves();
      expect(result, hasLength(2));

      expect(
          result[0].points,
          closeToVectorList([
            new Vector2(0.0, 0.0),
            new Vector2(156.25, 156.25),
            new Vector2(156.25, 156.25)
          ]));

      expect(
          result[1].points,
          closeToVectorList([
            new Vector2(156.25, 156.25),
            new Vector2(156.25, 156.25),
            new Vector2(100.0, 100.0)
          ]));
    });
  });
}
