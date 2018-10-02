import "../testing_tools/testing_tools.dart";

void main() {
  group("boundingBox", () {
    test("cubic boundingBox", () {
      final points = [
        new Vector2(10.0, -10.0),
        new Vector2(70.0, 95.0),
        new Vector2(-25.0, 20.0),
        new Vector2(15.0, 80.0)
      ];
      final curve = new BDCubicBezier(points);

      final box = curve.boundingBox;
      expect(box, new TypeMatcher<Aabb2>());

      expect(box.min, closeToVector(new Vector2(4.824948310852051, -10.0)));
      expect(box.center, closeToVector(new Vector2(17.648632526397705, 35.0)));
      expect(box.max, closeToVector(new Vector2(30.47231674194336, 80.0)));
    });

    test("quadratic boundingBox", () {
      final points = [
        new Vector2(65.0, 95.0),
        new Vector2(-25.0, -20.0),
        new Vector2(15.0, 80.0)
      ];
      final curve = new QuadraticBezier(points);

      final box = curve.boundingBox;
      expect(box, new TypeMatcher<Aabb2>());

      expect(box.min, closeToVector(new Vector2(2.692307710647583, 33.488372802734375)));
      expect(box.center, closeToVector(new Vector2(33.84615385532379, 64.24418640136719)));
      expect(box.max, closeToVector(new Vector2(65.0, 95.0)));
    });
  });

  group("overlaps", () {
    test("cubic overlaps with other cubic curve", () {
      final curveA = new BDCubicBezier([
        new Vector2(-10.0, -10.0),
        new Vector2(-70.0, -95.0),
        new Vector2(-25.0, -20.0),
        new Vector2(-15.0, -80.0)
      ]);

      final curveB = new BDCubicBezier([
        new Vector2(105.0, 70.0),
        new Vector2(50.0, 50.0),
        new Vector2(50.0, 80.0),
        new Vector2(135.0, 95.0)
      ]);

      final curveC = new BDCubicBezier([
        new Vector2(-80.0, 65.0),
        new Vector2(90.0, -55.0),
        new Vector2(110.0, -90.0),
        new Vector2(40.0, 5.0)
      ]);

      expect(curveA.overlaps(curveB), isFalse);
      expect(curveB.overlaps(curveA), isFalse);

      expect(curveA.overlaps(curveC), isTrue);
      expect(curveC.overlaps(curveA), isTrue);

      expect(curveB.overlaps(curveC), isTrue);
      expect(curveC.overlaps(curveB), isTrue);
    });

    test("quadratic overlaps with other quadratic curve", () {
      final curveA = new QuadraticBezier([
        new Vector2(-70.0, -95.0),
        new Vector2(-25.0, -20.0),
        new Vector2(-15.0, -80.0)
      ]);

      final curveB = new QuadraticBezier([
        new Vector2(105.0, 70.0),
        new Vector2(50.0, 50.0),
        new Vector2(50.0, 80.0)
      ]);

      final curveC = new QuadraticBezier([
        new Vector2(-80.0, 65.0),
        new Vector2(90.0, -55.0),
        new Vector2(110.0, -90.0)
      ]);

      expect(curveA.overlaps(curveB), isFalse);
      expect(curveB.overlaps(curveA), isFalse);

      expect(curveA.overlaps(curveC), isTrue);
      expect(curveC.overlaps(curveA), isTrue);

      expect(curveB.overlaps(curveC), isTrue);
      expect(curveC.overlaps(curveB), isTrue);
    });

    test("quadratic overlaps with quadratic and cubic curves", () {
      final curveA = new QuadraticBezier([
        new Vector2(-70.0, -95.0),
        new Vector2(-25.0, -20.0),
        new Vector2(-15.0, 5.0)
      ]);

      final curveB = new QuadraticBezier([
        new Vector2(105.0, 70.0),
        new Vector2(50.0, 50.0),
        new Vector2(50.0, 80.0)
      ]);

      final curveC = new BDCubicBezier([
        new Vector2(-80.0, 65.0),
        new Vector2(90.0, -55.0),
        new Vector2(110.0, -90.0),
        new Vector2(40.0, 0.0)
      ]);

      expect(curveA.overlaps(curveB), isFalse);
      expect(curveB.overlaps(curveA), isFalse);

      expect(curveA.overlaps(curveC), isTrue);
      expect(curveC.overlaps(curveA), isTrue);

      expect(curveB.overlaps(curveC), isTrue);
      expect(curveC.overlaps(curveB), isTrue);
    });
  });

  group("extremaOnX", () {
    test("cubic extremaOnX", () {
      final points = [
        new Vector2(10.0, 10.0),
        new Vector2(70.0, 95.0),
        new Vector2(25.0, 20.0),
        new Vector2(15.0, 80.0)
      ];
      final curve = new BDCubicBezier(points);

      final result = curve.extremaOnX;
      expect(result, new TypeMatcher<List<double>>());

      expect(result, hasLength(2));
      expect(result[0], closeToDouble(0.38403747264430005));
      expect(result[1], closeToDouble(0.75));
    });

    test("quadratic extremaOnX", () {
      final points = [
        new Vector2(10.0, 10.0),
        new Vector2(70.0, 95.0),
        new Vector2(25.0, 20.0)
      ];
      final curve = new QuadraticBezier(points);

      final result = curve.extremaOnX;
      expect(result, new TypeMatcher<List<double>>());

      expect(result, hasLength(1));
      expect(result[0], closeToDouble(0.5714285714285714));
    });
  });

  group("extremaOnY", () {
    test("cubic extremaOnY", () {
      final points = [
        new Vector2(10.0, 10.0),
        new Vector2(70.0, 95.0),
        new Vector2(25.0, 20.0),
        new Vector2(15.0, 80.0)
      ];
      final curve = new BDCubicBezier(points);

      final result = curve.extremaOnY;
      expect(result, new TypeMatcher<List<double>>());

      expect(result, hasLength(3));
      expect(result[0], closeToDouble(0.4647021068651553));
      expect(result[1], closeToDouble(0.5423728813559322));
      expect(result[2], closeToDouble(0.6200436558467092));
    });

    test("quadratic extremaOnY", () {
      final points = [
        new Vector2(10.0, 10.0),
        new Vector2(70.0, 95.0),
        new Vector2(25.0, 20.0)
      ];
      final curve = new QuadraticBezier(points);

      final result = curve.extremaOnY;
      expect(result, new TypeMatcher<List<double>>());

      expect(result, hasLength(1));
      expect(result[0], closeToDouble(0.53125));
    });
  });

  group("extrema", () {
    test("cubic extrema", () {
      final points = [
        new Vector2(10.0, 10.0),
        new Vector2(70.0, 95.0),
        new Vector2(25.0, 20.0),
        new Vector2(15.0, 80.0)
      ];
      final curve = new BDCubicBezier(points);

      final result = curve.extrema;
      expect(result, new TypeMatcher<List<double>>());

      expect(result, hasLength(5));
      expect(result[0], closeToDouble(0.38403747264430005));
      expect(result[1], closeToDouble(0.4647021068651553));
      expect(result[2], closeToDouble(0.5423728813559322));
      expect(result[3], closeToDouble(0.6200436558467092));
      expect(result[4], closeToDouble(0.75));
    });

    test("quadratic extrema", () {
      final points = [
        new Vector2(10.0, 10.0),
        new Vector2(70.0, 95.0),
        new Vector2(25.0, 20.0)
      ];
      final curve = new QuadraticBezier(points);

      final result = curve.extrema;
      expect(result, new TypeMatcher<List<double>>());

      expect(result, hasLength(2));
      expect(result[0], closeToDouble(0.53125));
      expect(result[1], closeToDouble(0.5714285714285714));
    });

    test("quadratic extrema, degenerate curve", () {
      final curve = new QuadraticBezier([
        new Vector2(0.0, 0.0),
        new Vector2(100.0, 0.0),
        new Vector2(50.0, 0.0)
      ]);

      final result = curve.extrema;
      expect(result, new TypeMatcher<List<double>>());

      expect(result, hasLength(1));
      expect(result[0], closeToDouble(0.6666666666666666));
    });
  });
}
