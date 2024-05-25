import 'dart:math';

import 'package:flight_tracker/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'app_colors.dart';
import 'location_text.dart';

class FlightDetail extends StatelessWidget {
  final double height;
  const FlightDetail({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();
    double distance = calculateDistance(controller.flightData!.path.first.latitude, controller.flightData!.path.first.longitude, controller.flightData!.path.last.latitude, controller.flightData!.path.last.longitude);
    DateTime startTime = controller.stats.value.startTime;
    Map<String,dynamic> res= calculateArrivalTime(startTime, distance, 800);
    return AnimatedContainer(
      height: height,
      padding: const EdgeInsets.all(20),
      duration: const Duration(milliseconds: 300),
      decoration: const BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
      ),
      child: SingleChildScrollView(
        child: Obx(()=>Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                        ])),
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
    var dLat = _toRadians(lat2 - lat1);
    var dLon = _toRadians(lon2 - lon1);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) *
            sin(dLon / 2) * sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var distance = R * c;
    return distance;
  }

// Function to convert degrees to radians
  double _toRadians(double degree) {
    return degree * pi / 180;
  }

// Function to calculate the arrival time given the start time, distance, and speed
  Map<String ,dynamic> calculateArrivalTime(DateTime startTime, double distance, double speed) {
    // Calculate travel time in hours
    double travelTimeInHours = distance / speed;

    // Convert travel time to seconds
    int travelTimeInSeconds = (travelTimeInHours * 3600).round();
    // Calculate hours and minutes
    int hours = travelTimeInSeconds ~/ 3600;
    int minutes = (travelTimeInSeconds % 3600) ~/ 60;

    // Calculate the arrival time
    DateTime arrivalTime = startTime.add(Duration(seconds: travelTimeInSeconds));

    return {
      'time':arrivalTime,
      "reqTime":"${hours}Hrs:${minutes}Mins"
    };
  }
}
