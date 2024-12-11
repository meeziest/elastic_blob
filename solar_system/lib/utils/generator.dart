import 'dart:ui';

import 'controller.dart';
import 'models/solar_system.dart';

class SolarSystemGenerator {
  final double widgetSize;
  final Offset center;
  final double sizeScale = 1; // Initial scale factor, we adjust it to the max radius later

  SolarSystemGenerator(this.widgetSize) : center = Offset(widgetSize / 2, widgetSize / 2);

  SolarSystemController generateSolarSystem() {
    double maxOrbitalRadius = widgetSize / 2;
    double maxCosmicObjectRadius = 0.02 * maxOrbitalRadius;
    double showCaseRadius = 0.01 * maxOrbitalRadius;

    const double sunRealRadius = 696340.0;

    // Planets relative distances (as a fraction of the max radius)
    final List<double> relativeOrbitRadii = [0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1.0];

    // Planetary radii (as a fraction of the Sun's radius in reality)
    final double mercuryRadius = (2439.7 / sunRealRadius) * maxCosmicObjectRadius;
    final double venusRadius = (6051.8 / sunRealRadius) * maxCosmicObjectRadius;
    final double earthRadius = (6371.0 / sunRealRadius) * maxCosmicObjectRadius;
    final double moonRadius = (1737.4 / sunRealRadius) * maxCosmicObjectRadius;
    final double phobosRadius = (11.267 / sunRealRadius) * maxCosmicObjectRadius;
    final double deimosRadius = (6.2 / sunRealRadius) * maxCosmicObjectRadius;
    final double marsRadius = (3389.5 / sunRealRadius) * maxCosmicObjectRadius;
    final double jupiterRadius = (69911 / sunRealRadius) * maxCosmicObjectRadius;
    final double saturnRadius = (58232 / sunRealRadius) * maxCosmicObjectRadius;
    final double uranusRadius = (25362 / sunRealRadius) * maxCosmicObjectRadius;
    final double neptuneRadius = (24622 / sunRealRadius) * maxCosmicObjectRadius;

    return SolarSystemController(
      /// Sun
      sun: Sun(
        position: center,
        realRelativeRadius: maxCosmicObjectRadius, // Sun's radius is the maxCosmicObjectRadius
      ),

      /// Planets
      planets: [
        Mercury(
          position: center,
          realRelativeRadius: mercuryRadius, // Scaled radius for Mercury
          showCaseRadius: showCaseRadius,
          orbitalRadius: maxOrbitalRadius * relativeOrbitRadii[0], // Scaled orbital radius
          speed: 0.0717,
          angle: 0,
        ),
        Venus(
          position: center,
          realRelativeRadius: venusRadius, // Scaled radius for Venus
          showCaseRadius: showCaseRadius,
          orbitalRadius: maxOrbitalRadius * relativeOrbitRadii[1], // Scaled orbital radius
          speed: 0.0278,
          angle: 0,
        ),
        Earth(
          position: center,
          realRelativeRadius: earthRadius, // Scaled radius for Earth
          showCaseRadius: showCaseRadius,
          orbitalRadius: maxOrbitalRadius * relativeOrbitRadii[2], // Scaled orbital radius
          speed: 0.0172,
          angle: 0,
          satellites: [
            Moon(
              position: center,
              realRelativeRadius: moonRadius, // Scaled radius for the Moon
              showCaseRadius: showCaseRadius * 0.2,
              orbitalRadius: maxOrbitalRadius * 0.04, // Moon's orbital radius relative to Earth
              speed: 0.229,
              angle: 0,
            ),
          ],
        ),
        Mars(
          position: center,
          realRelativeRadius: marsRadius, // Scaled radius for Mars
          showCaseRadius: showCaseRadius,
          orbitalRadius: maxOrbitalRadius * relativeOrbitRadii[3], // Scaled orbital radius
          speed: 0.00914,
          angle: 0,
          satellites: [
            Phobos(
              position: center,
              realRelativeRadius: phobosRadius, // Phobos scaled size
              showCaseRadius: showCaseRadius * 0.2,
              orbitalRadius: maxOrbitalRadius * 0.04, // Orbital radius relative to Mars
              speed: 0.229,
              angle: 0,
            ),
            Deimos(
              position: center,
              realRelativeRadius: deimosRadius, // Deimos scaled size
              showCaseRadius: showCaseRadius * 0.2,
              orbitalRadius: maxOrbitalRadius * 0.04, // Orbital radius relative to Mars
              speed: 0.229,
              angle: 0,
            ),
          ],
        ),
        Jupiter(
          position: center,
          realRelativeRadius: jupiterRadius, // Scaled radius for Jupiter
          showCaseRadius: showCaseRadius,
          orbitalRadius: maxOrbitalRadius * relativeOrbitRadii[4], // Scaled orbital radius
          speed: 0.00145,
          angle: 0,
        ),
        Saturn(
          position: center,
          realRelativeRadius: saturnRadius, // Scaled radius for Saturn
          showCaseRadius: showCaseRadius,
          orbitalRadius: maxOrbitalRadius * relativeOrbitRadii[5], // Scaled orbital radius
          speed: 0.000583,
          angle: 0,
        ),
        Uranus(
          position: center,
          realRelativeRadius: uranusRadius, // Scaled radius for Uranus
          showCaseRadius: showCaseRadius,
          orbitalRadius: maxOrbitalRadius * relativeOrbitRadii[6], // Scaled orbital radius
          speed: 0.000205,
          angle: 0,
        ),
        Neptune(
          position: center,
          realRelativeRadius: neptuneRadius, // Scaled radius for Neptune
          showCaseRadius: showCaseRadius,
          orbitalRadius: maxOrbitalRadius * relativeOrbitRadii[7], // Furthest planet at max orbital radius
          speed: 0.000104,
          angle: 0,
        ),
      ],
    );
  }
}
