import "package:bezier/bezier.dart";

/// Concrete class of cubic Bézier curves.
class CubicBezier extends Bezier {

  /// Constructs a cubic Bézier curve from a [List] of [Vector2].
  CubicBezier(List<Vector2> points) : super(points) {
    if (points.length != 4) {
      throw(new ArgumentError("Cubic Bézier curves require exactly four points"));
    }
  }

  @override
  int get order => 3;

  @override
  Vector2 pointAt(double t) {
    final t2 = t * t;
    final mt = 1.0 - t;
    final mt2 = mt * mt;

    final a = mt2 * mt;
    final b = mt2 * t * 3;
    final c = mt * t2 * 3;
    final d = t * t2;

    final point = new Vector2.copy(startPoint);
    point.scale(a);
    point.addScaled(points[1], b);
    point.addScaled(points[2], c);
    point.addScaled(points[3], d);

    return point;
  }

  @override
  Vector2 derivativeAt(double t) {
    final derivativePoints = firstOrderDerivativePoints;
    final mt = 1.0 - t;
    final a = mt * mt;
    final b = 2.0 * mt * t;
    final c = t * t;

    final localDerivative = new Vector2.copy(derivativePoints[0]);
    localDerivative.scale(a);
    localDerivative.addScaled(derivativePoints[1], b);
    localDerivative.addScaled(derivativePoints[2], c);
    return localDerivative;
  }

  @override
  String toString() => "BDCubicBezier([${points[0]}, ${points[1]}, ${points[2]}, ${points[3]}])";

}
