import "package:vector_math/vector_math.dart";

import "package:bezier/bezier.dart";

/// Concrete class of quadratic Bézier curves.
class QuadraticBezier extends Bezier {

  /// Constructs a quadratic Bézier curve from a [List] of [Vector2].
  QuadraticBezier(List<Vector2> points) : super(points) {
    if (points.length != 3) {
      throw(new ArgumentError("Quadratic Bézier curves require exactly three points"));
    }
  }

  @override
  int get order => 2;

  @override
  Vector2 pointAt(double t) {
    final t2 = t * t;
    final mt = 1.0 - t;
    final mt2 = mt * mt;

    final a = mt2;
    final b = 2.0 * mt * t;
    final c = t2;

    final point = new Vector2.copy(startPoint);
    point.scale(a);
    point.addScaled(points[1], b);
    point.addScaled(points[2], c);

    return point;
  }

  @override
  Vector2 derivativeAt(double t, {List<Vector2> cachedFirstOrderDerivativePoints}) {
    final derivativePoints = cachedFirstOrderDerivativePoints ?? firstOrderDerivativePoints;
    final result = new Vector2.zero();
    Vector2.mix(derivativePoints[0], derivativePoints[1], t, result);
    return result;
  }

  /// Returns a [CubicBezier] instance with the same start and end points as [this]
  /// and control points positioned so it produces identical points along the
  /// curve as [this].
  CubicBezier toCubicBezier() {
    final cubicCurvePoints = new List<Vector2>();
    cubicCurvePoints.add(startPoint);

    final pointsCount = points.length;

    for (var index = 1; index < pointsCount; index++) {
      final currentPoint = points[index];
      final previousPoint = points[index - 1];
      final raisedPoint = new Vector2.zero();
      raisedPoint.addScaled(currentPoint, (pointsCount - index) / pointsCount);
      raisedPoint.addScaled(previousPoint, index / pointsCount);

      cubicCurvePoints.add(raisedPoint);
    }

    cubicCurvePoints.add(endPoint);

    return new CubicBezier(cubicCurvePoints);
  }

  @override
  String toString() => "BDQuadraticBezier([${points[0]}, ${points[1]}, ${points[2]}])";

}
