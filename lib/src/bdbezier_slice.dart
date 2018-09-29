import "package:bezier/bezier.dart";

/// Class wrapping a [BDBezier] instance and the parameter values for the
/// start and end points of the instance in a parent [BDBezier] instance.
class BDBezierSlice {

  /// An instance of [BDBezier] representing a portion of a parent [BDBezier] instance.
  final BDBezier subcurve;

  /// Parameter value of [subcurve]'s start point in the parent [BDBezier] instance.
  final double t1;

  /// Parameter value of [subcurve]'s end point in the parent [BDBezier] instance.
  final double t2;


  BDBezierSlice(this.subcurve, this.t1, this.t2);

  @override
  String toString() => "BDBezierSlice($subcurve, t1: $t1, t2: $t2)";

}
