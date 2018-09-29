/// bezier.dart is a simple open-source library for handling 2D Bézier curve
/// math.
///
/// The library was developed, documented, and published by
/// [Aaron Barrett](http://www.aaronbarrett.com) and Isaac Barrett.  It is based
/// heavily on the work of [Pomax](https://pomax.github.io/), including his
/// excellent [Primer on Bézier Curves](https://pomax.github.io/bezierinfo/) and
/// his original JavaScript library,
/// [Bezier.js](https://pomax.github.io/bezierjs/).
library bezier;

export "package:vector_math/vector_math.dart" show Vector, Vector2, Aabb2;

export "src/bdbezier.dart";
export "src/bdbezier_slice.dart";
export "src/bdcubic_bezier.dart";
export "src/bdeven_spacer.dart";
export "src/bdintersection.dart";
export "src/bdquadratic_bezier.dart";
