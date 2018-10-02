import "../testing_tools/testing_tools.dart";

void main() {
  group("scaledCurve", () {
    test("cubic scaledCurve", () {
      final points = [
        new Vector2(0.0, 0.0),
        new Vector2(5.0, 15.0),
        new Vector2(5.0, 30.0),
        new Vector2(0.0, 45.0)
      ];
      final curve = new BDCubicBezier(points);

      final result = curve.scaledCurve(1.0);
      expect(result, new TypeMatcher<BDCubicBezier>());
      final scaledCurve = result as BDCubicBezier;

      expect(scaledCurve.points, closeToVectorList([
        new Vector2(-0.9486833214759827, 0.3162277638912201),
        new Vector2(3.981043815612793, 15.105409622192383),
        new Vector2(3.981043815612793, 29.894590377807617),
        new Vector2(-0.9486833214759827, 44.683773040771484)
      ]));

    });

    test("quadratic scaledCurve", () {
      final points = [
        new Vector2(10.0, 0.0),
        new Vector2(30.0, 1.0),
        new Vector2(60.0, 0.0)
      ];
      final curve = new QuadraticBezier(points);

      final result = curve.scaledCurve(10.0);
      expect(result, new TypeMatcher<QuadraticBezier>());
      final scaledCurve = result as QuadraticBezier;

      expect(scaledCurve.points, closeToVectorList([
        new Vector2(9.50062370300293, 9.987524032592773),
        new Vector2(29.833541870117188, 11.004169464111328),
        new Vector2(60.33314895629883, 9.9944486618042)
      ]));

    });

    test("quadratic scaledCurve, linear curve", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 50.0),
        new Vector2(100.0, 100.0)
      ]);

      final scaledCurve = curve.scaledCurve(10.0);
      expect(scaledCurve, new TypeMatcher<QuadraticBezier>());

      expect(scaledCurve.points, closeToVectorList([
        new Vector2(-7.071067810058594, 7.071067810058594),
        new Vector2(42.928932189941406, 57.071067810058594),
        new Vector2(92.9289321899414, 107.0710678100586)
      ]));
    });

    test("cubic scaledCurve, parallel endpoint normals", () {
      final curve = new BDCubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(0.0, 100.0),
        new Vector2(100.0, -100.0),
        new Vector2(100.0, 0.0)
      ]);

      final scaledCurve = curve.scaledCurve(10.0);
      expect(scaledCurve, new TypeMatcher<BDCubicBezier>());

      expect(scaledCurve.points, closeToVectorList([
        new Vector2(-10.0, 0.0),
        new Vector2(-10.0, 120.0),
        new Vector2(90.0, -80.0),
        new Vector2(90.0, 0.0)
      ]));
    });

    test("cubic scaledCurve, parallel endpoint normals, another test", () {
      final curve = new BDCubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 0.0),
        new Vector2(50.0, 100.0),
        new Vector2(100.0, 100.0)
      ]);

      final scaledCurve = curve.scaledCurve(10.0);
      expect(scaledCurve, new TypeMatcher<BDCubicBezier>());

      expect(scaledCurve.points, closeToVectorList([
        new Vector2(0.0, 10.0),
        new Vector2(50.0, 10.0),
        new Vector2(50.0, 110.0),
        new Vector2(100.0, 110.0)
      ]));
    });

    test("cubic scaledCurve, anti-parallel endpoint normals", () {
      final curve = new BDCubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(0.0, 100.0),
        new Vector2(100.0, 100.0),
        new Vector2(100.0, 0.0)
      ]);

      final scaledCurve = curve.scaledCurve(10.0);
      expect(scaledCurve, new TypeMatcher<BDCubicBezier>());

      expect(scaledCurve.points, closeToVectorList([
        new Vector2(-10.0, 0.0),
        new Vector2(-10.0, 120.0),
        new Vector2(110.0, 120.0),
        new Vector2(110.0, 0.0)
      ]));
    });

    test("cubic scaledCurve, non-linear curve with first control point overlapping start point", () {
      final curve = new BDCubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 100.0),
        new Vector2(100.0, 0.0)
      ]);

      final scaledCurve = curve.scaledCurve(10.0);
      expect(scaledCurve, new TypeMatcher<BDCubicBezier>());
      expect(scaledCurve.points, closeToVectorList([
        new Vector2(-8.9442720413208, 4.4721360206604),
        new Vector2(-8.9442720413208, 4.4721360206604),
        new Vector2(50.0, 122.36068725585938),
        new Vector2(108.94427490234375, 4.4721360206604)
      ]));
    });

    test("cubic scaledCurve, non-linear curve with second control point overlapping end point", () {
      final curve = new BDCubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 100.0),
        new Vector2(100.0, 0.0),
        new Vector2(100.0, 0.0)
      ]);

      final scaledCurve = curve.scaledCurve(10.0);
      expect(scaledCurve, new TypeMatcher<BDCubicBezier>());
      expect(scaledCurve.points, closeToVectorList([
        new Vector2(-8.9442720413208, 4.4721360206604),
        new Vector2(50.0, 122.36067962646484),
        new Vector2(108.94427490234375, 4.4721360206604),
        new Vector2(108.94427490234375, 4.4721360206604)
      ]));
    });

    test("quadratic scaledCurve, linear curve with control point overlapping start point", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(0.0, 0.0),
        new Vector2(100.0, 0.0)
      ]);

      final scaledCurve = curve.scaledCurve(10.0);
      expect(scaledCurve, new TypeMatcher<QuadraticBezier>());
      expect(scaledCurve.points, closeToVectorList([
        new Vector2(0.0, 10.0),
        new Vector2(0.0, 10.0),
        new Vector2(100.0, 10.0)
      ]));
    });

    test("cubic scaledCurve, linear curve with first control point overlapping start point", () {
      final curve = new BDCubicBezier([
        new Vector2(0.0, 0.0),
        new Vector2(0.0, 0.0),
        new Vector2(50.0, 0.0),
        new Vector2(100.0, 0.0),
      ]);

      final scaledCurve = curve.scaledCurve(10.0);
      expect(scaledCurve, new TypeMatcher<BDCubicBezier>());
      expect(scaledCurve.points, closeToVectorList([
        new Vector2(0.0, 10.0),
        new Vector2(0.0, 10.0),
        new Vector2(50.0, 10.0),
        new Vector2(100.0, 10.0)
      ]));
    });
  });

  group("toCubicBezier", () {
    test("quadratic toCubicBezier", () {
      final points = [
        new Vector2(10.0, 10.0),
        new Vector2(70.0, 95.0),
        new Vector2(15.0, 80.0)
      ];
      final curve = new QuadraticBezier(points);

      final cubicCurve = curve.toCubicBezier();

      expect(cubicCurve, new TypeMatcher<BDCubicBezier>());

      expect(cubicCurve.points, closeToVectorList([
        new Vector2(10.0, 10.0),
        new Vector2(50.0, 66.66666412353516),
        new Vector2(51.66666793823242, 90.0),
        new Vector2(15.0, 80.0)
      ]));
    });

  });

  group("offsetCurve", () {
    test("cubic offsetCurve", () {
      final points = [
        new Vector2(10.0, 10.0),
        new Vector2(15.0, 95.0),
        new Vector2(20.0, 95.0),
        new Vector2(25.0, 10.0)
      ];
      final curve = new BDCubicBezier(points);

      final offsetCurves = curve.offsetCurve(1.0);
      expect(offsetCurves, hasLength(4));

      expect(offsetCurves[0].points, closeToVectorList([
        new Vector2(9.001725196838379, 10.058722496032715),
        new Vector2(11.485787391662598, 52.28776931762695),
        new Vector2(14.362993240356445, 73.33004760742188),
        new Vector2(16.82067108154297, 74.58346557617188)
      ]));

      expect(offsetCurves[1].points, closeToVectorList([
        new Vector2(16.820711135864258, 74.58348083496094),
        new Vector2(17.047142028808594, 74.69894409179688),
        new Vector2(17.274578094482422, 74.75),
        new Vector2(17.5, 74.75)
      ]));

      expect(offsetCurves[2].points, closeToVectorList([
        new Vector2(17.5, 74.75),
        new Vector2(17.981765747070312, 74.75),
        new Vector2(18.57462501525879, 74.53295135498047),
        new Vector2(19.111936569213867, 73.61951446533203)
      ]));

      expect(offsetCurves[3].points, closeToVectorList([
        new Vector2(19.111934661865234, 73.61951446533203),
        new Vector2(21.37809944152832, 69.76703643798828),
        new Vector2(23.730546951293945, 48.61006546020508),
        new Vector2(25.998273849487305, 10.058722496032715)
      ]));

    });

    test("quadratic offsetCurve", () {
      final points = [
        new Vector2(10.0, 10.0),
        new Vector2(20.0, 20.0),
        new Vector2(15.0, 30.0),
      ];
      final curve = new QuadraticBezier(points);

      final offsetCurves = curve.offsetCurve(10.0);
      expect(offsetCurves, hasLength(2));

      expect(offsetCurves[0].points, closeToVectorList([
        new Vector2(2.9289321899414062, 17.071067810058594),
        new Vector2(6.060064315795898, 20.202199935913086),
        new Vector2(6.666666030883789, 23.333332061767578)
      ]));

      expect(offsetCurves[1].points, closeToVectorList([
        new Vector2(6.666666030883789, 23.333332061767578),
        new Vector2(6.666666030883789, 24.44444465637207),
        new Vector2(6.055727005004883, 25.52786636352539)
      ]));

    });

    test("linear cubic offsetCurve", () {
      final points = [
        new Vector2(100.0, 100.0),
        new Vector2(100.0, 200.0),
        new Vector2(100.0, 300.0),
        new Vector2(100.0, 400.0),
      ];
      final curve = new BDCubicBezier(points);

      final offsetCurves = curve.offsetCurve(1000.0);
      expect(offsetCurves, hasLength(1));

      expect(offsetCurves[0].points, closeToVectorList([
        new Vector2(-900.0, 100.0),
        new Vector2(-900.0, 200.0),
        new Vector2(-900.0, 300.0),
        new Vector2(-900.0, 400.0)
      ]));
    });

    test("linear quadratic offsetCurve", () {
      final points = [
        new Vector2(0.0, 0.0),
        new Vector2(20.0, 5.0),
        new Vector2(40.0, 10.0)
      ];
      final curve = new QuadraticBezier(points);

      final offsetCurves = curve.offsetCurve(5.0);
      expect(offsetCurves, hasLength(1));

      expect(offsetCurves[0].points, closeToVectorList([
        new Vector2(-1.212678074836731, 4.850712299346924),
        new Vector2(18.787321090698242, 9.850712776184082),
        new Vector2(38.787322998046875, 14.850712776184082)
      ]));

    });
  });
}
