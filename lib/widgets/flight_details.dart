import 'dart:math';
import 'package:flight_tracker/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../constants/app_colors.dart';
import '../constants/location_text.dart';

class FlightDetail extends StatelessWidget {
  final double height; // Height of the flight detail container

  // Constructor to initialize height
  const FlightDetail({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    // Get the controller to access flight data and stats
    final controller = Get.find<MainController>();

    // Calculate distance between the start and end points of the flight path
    double distance = calculateDistance(
      controller.flightData!.path.first.latitude,
      controller.flightData!.path.first.longitude,
      controller.flightData!.path.last.latitude,
      controller.flightData!.path.last.longitude,
    );

    // Get the start time of the flight
    DateTime startTime = controller.stats.value.startTime;

    // Calculate the arrival time and required travel time
    Map<String, dynamic> res = calculateArrivalTime(startTime, distance, 800);

    // Build the animated container to display flight details
    return AnimatedContainer(
      height: height, // Height of the container
      padding: const EdgeInsets.all(20), // Padding inside the container
      duration: const Duration(milliseconds: 300), // Animation duration
      decoration: const BoxDecoration(
        color: AppColors.cardColor, // Background color
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: SingleChildScrollView(
        child: Obx(() => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Row displaying start city code, plane icon, and end city code
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LocationText(
                    code: controller.stats.value.startCityCode,
                    city: "-",
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: min(40, 40.w),
                            height: 2,
                            color: Colors.grey,
                          ),
                          Transform.rotate(
                            angle: pi / 2,
                            child: Icon(
                              Icons.airplanemode_active,
                              size: 32.spMin,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            width: min(40, 40.w),
                            height: 2,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      // Display start and arrival times
                      Text(
                        '${DateFormat('HH:mm').format(controller.stats.value.startTime)} --- ${DateFormat('HH:mm').format(res['time'])}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  LocationText(
                    code: controller.stats.value.endCityCode,
                    city: "-",
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Stack(
                children: [
                  Container(
                    height: 4,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                  Container(
                    height: 4,
                    width: 0.0.sw,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.orange,
                        Colors.deepOrange,
                        Colors.red,
                      ]),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    child: Transform.rotate(
                      angle: pi / 2,
                      child: Icon(
                        Icons.airplanemode_active,
                        size: 32.spMin,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Display the arrival time in hours and minutes
              Text(
                'Arriving in ${res['reqTime']}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  // Function to calculate distance between two points using the Haversine formula
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371; // Earth's radius in km
    var dLat = _toRadians(lat2 - lat1); // Difference in latitude
    var dLon = _toRadians(lon2 - lon1); // Difference in longitude
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) *
            sin(dLon / 2) * sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var distance = R * c; // Calculate the distance
    return distance;
  }

  // Function to convert degrees to radians
  double _toRadians(double degree) {
    return degree * pi / 180;
  }

  // Function to calculate the arrival time given the start time, distance, and speed
  Map<String, dynamic> calculateArrivalTime(DateTime startTime, double distance, double speed) {
    // Calculate travel time in hours
    double travelTimeInHours = distance / speed;

    // Convert travel time to seconds
    int travelTimeInSeconds = (travelTimeInHours * 3600).round();

    // Calculate hours and minutes from travel time in seconds
    int hours = travelTimeInSeconds ~/ 3600;
    int minutes = (travelTimeInSeconds % 3600) ~/ 60;

    // Calculate the arrival time
    DateTime arrivalTime = startTime.add(Duration(seconds: travelTimeInSeconds));

    return {
      'time': arrivalTime, // Arrival time as DateTime object
      'reqTime': "${hours}Hrs:${minutes}Mins", // Required time in HH:MM format
    };
  }
}
