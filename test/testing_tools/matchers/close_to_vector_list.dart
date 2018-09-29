import "package:test/test.dart";

import "package:vector_math/vector_math.dart";

import "close_to_double.dart";
import "close_to_vector.dart";

class CloseToVectorListMatcher extends Matcher {

  List<Vector> vectors;
  double delta;

  CloseToVectorListMatcher(this.vectors, [this.delta = defaultDelta]);

  @override
  bool matches(item, Map matchState) {

    if (!(item is List<Vector>)) {
      return false;
    }

    List<Vector> otherVectors = item;

    final length = vectors.length;
    if (length != otherVectors.length) {
      return false;
    }

    for (var index = 0; index < length; index++) {
      final expectedValue = vectors[index];
      final actualValue = otherVectors[index];

      final matcher = closeToVector(expectedValue, delta);
      if (!(matcher.matches(actualValue, matchState))) {
        return false;
      }
    }

    return true;
  }

  @override
  Description describe(Description description) => description.addDescriptionOf(vectors);

}

Matcher closeToVectorList(List<Vector> vectors, [double delta = defaultDelta]) =>
    new CloseToVectorListMatcher(vectors, delta);
