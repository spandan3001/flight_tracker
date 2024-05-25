import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/main_controller.dart';
import 'app_colors.dart';
import 'circular_icon.dart';

class WeatherDetail extends StatelessWidget {
  final double height;
  final double currentAngle;
  final AnimationController animationController;
  final bool isPlaying;
  final VoidCallback onMore;

  const WeatherDetail({
    super.key,
    required this.height,
    required this.currentAngle,
    required this.animationController,
    required this.isPlaying,
    required this.onMore,
  });

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<MainController>();
    return Container(
      padding:
          const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 8.0),
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: AppColors.darkCardColor,
          borderRadius: BorderRadius.only(
              bottomRight: const Radius.circular(5),
              bottomLeft: const Radius.circular(5),
              topRight: height == 0
                  ? const Radius.circular(5)
                  : const Radius.circular(0),
              topLeft: height == 0
                  ? const Radius.circular(5)
                  : const Radius.circular(0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() =>AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: controller.resultForStats.value['color'],
              borderRadius: BorderRadius.circular(5),
            ),
            child:Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircularIconContainer(
                      bgColor: AppColors.cardColor,
                      icon: controller.resultForStats.value['icon'],
                      label: 'Condition',
                      text: controller.resultForStats.value['text'],
                    ),
                    CircularIconContainer(
                      bgColor: AppColors.cardColor,
                      icon: Icons.air_outlined,
                      label: 'Wind',
                      text: controller.stats.value.wind.toString(),
                    ),
                    CircularIconContainer(
                      bgColor: AppColors.cardColor,
                      icon: Icons.thermostat_outlined,
                      label: 'temp',
                      text: controller.stats.value.temp.toString(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Risk Factor : ${controller.resultForStats.value['percentage'].toString()}",
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 3),
                Text(
                  controller.resultForStats.value['condition'],
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),

              ],
            ),
          )),

          const SizedBox(height: 10),
          if (!isPlaying)
            const Text(
              "Show More Info",
              style: TextStyle(
                  color: AppColors.redColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          GestureDetector(
            onTap: onMore,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: currentAngle,
                  child: Icon(
                    Icons.arrow_drop_down,
                    size: 25.spMin,
                    color: AppColors.redColor,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
