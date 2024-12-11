import 'package:flutter/cupertino.dart';

import 'models/behaviors.dart';
import 'models/cosmic_object.dart';

const double globalSpeedFactor = 0.1;

final class SolarSystemController extends ChangeNotifier {
  final Star sun;
  final List<Planet> planets;

  SolarSystemController({
    required this.planets,
    required this.sun,
  });

  double _speedFactor = globalSpeedFactor;
  double get speedFactor => _speedFactor;

  void updateGlobalSpeed(double speed) {
    _speedFactor = speed;
    notifyListeners();
  }

  OrbitalMotionBehavior get _sunOrbitBehavior => CircularOrbitBehavior(
        orbit: sun,
        speedFactor: speedFactor,
      );

  OrbitalMotionBehavior _planetOrbitBehavior(Planet planet) => CircularOrbitBehavior(
        orbit: planet,
        speedFactor: speedFactor,
      );

  void onTick(Duration elapsed) {
    for (var planet in planets) {
      planet.updatePosition(_sunOrbitBehavior);

      if (planet case WithSatellites(satellites: var satellites)) {
        for (var satellite in satellites) {
          satellite.updatePosition(_planetOrbitBehavior(planet));
        }
      }
    }
    notifyListeners();
  }
}
