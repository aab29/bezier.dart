import "../testing_tools/testing_tools.dart";

void main() {
  group("constructor", () {
    test("constructor with three-entry look up table", () {
      final lookUpTable = <Vector2>[
        new Vector2(0.0, 0.0),
        new Vector2(2.0, 0.0),
        new Vector2(3.0, 0.0)
      ];
      final object = new EvenSpacer(lookUpTable);
      expect(object, new TypeMatcher<EvenSpacer>());
    });

    test("constructor with two-entry look up table", () {
      final lookUpTable = <Vector2>[
        new Vector2(0.0, 0.0),
        new Vector2(100.0, 100.0)
      ];

      final object = new EvenSpacer(lookUpTable);
      expect(object, new TypeMatcher<EvenSpacer>());
    });

    test("constructor throws error with one-entry look up table", () {
      final lookUpTable = <Vector2>[
        new Vector2(100.0, 100.0)
      ];
      expect(() => new EvenSpacer(lookUpTable),
          throwsA(new TypeMatcher<Error>()));
    });

    test("constructor throws error with empty look up table", () {
      expect(() => new EvenSpacer([]), throwsA(new TypeMatcher<Error>()));
    });
  });

  group("arcLength getter", () {
    test("arcLength, two-entry look up table", () {
      final arcLengthCalculator = new EvenSpacer([
        new Vector2(0.0, 0.0),
        new Vector2(100.0, 100.0)
      ]);
      final result = arcLengthCalculator.arcLength;
      expect(result, closeToDouble(141.4213562373095));
    });

    test("arcLength, three-entry look up table", () {
      final arcLengthCalculator = new EvenSpacer([
        new Vector2(0.0, 0.0),
        new Vector2(3.0, 0.0),
        new Vector2(3.0, 1.0)
      ]);
      final result = arcLengthCalculator.arcLength;
      expect(result, closeToDouble(4.0));
    });
  });

  group("evenTValueAt()", () {
    test("evenTValueAt(), portion at border of or outside normal range", () {
      final arcLengthCalculator = new EvenSpacer([
        new Vector2(0.0, 0.0),
        new Vector2(3.0, 0.0),
        new Vector2(3.0, 1.0)
      ]);

      final result1 = arcLengthCalculator.evenTValueAt(-1.0);
      expect(result1, closeToDouble(0.0));

      final result2 = arcLengthCalculator.evenTValueAt(1.25);
      expect(result2, closeToDouble(1.0));

      final result3 = arcLengthCalculator.evenTValueAt(0.0);
      expect(result3, closeToDouble(0.0));

      final result4 = arcLengthCalculator.evenTValueAt(1.0);
      expect(result4, closeToDouble(1.0));
    });

    test("evenTValueAt(), portion in normal range, three-entry look up table", () {
      final arcLengthCalculator = new EvenSpacer([
        new Vector2(0.0, 0.0),
        new Vector2(3.0, 0.0),
        new Vector2(3.0, 1.0)
      ]);

      expect(arcLengthCalculator.evenTValueAt(0.1), closeToDouble(0.06666666666));
      expect(arcLengthCalculator.evenTValueAt(0.25), closeToDouble(0.16666666666));
      expect(arcLengthCalculator.evenTValueAt(0.375), closeToDouble(0.25));
      expect(arcLengthCalculator.evenTValueAt(0.5), closeToDouble(0.33333333333));
      expect(arcLengthCalculator.evenTValueAt(0.75), closeToDouble(0.5));
      expect(arcLengthCalculator.evenTValueAt(0.875), closeToDouble(0.75));
      expect(arcLengthCalculator.evenTValueAt(0.9), closeToDouble(0.8));
    });
  });

  group("evenTValues", () {
    test("default parametersCount", () {
      final arcLengthCalculator = new EvenSpacer([
        new Vector2(0.0, 0.0),
        new Vector2(3.0, 0.0),
        new Vector2(3.0, 1.0)
      ]);

      final result = arcLengthCalculator.evenTValues();
      expect(result, hasLength(51));

      expect(result[0], closeToDouble(0.0));
      expect(result[5], closeToDouble(0.066666666666));
      expect(result[25], closeToDouble(0.333333333333));
      expect(result[45], closeToDouble(0.8));
      expect(result[50], closeToDouble(1.0));
    });

    test("parametersCount of 100", () {
      final arcLengthCalculator = new EvenSpacer([
        new Vector2(0.0, 0.0),
        new Vector2(3.0, 0.0),
        new Vector2(3.0, 1.0)
      ]);

      final result = arcLengthCalculator.evenTValues(parametersCount: 100);
      expect(result, hasLength(101));

      expect(result[0], closeToDouble(0.0));
      expect(result[1], closeToDouble(0.006666666666));
      expect(result[10], closeToDouble(0.066666666666));
      expect(result[25], closeToDouble(0.166666666666));
      expect(result[50], closeToDouble(0.333333333333));
      expect(result[75], closeToDouble(0.5));
      expect(result[90], closeToDouble(0.8));
      expect(result[99], closeToDouble(0.98));
      expect(result[100], closeToDouble(1.0));
    });
  });
}
