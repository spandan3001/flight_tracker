import 'package:flight_tracker/controller/main_controller.dart';
import 'package:flight_tracker/widgets/detail_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/map_widget.dart';
import 'widgets/search_bar.dart';

class FlightScreen extends StatefulWidget {
  const FlightScreen({super.key});

  @override
  State<FlightScreen> createState() => _FlightScreenState();
}

class _FlightScreenState extends State<FlightScreen> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();
    return Scaffold(
      body: Obx(() => Stack(
        children: [
          const MapCard(),
          const CustomSearchBar(),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: DetailCard(),
          ),
          if(controller.isLoading.value)
            const Center(child: CircularProgressIndicator())

        ],
      )),
    );
  }
}
