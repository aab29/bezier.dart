import "dart:math";

import "package:vector_math/vector_math.dart" as vector_math;

import "package:bezier/bezier.dart";

import "bdbezier_tools.dart";

/// Abstract base class of Bézier curves.
abstract class Bezier {

  /// Maximum distance threshold used for determination of linear curves.
  static const linearTolerance = 0.0001;

  /// Distance used when creating the lines to determine the origin for scaled curves.
  static const originIntersectionTestDistance = 10.0;

  /// The start point, end point and control points of the Bézier curve.
  final List<Vector2> points;

  /// Constructs a Bézier curve from a [List] of [Vector2].
  Bezier(this.points);

  /// Factory constructor that returns a new instance of the proper subclass of [Bezier]
  /// based on the number of entries in [curvePoints].
  factory Bezier.fromPoints(List<Vector2> curvePoints) {
    if (curvePoints.length == 3) {
      return new BDQuadraticBezier(curvePoints);
    } else if (curvePoints.length == 4) {
      return new BDCubicBezier(curvePoints);
    } else {
      throw(new UnsupportedError("Unsupported number of curve points"));
    }
  }

  /// The order of the Bézier curve.
  ///
  /// A second order curve is quadratic and a third order curve is cubic.
  int get order;

  /// Returns the point along the curve at the parameter value [t].
  Vector2 pointAt(double t);

  /// The starting guide point for the curve.
  Vector2 get startPoint => points.first;

  /// The ending guide point for the curve.
  Vector2 get endPoint => points.last;

  /// Derivative points for the first order.
  List<Vector2> get firstOrderDerivativePoints =>
      computeDerivativePoints(points);

  /// Derivative points for the order [derivativeOrder].
  ///
  /// Orders beyond the first are calculated with the previous order.
  List<Vector2> derivativePoints({int derivativeOrder = 1}) {
    if (derivativeOrder == 1) {
      return firstOrderDerivativePoints;
    } else if (derivativeOrder > this.order) {
      return [];
    } else if (derivativeOrder < 1) {
      throw(new ArgumentError("invalid order for derivatives"));
    }

    final pointsToProcess = derivativePoints(derivativeOrder: derivativeOrder - 1);

    return computeDerivativePoints(pointsToProcess);
  }

  /// Returns the tangent vector at parameter [t].
  ///
  /// The return value is not normalized.
  Vector2 derivativeAt(double t);

  /// True if the curve is clockwise.
  ///
  /// A curve is clockwise if the angle between the line connecting the start and end points
  /// and the line connecting the start point and first control point is positive.
  /// When the end point is to the right of the start point, a clockwise curve will arch
  /// upward initially.
  bool get isClockwise {
    final firstControlPoint = points[1];
    final angle = cornerAngle(startPoint, endPoint, firstControlPoint);
    return angle > 0.0;
  }

  /// True if the y values of the control points after being translated and rotated
  /// are within a specified small distance (the constant [linearTolerance]) from zero.
  bool get isLinear {
    final alignedPoints = alignWithLineSegment(points, startPoint, endPoint);
    for (final alignedPoint in alignedPoints) {
      if (alignedPoint.y.abs() > linearTolerance) {
        return false;
      }
    }
    return true;
  }

  /// The approximate arc length of the curve computed using 24th order Legendre polynomials.
  double get length => computeLength(derivativeAt);

  List<Vector2> _interpolatedPoints(List<Vector2> pointsToInterpolate, double t) {
    final interpolatedPoints = <Vector2>[];

    for (var index = 0; index < pointsToInterpolate.length - 1; index++) {
      final point = new Vector2.zero();
      Vector2.mix(pointsToInterpolate[index], pointsToInterpolate[index + 1], t, point);
      interpolatedPoints.add(point);
    }

    return interpolatedPoints;
  }

  List<Vector2> _interpolateRecursively(List<Vector2> pointsToInterpolate, double t) {
    if (pointsToInterpolate.length > 1) {
      final result = new List<Vector2>.from(pointsToInterpolate);

      final interpolatedPoints = _interpolatedPoints(pointsToInterpolate, t);
      result.addAll(_interpolateRecursively(interpolatedPoints, t));

      return result;
    } else {
      return pointsToInterpolate;
    }
  }

