import 'package:flight_tracker/model/data.dart';
import 'package:flight_tracker/model/stats.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../api/api.dart';
import '../constants/circle_marker.dart';
import '../dummy_data.dart';
import '../widgets/airplane_icon.dart';
import '../widgets/indicator.dart';

class MainController extends GetxController {
  late FlightData flightData;
  RxMap<String, dynamic> resultForStats = <String, dynamic>{}.obs;

  RxBool isLoading = false.obs;
  RxList<Polyline> travelled = <Polyline>[].obs;
  RxList<Polyline> toTravel = <Polyline>[].obs;
  RxList<Marker> markers = <Marker>[].obs;
  Rx<LatLng> cameraLL = const LatLng(13, 77).obs;
  Rx<Stats> stats = Stats(
          startCityCode: "BLR",
          endCityCode: "DEL",
          temp: 0,
          wind: 0,
          precipitation: 0,
          startTime: DateTime.now())
      .obs;
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    flightData = FlightData.fromJson(obj);
    resultForStats.addAll(getWeatherCondition(calculateRiskPercentage(
        stats.value.temp, stats.value.precipitation, stats.value.wind)));

    resultForStats.refresh();

    // travelled.add(
    //   Polyline(
    //     points: [
    //       const LatLng(13, 77), // Amsterdam, Netherlands
    //       const LatLng(61, -39), // London, United Kingdom
    //       // const LatLng(38.73, -9.14), // Lisbon, Portugal
    //     ],
    //     color: Colors.orange,
    //     strokeWidth: 3,
    //   ),
    // );
    // toTravel.add(Polyline(points: [
    //   //const LatLng(52.37, 4.90), // Amsterdam, Netherlands
    //   const LatLng(61, -39), // London, United Kingdom
    //   const LatLng(40, -73), // Lisbon, Portugal
    // ], color: Colors.black12, strokeWidth: 5, isDotted: true));

    // markers.addAll(
    //   [
    //     const Marker(
    //       point: LatLng(13, 77), // London, United Kingdom
    //       width: 30,
    //       height: 30,
    //       child: AirplaneWidget(
    //         start: LatLng(51.50, -0.12),
    //         end: LatLng(38.73, -9.14),
    //       ),
    //     ),
    //     Marker(
    //       point: const LatLng(13, 77), // London, United Kingdom
    //       width: 25,
    //       height: 25,
    //       child: CustomPaint(
    //         size: const Size(300, 300), // Specify the size of the canvas
    //         painter: ConcentricCirclesPainter(),
    //       ),
    //     ),
    //     Marker(
    //       point: const LatLng(40, -73), // London, United Kingdom
    //       width: 25,
    //       height: 25,
    //       child: CustomPaint(
    //         size: const Size(300, 300), // Specify the size of the canvas
    //         painter: ConcentricCirclesPainter(
    //             isSingle: true, innerColor: Colors.black),
    //       ),
    //     ),
    //   ],
    // );
  }

  void addLinesAndMarkers() {
    cameraLL(flightData.path.first);

    travelled.clear();
    toTravel.clear();
    markers.clear();

    toTravel.add(
      Polyline(
        points: flightData.path,
        color: Colors.orange,
        strokeWidth: 3,
      ),
    );

    markers.addAll(
      [
        Marker(
          point: flightData.path.first,
          width: 30,
          height: 30,
          child: AirplaneWidget(
            start: flightData.path.first,
            end: flightData.path[1],
          ),
        ),
        Marker(
          point: flightData.path.first,
          width: 25,
          height: 25,
          child: CustomPaint(
            size: const Size(300, 300), // Specify the size of the canvas
            painter: ConcentricCirclesPainter(),
          ),
        ),
        Marker(
          point: flightData.path.last, // London, United Kingdom
          width: 25,
          height: 25,
          child: CustomPaint(
            size: const Size(300, 300), // Specify the size of the canvas
            painter: ConcentricCirclesPainter(
                isSingle: true, innerColor: Colors.black),
          ),
        ),
      ],
    );

    travelled.refresh();
    toTravel.refresh();
    markers.refresh();
  }

  Future<void> apiCall() async {
    isLoading(true);
    final FlightData? data =
        await processData(startController.text, endController.text);
    isLoading(false);
    if(data != null){
      flightData = data;
    }

    addLinesAndMarkers();
    stats.value = Stats(
        startCityCode: startController.text,
        endCityCode: endController.text,
        temp: flightData.weather.first.temperature2m,
        wind: flightData.weather.first.windSpeed10m,
        precipitation: flightData.weather.first.precipitation,
        startTime: DateTime.now());
    resultForStats.clear();

    resultForStats.addAll(getWeatherCondition(calculateRiskPercentage(
        stats.value.temp, stats.value.precipitation, stats.value.wind)));

    resultForStats.refresh();

    //uncomment to start animation
    animateFlightPath();
  }


  void animateFlightPath() async{
    for(int i=1;i<flightData.path.length;i++) {
      await Future.delayed(const Duration(milliseconds: 300));


      stats.value = Stats(
          startCityCode: startController.text,
          endCityCode: endController.text,
          temp: flightData.weather[i].temperature2m,
          wind: flightData.weather[i].windSpeed10m,
          precipitation: flightData.weather[i].precipitation,
          startTime: DateTime.now());
      resultForStats.clear();

      resultForStats.addAll(getWeatherCondition(calculateRiskPercentage(
          stats.value.temp, stats.value.precipitation, stats.value.wind)));

      resultForStats.refresh();

      cameraLL(flightData.path.first);

      travelled.clear();
      toTravel.clear();
      markers.clear();

      travelled.add(
        Polyline(
          points: flightData.path.sublist(0, i),
          color: Colors.black12,
          strokeWidth: 3,
          isDotted: true
        ),
      );

      toTravel.add(
        Polyline(
          points: flightData.path.sublist(i),
          color: Colors.orange,
          strokeWidth: 3,
        ),
      );

      markers.addAll(
        [
          Marker(
            point: flightData.path[i],
            width: 30,
            height: 30,
            child: AirplaneWidget(
              start: flightData.path[i - 1],
              end: flightData.path[i],
            ),
          ),
          Marker(
            point: flightData.path.first,
            width: 25,
            height: 25,
            child: CustomPaint(
              size: const Size(300, 300), // Specify the size of the canvas
              painter: ConcentricCirclesPainter(),
            ),
          ),
          Marker(
            point: flightData.path.last, // London, United Kingdom
            width: 25,
            height: 25,
            child: CustomPaint(
              size: const Size(300, 300), // Specify the size of the canvas
              painter: ConcentricCirclesPainter(
                  isSingle: true, innerColor: Colors.black),
            ),
          ),
        ],
      );

      travelled.refresh();
      toTravel.refresh();
      markers.refresh();
    }
  }
}
