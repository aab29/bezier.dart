import '../testing_tools/testing_tools.dart';

void main() {
  group('pointAt', () {
    test('quadratic pointAt', () {
      final curve = QuadraticBezier(
          [Vector2(10.0, 10.0), Vector2(70.0, 95.0), Vector2(15.0, 80.0)]);

      expect(curve.pointAt(0.0), closeToVector(Vector2(10.0, 10.0)));
      expect(curve.pointAt(1.0), closeToVector(Vector2(15.0, 80.0)));

      expect(curve.pointAt(0.5), closeToVector(Vector2(41.25, 70.0)));
      expect(curve.pointAt(0.33333333),
          closeToVector(Vector2(37.22222137451172, 55.5555534362793)));
      expect(curve.pointAt(0.85),
          closeToVector(Vector2(28.912500381469727, 82.25)));
    });

    test('cubic pointAt', () {
      final curve = CubicBezier([
        Vector2(10.0, 10.0),
        Vector2(70.0, 95.0),
        Vector2(25.0, 20.0),
        Vector2(15.0, 80.0)
      ]);

      expect(curve.pointAt(0.0), closeToVector(Vector2(10.0, 10.0)));
      expect(curve.pointAt(1.0), closeToVector(Vector2(15.0, 80.0)));

      expect(curve.pointAt(0.5), closeToVector(Vector2(38.75, 54.375)));
      expect(curve.pointAt(0.33333333),
          closeToVector(Vector2(40.185184478759766, 52.592594146728516)));
      expect(curve.pointAt(0.85),
          closeToVector(Vector2(21.389999389648438, 61.11687469482422)));
    });
  });

  group('hullPointsAt', () {
    test('quadratic hullPointsAt', () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(50.0, 100.0), Vector2(100.0, 0.0)]);

      final hull1 = curve.hullPointsAt(0.5);
      expect(hull1, hasLength(6));
      expect(hull1[0], closeToVector(Vector2(0.0, 0.0)));
      expect(hull1[1], closeToVector(Vector2(50.0, 100.0)));
      expect(hull1[2], closeToVector(Vector2(100.0, 0.0)));
      expect(hull1[3], closeToVector(Vector2(25.0, 50.0)));
      expect(hull1[4], closeToVector(Vector2(75.0, 50.0)));
      expect(hull1[5], closeToVector(Vector2(50.0, 50.0)));

      final hull2 = curve.hullPointsAt(0.2);
      expect(hull2, hasLength(6));
      expect(hull2[0], closeToVector(Vector2(0.0, 0.0)));
      expect(hull2[1], closeToVector(Vector2(50.0, 100.0)));
      expect(hull2[2], closeToVector(Vector2(100.0, 0.0)));
      expect(hull2[3], closeToVector(Vector2(10.0, 20.0)));
      expect(hull2[4], closeToVector(Vector2(60.0, 80.0)));
      expect(hull2[5], closeToVector(Vector2(20.0, 32.0)));
    });

    test('cubic hullPointsAt', () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(0.0, 100.0),
        Vector2(50.0, -100.0),
        Vector2(100.0, 0.0)
      ]);

      final hull1 = curve.hullPointsAt(0.5);
      expect(hull1, hasLength(10));
      expect(hull1[0], closeToVector(Vector2(0.0, 0.0)));
      expect(hull1[1], closeToVector(Vector2(0.0, 100.0)));
      expect(hull1[2], closeToVector(Vector2(50.0, -100.0)));
      expect(hull1[3], closeToVector(Vector2(100.0, 0.0)));
      expect(hull1[4], closeToVector(Vector2(0.0, 50.0)));
      expect(hull1[5], closeToVector(Vector2(25.0, 0.0)));
      expect(hull1[6], closeToVector(Vector2(75.0, -50.0)));
      expect(hull1[7], closeToVector(Vector2(12.5, 25.0)));
      expect(hull1[8], closeToVector(Vector2(50.0, -25.0)));
      expect(hull1[9], closeToVector(Vector2(31.25, 0.0)));

      final hull2 = curve.hullPointsAt(0.2);
      expect(hull2, hasLength(10));
      expect(hull2[0], closeToVector(Vector2(0.0, 0.0)));
      expect(hull2[1], closeToVector(Vector2(0.0, 100.0)));
      expect(hull2[2], closeToVector(Vector2(50.0, -100.0)));
      expect(hull2[3], closeToVector(Vector2(100.0, 0.0)));
      expect(hull2[4], closeToVector(Vector2(0.0, 20.0)));
      expect(hull2[5], closeToVector(Vector2(10.0, 60.0)));
      expect(hull2[6], closeToVector(Vector2(60.0, -80.0)));
      expect(hull2[7], closeToVector(Vector2(2.0, 28.0)));
      expect(hull2[8], closeToVector(Vector2(20.0, 32.0)));
      expect(hull2[9], closeToVector(Vector2(5.6, 28.8)));
    });

    test('cubic hullPointsAt, second test', () {
      final points = [
        Vector2(10.0, 10.0),
        Vector2(70.0, 95.0),
        Vector2(25.0, 20.0),
        Vector2(15.0, 80.0)
      ];
      final curve = CubicBezier(points);

      final hull1 = curve.hullPointsAt(0.5);
      expect(hull1, hasLength(10));
      expect(hull1[0], closeToVector(Vector2(10.0, 10.0)));
      expect(hull1[1], closeToVector(Vector2(70.0, 95.0)));
      expect(hull1[2], closeToVector(Vector2(25.0, 20.0)));
      expect(hull1[3], closeToVector(Vector2(15.0, 80.0)));
      expect(hull1[4], closeToVector(Vector2(40.0, 52.5)));
      expect(hull1[5], closeToVector(Vector2(47.5, 57.5)));
      expect(hull1[6], closeToVector(Vector2(20.0, 50.0)));
      expect(hull1[7], closeToVector(Vector2(43.75, 55.0)));
      expect(hull1[8], closeToVector(Vector2(33.75, 53.75)));
      expect(hull1[9], closeToVector(Vector2(38.75, 54.375)));

      final hull2 = curve.hullPointsAt(0.8);
      expect(hull2, hasLength(10));
      expect(hull2[0], closeToVector(Vector2(10.0, 10.0)));
      expect(hull2[1], closeToVector(Vector2(70.0, 95.0)));
      expect(hull2[2], closeToVector(Vector2(25.0, 20.0)));
      expect(hull2[3], closeToVector(Vector2(15.0, 80.0)));
      expect(hull2[4], closeToVector(Vector2(58.0, 78.0)));
      expect(hull2[5], closeToVector(Vector2(34.0, 35.0)));
      expect(hull2[6], closeToVector(Vector2(17.0, 68.0)));
      expect(hull2[7],
          closeToVector(Vector2(38.79999923706055, 43.599998474121094)));
      expect(hull2[8],
          closeToVector(Vector2(20.399999618530273, 61.400001525878906)));
      expect(hull2[9],
          closeToVector(Vector2(24.079999923706055, 57.84000015258789)));
    });

    test('quadratic hullPointsAt, second test', () {
      final points = [
        Vector2(10.0, 10.0),
        Vector2(25.0, 20.0),
        Vector2(15.0, 80.0)
      ];
      final curve = QuadraticBezier(points);

      final hull1 = curve.hullPointsAt(0.5);
      expect(hull1, hasLength(6));
      expect(hull1[0], closeToVector(Vector2(10.0, 10.0)));
      expect(hull1[1], closeToVector(Vector2(25.0, 20.0)));
      expect(hull1[2], closeToVector(Vector2(15.0, 80.0)));
      expect(hull1[3], closeToVector(Vector2(17.5, 15.0)));
      expect(hull1[4], closeToVector(Vector2(20.0, 50.0)));
      expect(hull1[5], closeToVector(Vector2(18.75, 32.5)));

      final hull2 = curve.hullPointsAt(0.8);
      expect(hull2, hasLength(6));
      expect(hull2[0], closeToVector(Vector2(10.0, 10.0)));
      expect(hull2[1], closeToVector(Vector2(25.0, 20.0)));
      expect(hull2[2], closeToVector(Vector2(15.0, 80.0)));
      expect(hull2[3], closeToVector(Vector2(22.0, 18.0)));
      expect(hull2[4], closeToVector(Vector2(17.0, 68.0)));
      expect(hull2[5], closeToVector(Vector2(18.0, 58.0)));
    });
  });

  group('derivativeAt', () {
    test('quadratic derivativeAt', () {
      final curve = QuadraticBezier(
          [Vector2(10.0, 10.0), Vector2(70.0, 95.0), Vector2(15.0, 80.0)]);

      expect(curve.derivativeAt(0.0), closeToVector(Vector2(120.0, 170.0)));
      expect(curve.derivativeAt(0.1), closeToVector(Vector2(97.0, 150.0)));
      expect(curve.derivativeAt(0.25), closeToVector(Vector2(62.5, 120.0)));
      expect(curve.derivativeAt(0.33333),
          closeToVector(Vector2(43.33409881591797, 103.33399963378906)));
      expect(curve.derivativeAt(0.5), closeToVector(Vector2(5.0, 70.0)));
      expect(curve.derivativeAt(0.6827),
          closeToVector(Vector2(-37.020999908447266, 33.459999084472656)));
      expect(curve.derivativeAt(0.75), closeToVector(Vector2(-52.5, 20.0)));
      expect(curve.derivativeAt(0.9), closeToVector(Vector2(-87.0, -10.0)));
      expect(curve.derivativeAt(1.0), closeToVector(Vector2(-110.0, -30.0)));
    });

    test('cubic derivativeAt', () {
      final curve = CubicBezier([
        Vector2(10.0, 10.0),
        Vector2(70.0, 95.0),
        Vector2(25.0, 20.0),
        Vector2(15.0, 80.0)
      ]);

      expect(curve.derivativeAt(0.0), closeToVector(Vector2(180.0, 255.0)));
      expect(curve.derivativeAt(0.1),
          closeToVector(Vector2(121.19999694824219, 167.85000610351562)));
      expect(curve.derivativeAt(0.25), closeToVector(Vector2(48.75, 70.3125)));
      expect(curve.derivativeAt(0.33333),
          closeToVector(Vector2(16.66783332824707, 33.33456802368164)));
      expect(curve.derivativeAt(0.5), closeToVector(Vector2(-30.0, -3.75)));
      expect(curve.derivativeAt(0.6827),
          closeToVector(Vector2(-54.34769821166992, 12.08817195892334)));
      expect(curve.derivativeAt(0.75), closeToVector(Vector2(-56.25, 32.8125)));
      expect(curve.derivativeAt(0.9),
          closeToVector(Vector2(-46.79999923706055, 107.8499984741211)));
      expect(curve.derivativeAt(1.0), closeToVector(Vector2(-30.0, 180.0)));
    });

    test('quadratic derivativeAt, specified cachedFirstOrderDerivativePoints',
        () {
      final curve = QuadraticBezier(
          [Vector2(10.0, 10.0), Vector2(70.0, 95.0), Vector2(15.0, 80.0)]);

      final cachedPoints = <Vector2>[
        Vector2(120.0, 170.0),
        Vector2(-110.0, -30.0)
      ];

      expect(curve.firstOrderDerivativePoints, closeToVectorList(cachedPoints));

      expect(
          curve.derivativeAt(0.0,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(120.0, 170.0)));
      expect(
          curve.derivativeAt(0.1,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(97.0, 150.0)));
      expect(
          curve.derivativeAt(0.25,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(62.5, 120.0)));
      expect(
          curve.derivativeAt(0.33333,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(43.33409881591797, 103.33399963378906)));
      expect(
          curve.derivativeAt(0.5,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(5.0, 70.0)));
      expect(
          curve.derivativeAt(0.6827,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-37.020999908447266, 33.459999084472656)));
      expect(
          curve.derivativeAt(0.75,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-52.5, 20.0)));
      expect(
          curve.derivativeAt(0.9,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-87.0, -10.0)));
      expect(
          curve.derivativeAt(1.0,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-110.0, -30.0)));
    });

    test('cubic derivativeAt, specified cachedFirstOrderDerivativePoints', () {
      final curve = CubicBezier([
        Vector2(10.0, 10.0),
        Vector2(70.0, 95.0),
        Vector2(25.0, 20.0),
        Vector2(15.0, 80.0)
      ]);

      final cachedPoints = <Vector2>[
        Vector2(180.0, 255.0),
        Vector2(-135.0, -225.0),
        Vector2(-30.0, 180.0),
      ];

      expect(curve.firstOrderDerivativePoints, closeToVectorList(cachedPoints));

      expect(
          curve.derivativeAt(0.0,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(180.0, 255.0)));
      expect(
          curve.derivativeAt(0.1,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(121.19999694824219, 167.85000610351562)));
      expect(
          curve.derivativeAt(0.25,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(48.75, 70.3125)));
      expect(
          curve.derivativeAt(0.33333,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(16.66783332824707, 33.33456802368164)));
      expect(
          curve.derivativeAt(0.5,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-30.0, -3.75)));
      expect(
          curve.derivativeAt(0.6827,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-54.34769821166992, 12.08817195892334)));
      expect(
          curve.derivativeAt(0.75,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-56.25, 32.8125)));
      expect(
          curve.derivativeAt(0.9,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-46.79999923706055, 107.8499984741211)));
      expect(
          curve.derivativeAt(1.0,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-30.0, 180.0)));
    });
  });

  group('normalAt', () {
    test('cubic normalAt', () {
      final points = [
        Vector2(10.0, 10.0),
        Vector2(70.0, 95.0),
        Vector2(25.0, 20.0),
        Vector2(15.0, 80.0)
      ];
      final curve = CubicBezier(points);

      expect(curve.normalAt(0.5),
          closeToVector(Vector2(0.12403473258018494, -0.9922778606414795)));
      expect(curve.normalAt(0.23),
          closeToVector(Vector2(-0.8163508176803589, 0.5775563716888428)));
      expect(curve.normalAt(0.69),
          closeToVector(Vector2(-0.24693183600902557, -0.9690328240394592)));
      expect(curve.normalAt(0.0),
          closeToVector(Vector2(-0.8169678449630737, 0.5766832232475281)));
      expect(curve.normalAt(1.0),
          closeToVector(Vector2(-0.986393928527832, -0.16439898312091827)));
    });

    test('quadratic normalAt', () {
      final points = [
        Vector2(10.0, 10.0),
        Vector2(25.0, 20.0),
        Vector2(15.0, 80.0)
      ];
      final curve = QuadraticBezier(points);

      expect(curve.normalAt(0.5),
          closeToVector(Vector2(-0.9974586963653564, 0.07124704867601395)));
      expect(curve.normalAt(0.23),
          closeToVector(Vector2(-0.9185916185379028, 0.3952080309391022)));
      expect(curve.normalAt(0.69),
          closeToVector(Vector2(-0.9987242221832275, -0.05049728974699974)));
      expect(curve.normalAt(0.0),
          closeToVector(Vector2(-0.5547001957893372, 0.8320503234863281)));
      expect(curve.normalAt(1.0),
          closeToVector(Vector2(-0.986393928527832, -0.16439898312091827)));
    });

    test('cubic normalAt, specified cachedFirstOrderDerivativePoints', () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(30.0, 100.0),
        Vector2(80.0, -30.0),
        Vector2(95.0, 45.0)
      ]);

      final cachedPoints = <Vector2>[
        Vector2(90.0, 300.0),
        Vector2(150.0, -390.0),
        Vector2(45.0, 225.0)
      ];

      expect(curve.firstOrderDerivativePoints, closeToVectorList(cachedPoints));

      expect(
          curve.normalAt(0.0, cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-0.9578262567520142, 0.2873478829860687)));
      expect(
          curve.normalAt(0.18, cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-0.6621309518814087, 0.7493881583213806)));
      expect(
          curve.normalAt(0.375, cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(0.29084232449531555, 0.9567710161209106)));
      expect(
          curve.normalAt(0.5, cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(0.5057194828987122, 0.862697958946228)));
      expect(
          curve.normalAt(0.625, cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(0.4644697606563568, 0.8855890035629272)));
      expect(
          curve.normalAt(0.82, cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-0.5096653699874878, 0.8603727221488953)));
      expect(
          curve.normalAt(1.0, cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-0.9805806875228882, 0.1961161345243454)));
    });

    test('quadratic normalAt, specified cachedFirstOrderDerivativePoints', () {
      final curve = QuadraticBezier(
          [Vector2(130.0, -40.0), Vector2(110.0, 85.0), Vector2(-45.0, 170.0)]);

      final cachedPoints = <Vector2>[
        Vector2(-40.0, 250.0),
        Vector2(-310.0, 170.0),
      ];

      expect(curve.firstOrderDerivativePoints, closeToVectorList(cachedPoints));

      expect(
          curve.normalAt(0.0, cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-0.9874406456947327, -0.157990500330925)));
      expect(
          curve.normalAt(0.18, cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-0.936002254486084, -0.35199403762817383)));
      expect(
          curve.normalAt(0.375, cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-0.8414890170097351, -0.5402742028236389)));
      expect(
          curve.normalAt(0.5, cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-0.7682212591171265, -0.6401844024658203)));
      expect(
          curve.normalAt(0.625, cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-0.6918114423751831, -0.7220782041549683)));
      expect(
          curve.normalAt(0.82, cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-0.5764377117156982, -0.8171411156654358)));
      expect(
          curve.normalAt(1.0, cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-0.48083260655403137, -0.8768123984336853)));
    });
  });

  group('offsetPointAt', () {
    test('cubic offsetPointAt', () {
      final points = [
        Vector2(10.0, 10.0),
        Vector2(70.0, 95.0),
        Vector2(15.0, 70.0),
        Vector2(25.0, 20.0)
      ];
      final curve = CubicBezier(points);

      final pointA = curve.offsetPointAt(0.5, 3.0);
      expect(
          pointA, closeToVector(Vector2(37.30337142944336, 62.81601333618164)));

      final pointB = curve.offsetPointAt(0.85, 10.0);
      expect(
          pointB, closeToVector(Vector2(34.19104766845703, 39.19478988647461)));

      final pointC = curve.offsetPointAt(0.0, 16.0);
      expect(pointC,
          closeToVector(Vector2(-3.0714855194091797, 19.226932525634766)));

      final pointD = curve.offsetPointAt(1.0, 1.0);
      expect(pointD,
          closeToVector(Vector2(25.980581283569336, 20.196115493774414)));
    });

    test('quadratic offsetPointAt', () {
      final points = [
        Vector2(15.0, 70.0),
        Vector2(65.0, 20.0),
        Vector2(70.0, 95.0),
      ];
      final curve = QuadraticBezier(points);

      final pointA = curve.offsetPointAt(0.5, 12.0);
      expect(
          pointA, closeToVector(Vector2(48.78436279296875, 62.17439651489258)));

      final pointB = curve.offsetPointAt(0.15, 5.0);
      expect(pointB,
          closeToVector(Vector2(31.915807723999023, 61.86527633666992)));

      final pointC = curve.offsetPointAt(0.0, 1.0);
      expect(pointC,
          closeToVector(Vector2(15.707106590270996, 70.70710754394531)));

      final pointD = curve.offsetPointAt(1.0, 8.0);
      expect(
          pointD, closeToVector(Vector2(62.01771926879883, 95.53215026855469)));
    });

    test('quadratic offsetPointAt, negative distance', () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(50.0, 100.0), Vector2(100.0, 0.0)]);

      expect(
          curve.offsetPointAt(0.5, -1.0), closeToVector(Vector2(50.0, 49.0)));
      expect(
          curve.offsetPointAt(0.5, -50.0), closeToVector(Vector2(50.0, 0.0)));
      expect(curve.offsetPointAt(0.75, -15.0),
          closeToVector(Vector2(64.39340209960938, 26.89339828491211)));
      expect(curve.offsetPointAt(0.273, -8.2),
          closeToVector(Vector2(32.81229019165039, 33.62339401245117)));
      expect(curve.offsetPointAt(1.0, -50.0),
          closeToVector(Vector2(55.27864074707031, -22.360679626464844)));
      expect(curve.offsetPointAt(0.0, -100.0),
          closeToVector(Vector2(89.44271850585938, -44.72135925292969)));
    });

    test('cubic offsetPointAt, negativeDistance', () {
      final curve = CubicBezier([
        Vector2(0.0, 100.0),
        Vector2(250.0, 0.0),
        Vector2(-150.0, 50.0),
        Vector2(100.0, 100.0)
      ]);

      expect(curve.offsetPointAt(0.5, -1.0),
          closeToVector(Vector2(50.164398193359375, 44.736392974853516)));
      expect(curve.offsetPointAt(0.5, -50.0),
          closeToVector(Vector2(58.219947814941406, 93.06969451904297)));
      expect(curve.offsetPointAt(0.75, -15.0),
          closeToVector(Vector2(28.88807487487793, 62.56289291381836)));
      expect(curve.offsetPointAt(0.273, -8.2),
          closeToVector(Vector2(77.95957946777344, 50.75044250488281)));
      expect(curve.offsetPointAt(1.0, -50.0),
          closeToVector(Vector2(109.8058090209961, 50.97096633911133)));
      expect(curve.offsetPointAt(0.0, -100.0),
          closeToVector(Vector2(-37.139068603515625, 7.1523284912109375)));
    });

    test('quadratic offsetPointAt, specified cachedFirstOrderDerivativePoints',
        () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(50.0, 100.0), Vector2(100.0, 0.0)]);

      final cachedPoints = <Vector2>[
        Vector2(100.0, 200.0),
        Vector2(100.0, -200.0)
      ];

      expect(curve.firstOrderDerivativePoints, closeToVectorList(cachedPoints));

      expect(
          curve.offsetPointAt(0.0, 10.0,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-8.9442720413208, 4.4721360206604)));
      expect(
          curve.offsetPointAt(0.25, 40.0,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-3.284270763397217, 65.78427124023438)));
      expect(
          curve.offsetPointAt(0.5, 24.0,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(50.0, 74.0)));
      expect(
          curve.offsetPointAt(0.5, -30.0,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(50.0, 20.0)));
      expect(
          curve.offsetPointAt(0.55, -30.0,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(49.11651611328125, 20.082578659057617)));
      expect(
          curve.offsetPointAt(0.83, 40.0,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(114.88368225097656, 52.374305725097656)));
      expect(
          curve.offsetPointAt(1.0, -10.0,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(91.05572509765625, -4.4721360206604)));
    });

    test('cubic offsetPointAt, specified cachedFirstOrderDerivativePoints', () {
      final curve = CubicBezier([
        Vector2(0.0, 100.0),
        Vector2(250.0, 0.0),
        Vector2(-150.0, 50.0),
        Vector2(100.0, 100.0)
      ]);

      final cachedPoints = <Vector2>[
        Vector2(750.0, -300.0),
        Vector2(-1200.0, 150.0),
        Vector2(750.0, 150.0)
      ];

      expect(curve.firstOrderDerivativePoints, closeToVectorList(cachedPoints));

      expect(
          curve.offsetPointAt(0.0, 10.0,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(3.713906764984131, 109.2847671508789)));
      expect(
          curve.offsetPointAt(0.25, 40.0,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(125.29229736328125, 57.936668395996094)));
      expect(
          curve.offsetPointAt(0.5, 24.0,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(46.05442428588867, 20.07654571533203)));
      expect(
          curve.offsetPointAt(0.5, -30.0,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(54.931968688964844, 73.3418197631836)));
      expect(
          curve.offsetPointAt(0.55, -30.0,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(46.82734680175781, 75.10584259033203)));
      expect(
          curve.offsetPointAt(0.83, 40.0,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(-0.15876483917236328, 108.22217559814453)));
      expect(
          curve.offsetPointAt(1.0, -10.0,
              cachedFirstOrderDerivativePoints: cachedPoints),
          closeToVector(Vector2(101.9611587524414, 90.1941909790039)));
    });
  });

  group('positionLookUpTable', () {
    test('quadratic positionLookUpTable, default intervalsCount', () {
      final curve = QuadraticBezier(
          [Vector2(0.0, 0.0), Vector2(50.0, 100.0), Vector2(100.0, 0.0)]);

      final table = curve.positionLookUpTable();
      expect(table, TypeMatcher<List<Vector2>>());
      expect(table, hasLength(51));

      expect(table[0], closeToVector(Vector2(0.0, 0.0)));
      expect(table[1], closeToVector(Vector2(2.0, 3.9200000762939453)));
      expect(table[20], closeToVector(Vector2(40.0, 48.0)));
      expect(table[25], closeToVector(Vector2(50.0, 50.0)));
      expect(table[30], closeToVector(Vector2(60.0, 48.0)));
      expect(table[49], closeToVector(Vector2(98.0, 3.9200000762939453)));
      expect(table[50], closeToVector(Vector2(100.0, 0.0)));
    });

    test('cubic positionLookUpTable, default intervalsCount', () {
      final curve = CubicBezier([
        Vector2(0.0, 0.0),
        Vector2(50.0, 100.0),
        Vector2(50.0, 0.0),
        Vector2(100.0, 100.0)
      ]);

      final table = curve.positionLookUpTable();
      expect(table, TypeMatcher<List<Vector2>>());
      expect(table, hasLength(51));

      expect(table[0], closeToVector(Vector2(0.0, 0.0)));
      expect(table[1],
          closeToVector(Vector2(2.9407999515533447, 5.763200283050537)));
      expect(table[20],
          closeToVector(Vector2(42.400001525878906, 49.60000228881836)));
      expect(table[25], closeToVector(Vector2(50.0, 50.0)));
      expect(table[30],
          closeToVector(Vector2(57.599998474121094, 50.39999771118164)));
      expect(table[49],
          closeToVector(Vector2(97.05919647216797, 94.23680114746094)));
      expect(table[50], closeToVector(Vector2(100.0, 100.0)));
    });
  });
}