  /// Returns the hull points at the parameter value [t].
  List<Vector2> hullPointsAt(double t) {
    final hullPoints = <Vector2>[];
    for (var index = 0; index <= order; index++) {
      final hullPoint = new Vector2.copy(points[index]);
      hullPoints.add(hullPoint);
    }

    return _interpolateRecursively(hullPoints, t);
  }

  /// The normal vector of the curve at parameter value [t].
  ///
  /// The result is normalized.
  Vector2 normalVectorAt(double t) {
    final d = derivativeAt(t);
    d.normalize();

    return new Vector2(-d.y, d.x);
  }

  /// Returns the axis-aligned bounding box of the curve.
  Aabb2 get boundingBox {
    final extremaTValues = extrema;
    if (!(extremaTValues.contains(0.0))) {
      extremaTValues.insert(0, 0.0);
    }
    if (!(extremaTValues.contains(1.0))) {
      extremaTValues.add(1.0);
    }

    final minPoint = new Vector2(double.infinity, double.infinity);
    final maxPoint = new Vector2(double.negativeInfinity, double.negativeInfinity);

    extremaTValues.forEach((t) {
      final point = pointAt(t);
      Vector2.min(minPoint, point, minPoint);
      Vector2.max(maxPoint, point, maxPoint);
    });

    return new Aabb2.minMax(minPoint, maxPoint);
  }

  /// True if the bounding box of [this] intersects with the bounding box of [curve].
  bool overlaps(Bezier curve) {
    final thisBox = boundingBox;
    final otherBox = curve.boundingBox;

    return thisBox.intersectsWithAabb2(otherBox);
  }

  /// Returns the subcurve obtained by taking the portion of the curve to the
  /// left of parameter value [t].
  Bezier leftSubcurveAt(double t) {
    if (t <= 0.0) {
      throw(new ArgumentError("Cannot split curve left of start point"));
    }

    t = min(t, 1.0);

    final hullPoints = hullPointsAt(t);

    if (order == 2) {
      return new BDQuadraticBezier([hullPoints[0], hullPoints[3], hullPoints[5]]);
    } else if (order == 3) {
      return new BDCubicBezier([hullPoints[0], hullPoints[4], hullPoints[7], hullPoints[9]]);
    } else {
      throw(new UnsupportedError("Unsupported curve order"));
    }
  }

  /// Returns the subcurve obtained by taking the portion of the curve to the
  /// right of parameter value [t].
  Bezier rightSubcurveAt(double t) {
    if (t >= 1.0) {
      throw(new ArgumentError("Cannot split curve right of end point"));
    }

    t = max(t, 0.0);

    final hullPoints = hullPointsAt(t);
    if (order == 2) {
      return new BDQuadraticBezier([hullPoints[5], hullPoints[4], hullPoints[2]]);
    } else if (order == 3) {
      return new BDCubicBezier([hullPoints[9], hullPoints[8], hullPoints[6], hullPoints[3]]);
    } else {
      throw(new UnsupportedError("Unsupported curve order"));
    }
  }

  /// Returns the sub-curve obtained by taking the portion of the curve between
  /// parameter values [t1] and [t2].
  Bezier subcurveBetween(double t1, double t2) {
    final rightOfT1 = rightSubcurveAt(t1);
    final adjustedT2 = inverseMix(t1, 1.0, t2);

    return rightOfT1.leftSubcurveAt(adjustedT2);
  }

  List<double> _extremaOnAxis(double Function(Vector2) mappingFunction) {
    final firstOrderPoints = derivativePoints(derivativeOrder: 1);
    final firstOrderPolynomial = firstOrderPoints.map(mappingFunction).toList();

    final result = <double>[];
    result.addAll(polynomialRoots(firstOrderPolynomial));

    if (order == 3) {
      final secondOrderPoints = derivativePoints(derivativeOrder: 2);
      final secondOrderPolynomial = secondOrderPoints.map(mappingFunction).toList();
      result.addAll(polynomialRoots(secondOrderPolynomial));
    }

    result.retainWhere((t) => ((t >= 0.0) && (t <= 1.0)));
    result.sort();
    return result;
  }

