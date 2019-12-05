import "package:test/test.dart";

import "package:vector_math/vector_math.dart";

import "close_to_double.dart";

class CloseToVectorMatcher extends Matcher {
  Vector vector;
  double delta;

  CloseToVectorMatcher(this.vector, [this.delta = defaultDelta]);

  @override
  bool matches(item, Map matchState) {
    if (!(item is Vector)) {
      return false;
    }

    Vector otherVector = item;

    final length = vector.storage.length;
    if (length != otherVector.storage.length) {
      return false;
    }

    for (var index = 0; index < length; index++) {
      final expectedValue = vector.storage[index];
      final actualValue = otherVector.storage[index];

      final matcher = closeToDouble(expectedValue, delta);
      if (!(matcher.matches(actualValue, matchState))) {
        return false;
      }
    }

    return true;
  }

  @override
  Description describe(Description description) =>
      description.addDescriptionOf(vector);
}

Matcher closeToVector(Vector vector, [double delta = defaultDelta]) =>
    CloseToVectorMatcher(vector, delta);
