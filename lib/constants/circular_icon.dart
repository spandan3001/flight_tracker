import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_colors.dart';


class CircularIconContainer extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final String label;
  final String text;

  const CircularIconContainer({super.key, required this.icon, required this.bgColor, required this.label, required this.text,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: bgColor, // Background color
            shape: BoxShape.circle, // Circular shape
          ),
          child: Center(
            child: Icon(
              icon, // Icon to display
              color: AppColors.darkIconColor, // Icon color
              size: 35.0, // Icon size
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(label,style: const TextStyle(fontSize: 10,color: Colors.white),),
        Text(text,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
      ],
    );
  }
}