  /// Returns the parameter values that correspond with minimum and maximum values
  /// on the x axis.
  List<double> get extremaOnX => _extremaOnAxis((v) => v.x);

  /// Returns the parameter values that correspond with minimum and maximum values
  /// on the y axis.
  List<double> get extremaOnY => _extremaOnAxis((v) => v.y);

  /// Returns the parameter values that correspond with extrema on both the x
  /// and y axes.
  List<double> get extrema {
    final roots = <double>[];
    roots.addAll(extremaOnX);
    roots.addAll(extremaOnY);

    final rootsSet = new Set<double>.from(roots);
    final uniqueRoots = rootsSet.toList();
    uniqueRoots.sort();
    return uniqueRoots;
  }

  /// The normal vector at [t] taking into account overlapping control
  /// points at the end point with index [endPointIndex] in [points].
  Vector2 _nonOverlappingNormalVectorAt(double t, int endPointIndex) {
    final normalVector = normalVectorAt(t);
    if ((normalVector.x != 0.0) || (normalVector.y != 0.0)) {
      return normalVector;
    }

    final iterationsCount = order - 1;
    for (var iteration = 0; iteration < iterationsCount; iteration++) {
      var pointIndex = iteration + 2;
      var tangentScaleFactor = 1.0;
      if (endPointIndex > 0) {
        pointIndex = (endPointIndex - 2) - iteration;
        tangentScaleFactor = -1.0;
      }

      final tangentVector = new Vector2.copy(points[pointIndex]);
      tangentVector.sub(points[endPointIndex]);
      tangentVector.scale(tangentScaleFactor);
      final tangentMagnitude = tangentVector.normalize();
      if (tangentMagnitude != 0.0) {
        return new Vector2(-tangentVector.y, tangentVector.x);
      }
    }
    return new Vector2.zero();
  }

  /// True if the normal vectors at the start and end points form an angle less
  /// than 60 degrees.
  ///
  /// Cubic curves have the additional restriction of needing
  /// both control points on the same side of the line between the guide points.
  bool get isSimple {
    if (order == 3) {
      final startAngle = cornerAngle(startPoint, endPoint, points[1]);
      final endAngle = cornerAngle(startPoint, endPoint, points[2]);
      if (((startAngle > 0.0) && (endAngle < 0.0)) ||
          ((startAngle < 0.0) && (endAngle > 0.0))) {
        return false;
      }
    }

    final startPointNormal = _nonOverlappingNormalVectorAt(0.0, 0);
    final endPointNormal = _nonOverlappingNormalVectorAt(1.0, order);

    final normalDotProduct = startPointNormal.dot(endPointNormal);
    final clampedDotProduct = normalDotProduct.clamp(-1.0, 1.0);
    final angle = (acos(clampedDotProduct)).abs();

    return (angle < pi / 3.0);
  }

  /// Returns a [List] of subcurve segments of [this] between the parameter
  /// values for extrema.
  List<BDBezierSlice> _slicesBetweenExtremaTValues() {
    final curvePortionsBetweenExtrema = <BDBezierSlice>[];

    final extremaTValues = extrema;
    if (!(extremaTValues.contains(0.0))) {
      extremaTValues.insert(0, 0.0);
    }
    if (!(extremaTValues.contains(1.0))) {
      extremaTValues.add(1.0);
    }

    var t1 = extremaTValues[0];
    for (var extremityIndex = 1; extremityIndex < extremaTValues.length; extremityIndex++) {
      final t2 = extremaTValues[extremityIndex];
      final subcurve = subcurveBetween(t1, t2);
      final reductionResult = new BDBezierSlice(subcurve, t1, t2);
      curvePortionsBetweenExtrema.add(reductionResult);
      t1 = t2;
    }

    return curvePortionsBetweenExtrema;
  }

