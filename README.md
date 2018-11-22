**bezier.dart** is a simple open-source [Dart](https://www.dartlang.org/) library for handling 2D [Bézier curve](https://en.wikipedia.org/wiki/B%C3%A9zier_curve) math.

The library was developed, documented, and published by [Aaron Barrett](http://www.aaronbarrett.com) and Isaac Barrett.  It is based heavily on the work of [Pomax](https://pomax.github.io/), including his excellent [Primer on Bézier Curves](https://pomax.github.io/bezierinfo/) and his original JavaScript library, [Bezier.js](https://pomax.github.io/bezierjs/).

We're trying to design **bezier.dart** to be both platform independent and context independent.  You can run the library anywhere you can run Dart: in a web browser, in a [Flutter](https://flutter.io/) application, server side, and beyond.

For live examples of the library's API, see the project page at [dartographer.com/bezier](https://www.dartographer.com/bezier).

## Features

- Supports both quadratic and cubic two dimensional Bézier curves
- Calculate the coordinates of a point at any parameter value `t` along a curve
- Derivative and normal values at any `t` parameter value
- Accurate length approximations (using the Legendre-Gauss quadrature algorithm)
- Split a curve into equivalent subcurves between any `t` parameter values
- Find the extrema of a curve on both the x and y axes
- Calculate the bounding box for a curve
- Given any curve, derive a new curve, offset from the original curve along the normals at a given distance
- Calculate the positions of a curve's intersections with itself, with another curve, or with a line segment
- Find points evenly spaced along the arc length of a curve
- Heavily documented and tested
- Straightforward, readable code

## Getting Started

1. Add the following to your project's **pubspec.yaml** and run **pub get**.

```yaml
dependencies:
  bezier: any
```

2. Import **bezier.dart** from a file in your project.  In most cases you will also want to import the [vector_math](https://pub.dartlang.org/packages/vector_math) library.

```dart
import "package:vector_math/vector_math.dart";
import "package:bezier/bezier.dart";
```

## Examples

* Instantiate a Bézier curve.

```dart
import "package:vector_math/vector_math.dart";
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
import "package:vector_math/vector_math.dart";
import "package:bezier/bezier.dart";

void main() {
  final curve = new QuadraticBezier([
    new Vector2(10.0, 10.0),
    new Vector2(70.0, 95.0),
    new Vector2(15.0, 80.0)
  ]);

  final computedPoint = curve.pointAt(0.75);
}
```

* Split a curve between the `t` parameter values of `0.2` and `0.6`.

```dart
import "package:vector_math/vector_math.dart";
import "package:bezier/bezier.dart";

void main() {
  final curve = new CubicBezier([
    new Vector2(10.0, 10.0),
    new Vector2(70.0, 95.0),
    new Vector2(25.0, 20.0),
    new Vector2(15.0, 80.0)
  ]);

  final subcurve = curve.subcurveBetween(0.2, 0.6);
}
```

* Find the intersection `t` values between a curve and a line segment.

```dart
import "package:vector_math/vector_math.dart";
import "package:bezier/bezier.dart";

void main() {
  final curve = new QuadraticBezier([
    new Vector2(10.0, 500.0),
    new Vector2(50.0, 0.0),
    new Vector2(90.0, 500.0)
  ]);

  final lineStart = new Vector2(0.0, 400.0);
  final lineEnd = new Vector2(100.0, 410.0);

  final intersections = curve.intersectionsWithLineSegment(lineStart, lineEnd);
}
```

* Derive an offset curve (composed of a series of subcurves) at distance `12.0`.

```dart
import "package:vector_math/vector_math.dart";
import "package:bezier/bezier.dart";

void main() {
  final curve = new CubicBezier([
    new Vector2(10.0, 10.0),
    new Vector2(15.0, 95.0),
    new Vector2(20.0, 95.0),
    new Vector2(25.0, 10.0)
  ]);

  final subcurves = curve.offsetCurve(12.0);
}
```

## Style, Formatting, Philosophy

We've made our best effort to conform to the recommendations outlined in the [Effective Dart](https://www.dartlang.org/guides/language/effective-dart) guide.  Accordingly, this library is formatted using [dartfmt](https://github.com/dart-lang/dart_style).

As fervent believers in the value of clean code, we are constantly seeking to improve the library and make it easier to work with.  Please alert us to any issues you notice, no matter how trivial.  We wholeheartedly welcome criticism and friendly debate!  :nerd_face:

## Running Automated Tests

To run the test cases from the terminal, run the following command from the **bezier.dart** root directory.

```bash
pub run test
```

Most IDEs now provide interfaces for running tests, which are generally easier to work with.  In most cases you can simply right click on a test file or directory in the project tree view and select the menu option to run the selected tests.

## Submitting bugs, requesting features

Please file feature requests and bugs using the GitHub [issues tab](https://github.com/aab29/bezier.dart/issues).
