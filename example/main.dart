import "dart:html";
import "dart:math";
import "package:vector_math/vector_math.dart";
import "package:bezier/bezier.dart";

const oscillationRateX = 0.63;
const oscillationRateY = 0.79;

const slitherRadius = 0.29;
const slitherRate = 0.0025;

const timeOffsets = [0.0, 9511.14, 2922.25, 363.31];

const normalLinesCount = 125;
const normalLineLength = 70.0;

const outlineDistance = 50.0;

final canvas = querySelector("#canvas") as CanvasElement;
final context = canvas.context2D;

void main() {
  animate();
}

void animate() {
  window.animationFrame.then(drawFrame);
}

void drawFrame(num time) {
  clearCanvas();

  final points = pointsAtTime(time);
  final curve = new CubicBezier(points);

  drawMainCurve(curve);

  //////////////////////////////////////////////////////////////////
  // Try uncommenting the following lines to see different examples:
  //////////////////////////////////////////////////////////////////

  drawNormalLines(curve);
//  drawBoundingBox(curve);
//  drawOutlines(curve);
//  drawLineSegmentIntersections(curve, time);
//  drawExtrema(curve);

  //////////////////////////////////////////////////////////////////

  animate();
}

List<Vector2> pointsAtTime(double time) => timeOffsets.map((offset) {
      final adjustedTime = slitherRate * time + offset;
      return new Vector2(
          canvas.width *
              (0.5 + cos(oscillationRateX * adjustedTime) * slitherRadius),
          canvas.height *
              (0.5 + sin(oscillationRateY * adjustedTime) * slitherRadius));
    }).toList();

void clearCanvas() {
  context.clearRect(0.0, 0.0, canvas.width, canvas.height);
}

void drawCircle(Vector2 center, {double radius = 3.0}) {
  context
      ..beginPath()
      ..arc(center.x, center.y, radius, 0.0, 2.0 * pi)
      ..stroke()
      ..closePath();
}

void drawCurve(CubicBezier curve) {
  final points = curve.points;

  context.moveTo(points[0].x, points[0].y);
  context.bezierCurveTo(curve.points[1].x, curve.points[1].y, curve.points[2].x,
      curve.points[2].y, curve.points[3].x, curve.points[3].y);
}

void drawMainCurve(CubicBezier curve) {
  context.setStrokeColorRgb(0, 0, 0);

  context.beginPath();
  drawCurve(curve);
  context.stroke();
}

void drawNormalLines(CubicBezier curve) {
  final derivativePoints = curve.firstOrderDerivativePoints;

  context.setStrokeColorRgb(0, 0, 255);

  context.beginPath();
  for (var lineIndex = 0; lineIndex < normalLinesCount; lineIndex++) {
    final t = (lineIndex + 1) / (normalLinesCount + 1);

    final pointOnCurve = curve.pointAt(t);
    final normal =
        curve.normalAt(t, cachedFirstOrderDerivativePoints: derivativePoints);
    final offset = normal * normalLineLength;

    final positiveOffsetPoint = pointOnCurve + offset;
    final negativeOffsetPoint = pointOnCurve - offset;

    context.moveTo(negativeOffsetPoint.x, negativeOffsetPoint.y);
    context.lineTo(positiveOffsetPoint.x, positiveOffsetPoint.y);
  }
  context.stroke();
}

void drawBoundingBox(CubicBezier curve) {
  final boundingBox = curve.boundingBox;

  final min = boundingBox.min;
  final max = boundingBox.max;
  final width = max.x - min.x;
  final height = max.y - min.y;

  context.setStrokeColorRgb(0, 255, 0);
  context.strokeRect(min.x, min.y, width, height);
}

void drawOutlines(CubicBezier curve) {
  final outlineCurves = []
    ..addAll(curve.offsetCurve(outlineDistance))
    ..addAll(curve.offsetCurve(-outlineDistance));

  context.setStrokeColorRgb(255, 0, 255);

  context.beginPath();
  outlineCurves.forEach((outlineCurve) => drawCurve(outlineCurve));
  context.stroke();
}

Vector2 lineSegmentPointAtTime(double radius, double time) => new Vector2(
  canvas.width * (0.5 + radius * cos(time * 0.00042)),
  canvas.height * (0.5 + radius * sin(time * 0.00042)),
  );

void drawLineSegmentIntersections(CubicBezier curve, double time) {
  final startPoint = lineSegmentPointAtTime(-0.25, time);
  final endPoint = lineSegmentPointAtTime(0.35, time);

  context
    ..setStrokeColorRgb(255, 127, 0)
    ..beginPath()
    ..moveTo(startPoint.x, startPoint.y)
    ..lineTo(endPoint.x, endPoint.y)
    ..stroke();

  final intersectionTValues = curve.intersectionsWithLineSegment(startPoint, endPoint);

  context.setStrokeColorRgb(255, 0, 0);
  intersectionTValues.forEach((t) {
    final intersectionPoint = curve.pointAt(t);
    drawCircle(intersectionPoint);
  });
}

void drawExtrema(CubicBezier curve) {
  final xExtremaTValues = curve.extremaOnX;
  final yExtremaTValues = curve.extremaOnY;
  
  context.setStrokeColorRgb(255, 0, 0);
  xExtremaTValues.forEach((t) => drawCircle(curve.pointAt(t)));

  context.setStrokeColorRgb(0, 191, 0);
  yExtremaTValues.forEach((t) => drawCircle(curve.pointAt(t)));
}