  /// Returns a [List] of simple subcurve segments from [slicesToProcess].
  ///
  /// It divides each curve in [slicesToProcess] from a starting parameter
  /// value to an ending parameter value in search of non-simple portions.  When
  /// a non-simple portion is found, it backtracks and adds the last known simple
  /// portion to the returned value.
  List<BDBezierSlice> _divideNonSimpleSlices(List<BDBezierSlice> slicesToProcess, double stepSize) {
    final simpleSlices = <BDBezierSlice>[];

    for (final slice in slicesToProcess) {
      if (slice.subcurve.isSimple) {
        simpleSlices.add(slice);
        continue;
      }

      var t1 = 0.0;
      var t2 = 0.0;
      var subcurve;

      while (t2 <= 1.0) {
        for (t2 = t1 + stepSize; t2 <= 1.0 + stepSize; t2 += stepSize) {
          subcurve = slice.subcurve.subcurveBetween(t1, t2);
          if (!(subcurve.isSimple)) {
            t2 -= stepSize;
            final reductionIsNotPossible = ((t1 - t2).abs() < stepSize);
            if (reductionIsNotPossible) {
              return [];
            }
            subcurve = slice.subcurve.subcurveBetween(t1, t2);
            final subcurveT1 = vector_math.mix(slice.t1, slice.t2, t1);
            final subcurveT2 = vector_math.mix(slice.t1, slice.t2, t2);
            final result = new BDBezierSlice(subcurve, subcurveT1, subcurveT2);
            simpleSlices.add(result);
            t1 = t2;
            break;
          }
        }
      }
      if (t1 < 1.0) {
        subcurve = slice.subcurve.subcurveBetween(t1, 1.0);
        final subcurveT1 = vector_math.mix(slice.t1, slice.t2, t1);
        final subcurveT2 = slice.t2;
        final result = new BDBezierSlice(subcurve, subcurveT1, subcurveT2);
        simpleSlices.add(result);
      }
    }

    return simpleSlices;
  }

  /// Returns a [List] of [BDBezierSlice] instances containing simple [Bezier]
  /// instances along with their endpoint parameter values from [this].
  ///
  /// Refer to [simpleSubcurves] for information about the optional parameter [stepSize].
  /// If endpoint parameter values of the component curves are not needed, use [simpleSubcurves]
  /// instead.
  List<BDBezierSlice> simpleSlices({double stepSize = 0.01}) {
    final subcurvesBetweenExtrema = _slicesBetweenExtremaTValues();
    return _divideNonSimpleSlices(subcurvesBetweenExtrema, stepSize);
  }

  /// Returns a [List] of simple [Bezier] instances that make up [this] when taken together.
  ///
  /// The first pass splits the curve at the parameter values of extrema along the
  /// x and y axes.  The second pass divides any non-simple portions of the curve
  /// into simple curves.  The optional [stepSize] parameter determines how much
  /// to increment the parameter value at each iteration when searching for non-simple
  /// portions of curves.  The default [stepSize] value of 0.01 means that the function
  /// will do around one hundred iterations for each segment between the parameter
  /// values for extrema.  Reducing the value of [stepSize] will increase the
  /// number of iterations.
  List<Bezier> simpleSubcurves({double stepSize = 0.01}) {
    final reductionResults = simpleSlices(stepSize: stepSize);
    return reductionResults.map((r) => r.subcurve).toList();
  }

  /// Returns the point [distance] units away in the clockwise direction from
  /// the point along the curve at parameter value [t].
  Vector2 offsetPointAt(double t, double distance) {
    final offsetPoint = pointAt(t);
    final normalVector = normalVectorAt(t);
    normalVector.scale(distance);

    offsetPoint.add(normalVector);

    return offsetPoint;
  }

  /// Returns a [List] of [Bezier] instances that, when taken together, form an approximation
  /// of the offset curve [distance] units away from [this].
  List<Bezier> offsetCurve(double distance) {
    if (isLinear) {
      return [_translatedLinearCurve(distance)];
    }

    final reducedSegments = simpleSubcurves();
    final offsetSegments = reducedSegments.map((s) => s.scaledCurve(distance));
    return offsetSegments.toList();
  }

  /// Returns a [Bezier] instance with [points] translated by [distance] units
  /// along the normal vector at the start point.
  Bezier _translatedLinearCurve(double distance) {
    final normalVector = _nonOverlappingNormalVectorAt(0.0, 0);
    final translatedPoints = <Vector2>[];
    for (final point in points) {
      final translatedPoint = new Vector2.copy(point);
      translatedPoint.addScaled(normalVector, distance);
      translatedPoints.add(translatedPoint);
    }
    return new Bezier.fromPoints(translatedPoints);
  }

