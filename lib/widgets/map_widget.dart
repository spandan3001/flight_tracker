import 'package:flight_tracker/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

class MapCard extends StatefulWidget {
  const MapCard({super.key});

  @override
  State<MapCard> createState() => _MapCardState();
}

class _MapCardState extends State<MapCard> {
  final MainController controller = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => FlutterMap(
      options: MapOptions(
        initialCenter: controller.cameraLL.value,
        initialZoom: 2,
      ),
      children: [
        TileLayer(
          //urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          urlTemplate: 'https://tile.openstreetmap.bzh/br/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),

        Obx(() => PolylineLayer(
          polylines: controller.travelled.value,


        )),
        Obx(() => PolylineLayer(
          polylines: controller.toTravel.value,
        )),
        Obx(() => MarkerLayer(
          markers: controller.markers.value,
        )),


      ],
    ));
  }
}
