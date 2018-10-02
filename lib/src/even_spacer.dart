import "package:vector_math/vector_math.dart";

import "package:bezier/bezier.dart";

import "bezier_tools.dart";

/// Class for calculating parameter values of points in a [Bezier] evenly spaced
/// along its arc length.
class EvenSpacer {
  /// A set of points along a curve at evenly spaced parameter values including
  /// the start and end points.
  final List<Vector2> curveLookUpTable;

  /// The set of distances from the start point calculated for each point in [curveLookUpTable].
  final List<double> _cumulativeArcLengths = [0.0];

  /// Constructs a [EvenSpacer] with a [List] of [Vector2] positions
  /// calculated at evenly spaced parameter values within a [Bezier].
  EvenSpacer(this.curveLookUpTable) {
    if (curveLookUpTable.length < 2) {
      throw (new ArgumentError("look up table requires at least two entries"));
    }

    for (var index = 1; index < curveLookUpTable.length; index++) {
      final startPoint = curveLookUpTable[index - 1];
      final endPoint = curveLookUpTable[index];
      final distance = startPoint.distanceTo(endPoint);
      final cumulativeArcLength = _cumulativeArcLengths[index - 1] + distance;
      _cumulativeArcLengths.add(cumulativeArcLength);
    }
  }

  /// Returns an instance of [EvenSpacer] using a position look up table
  /// generated from [curve].
  factory EvenSpacer.fromBezier(Bezier curve, {int intervalsCount = 50}) {
    final lookUpTable = curve.positionLookUpTable(intervalsCount: intervalsCount);
    return new EvenSpacer(lookUpTable);
  }

  /// The approximate arc length of the curve.
  ///
  /// Calculated by adding up the distance between consecutive points in [curveLookUpTable].
  double get arcLength => _cumulativeArcLengths.last;

  /// Returns the parameter value along the curve at the fraction of arc length [t] along the curve.
  ///
  /// Values of [t] outside the range (0.0 .. 1.0) return values clamped to that range.
  double evenTValueAt(double t) {
    if (t >= 1.0) {
      return 1.0;
    }

    var upperBoundIndex = 0;
    for (var index = 0; index < _cumulativeArcLengths.length; index++) {
      final arcLengthAtIndex = _cumulativeArcLengths[index];
      final arcLengthFraction = arcLengthAtIndex / arcLength;
      if (arcLengthFraction > t) {
        upperBoundIndex = index;
        break;
      }
    }

    if (upperBoundIndex < 1) {
      return 0.0;
    }

    final lowerBoundIndex = upperBoundIndex - 1;

    final lowerBoundArcLength = _cumulativeArcLengths[lowerBoundIndex];
    final upperBoundArcLength = _cumulativeArcLengths[upperBoundIndex];

    final lowerBoundArcFraction = lowerBoundArcLength / arcLength;
    final upperBoundArcFraction = upperBoundArcLength / arcLength;

    final arcFractionParameter = inverseMix(lowerBoundArcFraction, upperBoundArcFraction, t);

    final parametersCount = curveLookUpTable.length - 1;

    final parameterAtLowerBound = (upperBoundIndex - 1) / parametersCount;
    final parameterAtUpperBound = upperBoundIndex / parametersCount;

    return mix(parameterAtLowerBound, parameterAtUpperBound, arcFractionParameter);
  }

  /// Returns a [List] of parameter values along the curve that are approximately evenly
  /// spaced along its arc length.
  ///
  /// The optional parameter [parametersCount] is used to calculate the arc length
  /// fraction.  The returned value will have [parametersCount] + 1 entries.
  List<double> evenTValues({int parametersCount = 50}) {
    final evenlySpacedParameters = <double>[];

    for (var parameterIndex = 0; parameterIndex <= parametersCount; parameterIndex++) {
      final arcLengthPortion = parameterIndex / parametersCount;
      final parameterValue = evenTValueAt(arcLengthPortion);
      evenlySpacedParameters.add(parameterValue);
    }

    return evenlySpacedParameters;
  }
}