  /// Returns the origin used for calculating control point positions in scaled curves.
  ///
  /// Usually the intersection point between the endpoint normal vectors.  In the
  /// case of cubic curves with parallel or anti-parallel endpoint normal vectors,
  /// the origin is the midpoint between the start and end points.
  Vector2 get _scalingOrigin {
    final offsetStart = _nonOverlappingOffsetPointAt(0.0, originIntersectionTestDistance, 0);
    final offsetEnd = _nonOverlappingOffsetPointAt(1.0, originIntersectionTestDistance, order);
    final intersectionPoint = intersectionPointBetweenTwoLines(offsetStart, startPoint, offsetEnd, endPoint);
    if (intersectionPoint == null) {
      final centerPoint = new Vector2.zero();
      Vector2.mix(startPoint, endPoint, 0.5, centerPoint);
      return centerPoint;
    } else {
      return intersectionPoint;
    }
  }

  /// Returns the point at [t] offset by [distance] along the normal vector calculated
  /// by [_nonOverlappingNormalVectorAt].
  Vector2 _nonOverlappingOffsetPointAt(double t, double distance, int endPointIndex) {
    final offsetPoint = pointAt(t);
    final normalVector = _nonOverlappingNormalVectorAt(t, endPointIndex);
    offsetPoint.addScaled(normalVector, distance);
    return offsetPoint;
  }

  /// Returns a [Bezier] instance whose endpoints are [distance] units away from the
  /// endpoints of [this] and whose control points have been moved in the same direction.
  ///
  /// A scaled linear curve is translated by [distance] units along its start
  /// point normal vector.
  Bezier scaledCurve(double distance) {
    if (isLinear) {
      return _translatedLinearCurve(distance);
    }

    var origin = _scalingOrigin;

    final listLength = order + 1;
    final scaledCurvePoints = new List<Vector2>(listLength);

    final scaledStartPoint = _nonOverlappingOffsetPointAt(0.0, distance, 0);
    scaledCurvePoints[0] = scaledStartPoint;

    final scaledEndPoint = _nonOverlappingOffsetPointAt(1.0, distance, order);
    scaledCurvePoints[order] = scaledEndPoint;

    final startTangentPoint = new Vector2.copy(scaledStartPoint);
    startTangentPoint.add(derivativeAt(0.0));
    scaledCurvePoints[1] = intersectionPointBetweenTwoLines(scaledStartPoint, startTangentPoint, origin, points[1]);

    scaledCurvePoints[1] ??= startTangentPoint;

    if (order == 3) {
      final endTangentPoint = new Vector2.copy(scaledEndPoint);
      endTangentPoint.add(derivativeAt(1.0));
      scaledCurvePoints[2] = intersectionPointBetweenTwoLines(scaledEndPoint, endTangentPoint, origin, points[2]);

      scaledCurvePoints[2] ??= endTangentPoint;
    }

    return new Bezier.fromPoints(scaledCurvePoints);
  }

  /// Returns a [List] of intersection results after removing duplicates in [intersectionsToFilter].
  static List<BDIntersection> _removeDuplicateIntersections(List<BDIntersection> intersectionsToFilter, double minTValueDifference) {
    if (intersectionsToFilter.length <= 1) {
      return intersectionsToFilter;
    }

    var firstIntersection = intersectionsToFilter[0];
    var sublist = intersectionsToFilter.sublist(1);
    final filteredList = <BDIntersection>[firstIntersection];
    while (sublist.length > 0) {
      sublist.removeWhere((intersection) {
        return intersection.isWithinTValueOf(firstIntersection, minTValueDifference);
      });

      if (sublist.length > 0) {
        firstIntersection = sublist[0];
        sublist = sublist.sublist(1);
        filteredList.add(firstIntersection);
      }
    }
    return filteredList;
  }

