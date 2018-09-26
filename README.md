**bezier.dart** is a simple open-source [Dart](https://www.dartlang.org/) library for handling 2D [Bézier curve](https://en.wikipedia.org/wiki/B%C3%A9zier_curve) math.

The library was developed, documented, and published by [Aaron Barrett](http://www.aaronbarrett.com) and Isaac Barrett.  It is based heavily on the work of [Pomax](https://pomax.github.io/), including his excellent [Primer on Bézier Curves](https://pomax.github.io/bezierinfo/) and his original JavaScript library, [Bezier.js](https://pomax.github.io/bezierjs/).

We tried to assume as little as possible about the kind of applications that might want to incorporate **bezier.js**.  You can run the library anywhere you can run Dart: in a web browser, in a [Flutter](https://flutter.io/) application, server side, and beyond.

## Features

- Supports both quadratic and cubic two dimensional Bézier curves
- Calculate the coordinates of a point at any parameter value `t` along a curve
- Derivative and normal values at any `t` parameter value
- Accurate length approximations (using the Legendre-Gauss quadrature algorithm)
- Split a curve into equivalent subcurves at any `t` parameter value
- Find the extrema of a curve on both the *x-* and *y-* axes
- Calculate the bounding box for a curve
- Given any curve, derive a new curve, offset from the original curve along the normals at a given distance
- Calculate the positions of a curve's intersections with itself, with another curve, or with a line segment
- Heavily documented and tested
- Straightforward, readable code

## Getting Started

1. Add the following to your project's **pubspec.yaml** and run **pub get**.

```yaml
dependencies:
  bezier: any
```

2. Import **bezier.dart** from a file in your project.

```dart
import "package:bezier/bezier.dart";
```

## Examples

* Instantiate a Bézier curve.

```dart
import "package:bezier/bezier.dart";

void main() {
  // bezier.dart supports both quadratic curves...
  final quadraticCurve = new QuadraticBezier([
    new Vector2(-40.0, -40.0),
    new Vector2(30.0, 10.0),
    new Vector2(55.0, 25.0)
  ]);

  // ...and cubic curves!
  final cubicCurve = new CubicBezier([
    new Vector2(10.0, 10.0),
    new Vector2(70.0, 95.0),
    new Vector2(25.0, 20.0),
    new Vector2(15.0, 80.0)
  ]);
}
```

* Compute a point along a curve at `t` of `0.75`.

```dart
import "package:bezier/bezier.dart";

void main() {
  final curve = new QuadraticBezier([
    new Vector2(10.0, 10.0),
    new Vector2(70.0, 95.0),
    new Vector2(15.0, 80.0)
  ]);

  final point = curve.computePoint(0.75);
}
```

* Split a curve between the `t` parameter values of `0.2` and `0.6`.

```dart
import "package:bezier/bezier.dart";

void main() {
  final curve = new CubicBezier([
    new Vector2(10.0, 10.0),
    new Vector2(70.0, 95.0),
    new Vector2(25.0, 20.0),
    new Vector2(15.0, 80.0)
  ]);

  final subcurve = curve.splitBetween(0.2, 0.6);
}
```

* Find the intersection `t` values between a curve and a line segment.

```dart
import "package:bezier/bezier.dart";

void main() {
  final curve = new QuadraticBezier([
    new Vector2(10.0, 500.0),
    new Vector2(50.0, 0.0),
    new Vector2(90.0, 500.0)
  ]);

  final lineStart = new Vector2(0.0, 400.0);
  final lineEnd = new Vector2(100.0, 410.0);

  final intersections = curve.lineIntersects(lineStart, lineEnd);
}
```

* Derive an offset curve (composed of a series of subcurves) at distance `12.0`.

```dart
import "package:bezier/bezier.dart";

void main() {
  final curve = new CubicBezier([
    new Vector2(10.0, 10.0),
    new Vector2(15.0, 95.0),
    new Vector2(20.0, 95.0),
    new Vector2(25.0, 10.0)
  ]);

  final offsetSubcurves = curve.offset(12.0);
}
```

## Submitting bugs, requesting features

Please file feature requests and bugs using the GitHub issues tab.
