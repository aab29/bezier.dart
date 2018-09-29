import "package:test/test.dart";

const defaultDelta = 0.00001;

Matcher closeToDouble(double value, [double delta = defaultDelta]) =>
    closeTo(value, delta);