  /// Returns a [List] of intersection results between [curve1] and [curve2].
  static List<BDIntersection> _locateIntersections(List<BDBezierSlice> curve1,
      List<BDBezierSlice> curve2, double curveIntersectionThreshold, double minTValueDifference) {
    final leftOverlappingSegments = <BDBezierSlice>[];
    final rightOverlappingSegments = <BDBezierSlice>[];
    curve1.forEach((left) {
      curve2.forEach((right) {
        if (left.subcurve.overlaps(right.subcurve)) {
          leftOverlappingSegments.add(left);
          rightOverlappingSegments.add(right);
        }
      });
    });

    final intersections = <BDIntersection>[];
    final overlappingSegmentsCount = leftOverlappingSegments.length;
    for (var pairIndex = 0; pairIndex < overlappingSegmentsCount; pairIndex++) {
      final leftCurve = leftOverlappingSegments[pairIndex];
      final rightCurve = rightOverlappingSegments[pairIndex];
      final result = locateIntersectionsRecursively(leftCurve, rightCurve, curveIntersectionThreshold);
      intersections.addAll(result);
    }

    return _removeDuplicateIntersections(intersections, minTValueDifference);
  }

  /// Returns the [List] of intersections between [this] and [curve].
  ///
  /// The optional parameter [curveIntersectionThreshold] determines how small
  /// to divide the bounding boxes of overlapping segments in the search for
  /// intersection points.  This value is in the coordinate space of the curve.
  /// The optional parameter [minTValueDifference] specifies how far away
  /// intersection results must be from each other in terms of curve parameter
  /// values to be considered separate intersections.
  ///
  /// With the optional parameters at their default values, this method may return
  /// more than the expected number of intersections for curves that cross at a
  /// shallow angle or pass extremely close to each other. Decreasing
  /// [curveIntersectionThreshold] or increasing [minTValueDifference] may
  /// reduce the number of intersections returned in such cases.
  List<BDIntersection> intersectionsWithCurve(Bezier curve, {double curveIntersectionThreshold = 0.5, double minTValueDifference = 0.003}) {
    final reducedSegments = simpleSlices();
    final curveReducedSegments = curve.simpleSlices();

    return _locateIntersections(reducedSegments, curveReducedSegments, curveIntersectionThreshold, minTValueDifference);
  }

  /// Returns the [List] of intersections between [this] and itself.
  ///
  /// See [intersectionsWithCurve] for information about the optional parameters.
  List<BDIntersection> intersectionsWithSelf({double curveIntersectionThreshold = 0.5, double minTValueDifference = 0.003}) {
    final reducedSegments = simpleSlices();
    final results = <BDIntersection>[];

    for (var segmentIndex = 0; segmentIndex < reducedSegments.length - 2; segmentIndex++) {
      final left = reducedSegments.sublist(segmentIndex, segmentIndex + 1);
      final right = reducedSegments.sublist(segmentIndex + 2);
      final result = _locateIntersections(left, right, curveIntersectionThreshold, minTValueDifference);
      results.addAll(result);
    }

    return results;
  }

  /// Returns the [List] of parameter values for intersections between [this] and
  /// the line segment defined by [lineStartPoint] and [lineEndPoint].
  List<double> intersectionsWithLineSegment(Vector2 lineStartPoint, Vector2 lineEndPoint) {
    final minPoint = new Vector2.zero();
    Vector2.min(lineStartPoint, lineEndPoint, minPoint);

    final maxPoint = new Vector2.zero();
    Vector2.max(lineStartPoint, lineEndPoint, maxPoint);

    final boundingBox = new Aabb2.minMax(minPoint, maxPoint);

    final roots = rootsAlongLine(points, lineStartPoint, lineEndPoint);
    roots.retainWhere((t) {
      final p = pointAt(t);
      return boundingBox.intersectsWithVector2(p);
    });
    final rootsSet = new Set<double>.from(roots);
    final uniqueRoots = rootsSet.toList();
    return uniqueRoots;
  }

  /// Returns a [List] of [Vector2] positions at evenly spaced parameter values from 0.0 to 1.0.
  ///
  /// The [intervalsCount] parameter is used to calculate the size of the interval.
  /// The returned List will contain [intervalsCount] + 1 entries.
  List<Vector2> positionLookUpTable({int intervalsCount = 50}) {
    final lookUpTable = <Vector2>[];

    for (var index = 0; index <= intervalsCount; index++) {
      final parameterValue = index / intervalsCount;
      final position = pointAt(parameterValue);
      lookUpTable.add(position);
    }

    return lookUpTable;
  }
}
