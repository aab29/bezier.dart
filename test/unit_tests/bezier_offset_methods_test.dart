import "../testing_tools/testing_tools.dart";

void main() {
  group("scaledCurve", () {
    test("cubic scaledCurve", () {
      final points = [
        Vector2(0.0, 0.0),
        Vector2(5.0, 15.0),
        Vector2(5.0, 30.0),
        Vector2(0.0, 45.0)
      ];
      final curve = CubicBezier(points);

      final result = curve.scaledCurve(1.0);
      expect(result, TypeMatcher<CubicBezier>());
      final scaledCurve = result as CubicBezier;

      expect(
          scaledCurve.points,
          closeToVectorList([
            Vector2(-0.9486833214759827, 0.3162277638912201),
            Vector2(3.981043815612793, 15.105409622192383),
            Vector2(3.981043815612793, 29.894590377807617),
            Vector2(-0.9486833214759827, 44.683773040771484)
          ]));
    });

    test("quadratic scaledCurve", () {
      final points = [
        Vector2(10.0, 0.0),
        Vector2(30.0, 1.0),
        Vector2(60.0, 0.0)
      ];
      final curve = QuadraticBezier(points);

      final result = curve.scaledCurve(10.0);
      expect(result, TypeMatcher<QuadraticBezier>());
      final scaledCurve = result as QuadraticBezier;

      expect(
          scaledCurve.points,
          closeToVectorList([
            Vector2(9.50062370300293, 9.987524032592773),
            Vector2(29.833541870117188, 11.004169464111328),
            Vector2(60.33314895629883, 9.9944486618042)
          ]));
    });

    test("quadratic scaledCurve, linear curve", () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(50.0, 50.0), Vector2(100.0, 100.0)]);

      final scaledCurve = curve.scaledCurve(10.0);
      expect(scaledCurve, TypeMatcher<QuadraticBezier>());

      expect(
          scaledCurve.points,
          closeToVectorList([
            Vector2(-7.071067810058594, 7.071067810058594),
            Vector2(42.928932189941406, 57.071067810058594),
            Vector2(92.9289321899414, 107.0710678100586)
          ]));
    });

    test("cubic scaledCurve, parallel endpoint normals", () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(0.0, 100.0),
        Vector2(100.0, -100.0),
        Vector2(100.0, 0.0)
      ]);

      final scaledCurve = curve.scaledCurve(10.0);
      expect(scaledCurve, TypeMatcher<CubicBezier>());

      expect(
          scaledCurve.points,
          closeToVectorList([
            Vector2(-10.0, 0.0),
            Vector2(-10.0, 120.0),
            Vector2(90.0, -80.0),
            Vector2(90.0, 0.0)
          ]));
    });

    test("cubic scaledCurve, parallel endpoint normals, another test", () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(50.0, 0.0),
        Vector2(50.0, 100.0),
        Vector2(100.0, 100.0)
      ]);

      final scaledCurve = curve.scaledCurve(10.0);
      expect(scaledCurve, TypeMatcher<CubicBezier>());

      expect(
          scaledCurve.points,
          closeToVectorList([
            Vector2(0.0, 10.0),
            Vector2(50.0, 10.0),
            Vector2(50.0, 110.0),
            Vector2(100.0, 110.0)
          ]));
    });

    test("cubic scaledCurve, anti-parallel endpoint normals", () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(0.0, 100.0),
        Vector2(100.0, 100.0),
        Vector2(100.0, 0.0)
      ]);

      final scaledCurve = curve.scaledCurve(10.0);
      expect(scaledCurve, TypeMatcher<CubicBezier>());

      expect(
          scaledCurve.points,
          closeToVectorList([
            Vector2(-10.0, 0.0),
            Vector2(-10.0, 120.0),
            Vector2(110.0, 120.0),
            Vector2(110.0, 0.0)
          ]));
    });

    test(
        "cubic scaledCurve, non-linear curve with first control point overlapping start point",
        () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(0.0, 0.0),
        Vector2(50.0, 100.0),
        Vector2(100.0, 0.0)
      ]);

      final scaledCurve = curve.scaledCurve(10.0);
      expect(scaledCurve, TypeMatcher<CubicBezier>());
      expect(
          scaledCurve.points,
          closeToVectorList([
            Vector2(-8.9442720413208, 4.4721360206604),
            Vector2(-8.9442720413208, 4.4721360206604),
            Vector2(50.0, 122.36068725585938),
            Vector2(108.94427490234375, 4.4721360206604)
          ]));
    });

    test(
        "cubic scaledCurve, non-linear curve with second control point overlapping end point",
        () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(50.0, 100.0),
        Vector2(100.0, 0.0),
        Vector2(100.0, 0.0)
      ]);

      final scaledCurve = curve.scaledCurve(10.0);
      expect(scaledCurve, TypeMatcher<CubicBezier>());
      expect(
          scaledCurve.points,
          closeToVectorList([
            Vector2(-8.9442720413208, 4.4721360206604),
            Vector2(50.0, 122.36067962646484),
            Vector2(108.94427490234375, 4.4721360206604),
            Vector2(108.94427490234375, 4.4721360206604)
          ]));
    });

    test(
        "quadratic scaledCurve, linear curve with control point overlapping start point",
        () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(0.0, 0.0), Vector2(100.0, 0.0)]);

      final scaledCurve = curve.scaledCurve(10.0);
      expect(scaledCurve, TypeMatcher<QuadraticBezier>());
      expect(
          scaledCurve.points,
          closeToVectorList(
              [Vector2(0.0, 10.0), Vector2(0.0, 10.0), Vector2(100.0, 10.0)]));
    });

    test(
        "cubic scaledCurve, linear curve with first control point overlapping start point",
        () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(0.0, 0.0),
        Vector2(50.0, 0.0),
        Vector2(100.0, 0.0),
      ]);

      final scaledCurve = curve.scaledCurve(10.0);
      expect(scaledCurve, TypeMatcher<CubicBezier>());
      expect(
          scaledCurve.points,
          closeToVectorList([
            Vector2(0.0, 10.0),
            Vector2(0.0, 10.0),
            Vector2(50.0, 10.0),
            Vector2(100.0, 10.0)
          ]));
    });
  });

  group("toCubicBezier", () {
    test("quadratic toCubicBezier", () {
      final points = [
        Vector2(10.0, 10.0),
        Vector2(70.0, 95.0),
        Vector2(15.0, 80.0)
      ];
      final curve = QuadraticBezier(points);

      final cubicCurve = curve.toCubicBezier();

      expect(cubicCurve, TypeMatcher<CubicBezier>());

      expect(
          cubicCurve.points,
          closeToVectorList([
            Vector2(10.0, 10.0),
            Vector2(50.0, 66.66666412353516),
            Vector2(51.66666793823242, 90.0),
            Vector2(15.0, 80.0)
          ]));
    });
  });

  group("offsetCurve", () {
    test("cubic offsetCurve", () {
      final points = [
        Vector2(10.0, 10.0),
        Vector2(15.0, 95.0),
        Vector2(20.0, 95.0),
        Vector2(25.0, 10.0)
      ];
      final curve = CubicBezier(points);

      final offsetCurves = curve.offsetCurve(1.0);
      expect(offsetCurves, hasLength(4));

      expect(
          offsetCurves[0].points,
          closeToVectorList([
            Vector2(9.001725196838379, 10.058722496032715),
            Vector2(11.485787391662598, 52.28776931762695),
            Vector2(14.362993240356445, 73.33004760742188),
            Vector2(16.82067108154297, 74.58346557617188)
          ]));

      expect(
          offsetCurves[1].points,
          closeToVectorList([
            Vector2(16.820711135864258, 74.58348083496094),
            Vector2(17.047142028808594, 74.69894409179688),
            Vector2(17.274578094482422, 74.75),
            Vector2(17.5, 74.75)
          ]));

      expect(
          offsetCurves[2].points,
          closeToVectorList([
            Vector2(17.5, 74.75),
            Vector2(17.981765747070312, 74.75),
            Vector2(18.57462501525879, 74.53295135498047),
            Vector2(19.111936569213867, 73.61951446533203)
          ]));

      expect(
          offsetCurves[3].points,
          closeToVectorList([
            Vector2(19.111934661865234, 73.61951446533203),
            Vector2(21.37809944152832, 69.76703643798828),
            Vector2(23.730546951293945, 48.61006546020508),
            Vector2(25.998273849487305, 10.058722496032715)
          ]));
    });

    test("quadratic offsetCurve", () {
      final points = [
        Vector2(10.0, 10.0),
        Vector2(20.0, 20.0),
        Vector2(15.0, 30.0),
      ];
      final curve = QuadraticBezier(points);

      final offsetCurves = curve.offsetCurve(10.0);
      expect(offsetCurves, hasLength(2));

      expect(
          offsetCurves[0].points,
          closeToVectorList([
            Vector2(2.9289321899414062, 17.071067810058594),
            Vector2(6.060064315795898, 20.202199935913086),
            Vector2(6.666666030883789, 23.333332061767578)
          ]));

      expect(
          offsetCurves[1].points,
          closeToVectorList([
            Vector2(6.666666030883789, 23.333332061767578),
            Vector2(6.666666030883789, 24.44444465637207),
            Vector2(6.055727005004883, 25.52786636352539)
          ]));
    });

    test("linear cubic offsetCurve", () {
      final points = [
        Vector2(100.0, 100.0),
        Vector2(100.0, 200.0),
        Vector2(100.0, 300.0),
        Vector2(100.0, 400.0),
      ];
      final curve = CubicBezier(points);

      final offsetCurves = curve.offsetCurve(1000.0);
      expect(offsetCurves, hasLength(1));

      expect(
          offsetCurves[0].points,
          closeToVectorList([
            Vector2(-900.0, 100.0),
            Vector2(-900.0, 200.0),
            Vector2(-900.0, 300.0),
            Vector2(-900.0, 400.0)
          ]));
    });

    test("linear quadratic offsetCurve", () {
      final points = [
        Vector2(0.0, 0.0),
        Vector2(20.0, 5.0),
        Vector2(40.0, 10.0)
      ];
      final curve = QuadraticBezier(points);

      final offsetCurves = curve.offsetCurve(5.0);
      expect(offsetCurves, hasLength(1));

      expect(
          offsetCurves[0].points,
          closeToVectorList([
            Vector2(-1.212678074836731, 4.850712299346924),
            Vector2(18.787321090698242, 9.850712776184082),
            Vector2(38.787322998046875, 14.850712776184082)
          ]));
    });
  });
}
