import 'dart:math';

/// Describes intersections between two Bézier curves.
class Intersection {
  /// Parameter value on the first curve of the intersection.
  final double t1;

  /// Parameter value on the second curve of the intersection.
  final double t2;

  /// Constructs an intersection result with parameter values [t1] and [t2].
  Intersection(this.t1, this.t2);

  /// Returns the maximum difference between the parameter value properties of [this]
  /// and [other].
  double maxTValueDifference(Intersection other) {
    final t1Difference = (t1 - other.t1).abs();
    final t2Difference = (t2 - other.t2).abs();
    return max(t1Difference, t2Difference);
  }

  /// True if the difference of parameter values between [this] and [other] is
  /// less than or equal to [tValueDifference].
  bool isWithinTValueOf(Intersection other, double tValueDifference) =>
      (maxTValueDifference(other) <= tValueDifference);

  @override
  String toString() => 'BDIntersection($t1, $t2)';
}
