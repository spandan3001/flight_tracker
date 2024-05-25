import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

import 'package:latlong2/latlong.dart';

class AirplaneWidget extends StatelessWidget {
  final LatLng start;
  final LatLng end;

  const AirplaneWidget({
    super.key,
    required this.start,
    required this.end,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the angle of rotation
    double angle = _calculateAngle();



    return Center(
      child: Transform.rotate(
        angle: angle,
        child: Image.asset(
            'assets/travelling.png',), // Replace 'airplane.png' with your image path
      ),
    );
  }

  double _calculateAngle() {
    // Convert degrees to radians
    double startLatRad = start.latitude * (math.pi / 180);
    double startLonRad = start.longitude * (math.pi / 180);
    double endLatRad = end.latitude * (math.pi / 180);
    double endLonRad = end.longitude * (math.pi / 180);

    double dLon = endLonRad - startLonRad;

    double y = math.sin(dLon) * math.cos(endLatRad);
    double x = math.cos(startLatRad) * math.sin(endLatRad) -
        math.sin(startLatRad) * math.cos(endLatRad) * math.cos(dLon);

    double angle = math.atan2(y, x)-0.9;

    // Convert angle from radians to degrees if needed
    // double angleDegrees = angle * (180 / math.pi);

    return angle; // or angleDegrees if degrees are needed
  }

  // double _calculateAngle() {
  //
  //
  //   double dLon = (end.longitude - start.longitude);
  //
  //   double y = math.sin(dLon) * math.cos(end.latitude);
  //   double x = math.cos(start.latitude) * math.sin(end.latitude) - math.sin(start.latitude)
  //       * math.cos(end.latitude) * math.cos(dLon);
  //
  //   double angle = math.atan2(y, x);
  //   return angle+4.5;
  // }
}
