# Changelog - bezier

## v 1.2.0 - April 4 2021

- Migrate to null safety (Thanks to @fzyzcjy for doing most of the work)
- Update SDK constraints to `'>=2.12.0 <3.0.0'`
- Updated dependencies (`vector_math` and `test`) to support null safety as well
- Removing usage of the `new` keyword in the code in `README.md`
- Updating a URL in `README.md`

## v 1.1.5 - December 21 2019

- Replaced all usages of double quotes with single quotes in order to conform to the latest style recommendations.
- Fixed one instance (in `quadratic_bezier.dart`) where we used a `List()` constructor instead of the `[]` literal. 

## v 1.1.4 - December 10 2019

- Just updating this changelog file, since I forgot to in 1.1.3

## v 1.1.3 - December 10 2019

- Removed all usages of the `new` keyword in the codebase in order to conform to the latest style recommendations.

## v 1.1.2 - May 19 2019

- Fixed certain cases, reported by @fidlip (Thank you!), where `intersectionsWithLineSegment` failed to find intersections
- Added `pointIntersectsBoundingBoxApproximately` in `bezier_tools` to support `intersectionsWithLineSegment`
- Added more unit tests for `intersectionsWithLineSegment`, based on cases reported by @fidlip

## v 1.1.1 - February 20 2019

- Changed usages of `length == 0` and `length > 0` to `isEmpty` and `isNotEmpty`,
  respectively, in accordance with hints provided by Pub

## v 1.1.0 - January 30 2019

- Added `nearestTValue` method to `Bezier` class, based on work by @luigi-rosso -- Thanks!
- Added `indexOfNearestPoint` method (to support `nearestTValue`) in `bezier_tools`
- Added unit tests for both new methods in `bezier_nearest_methods_test`

## v 1.0.3 - December 20 2018

- Corrected the version number in the pubspec, since I forgot to commit it in 1.0.2

## v 1.0.2 - December 20 2018

- Added example directory with a simple HTML demo app
- Adjusted the description in pubspec again to meet character count limits

## v 1.0.1 - December 12 2018

- Adjusted minor details in pubspec
- Listed GitHub page as package homepage

## v 1.0.0 - December 12 2018

- First public release
- Published to Pub at [https://pub.dartlang.org/packages/bezier]

## v 0.0.0 - September 26 2018

- Initial release
