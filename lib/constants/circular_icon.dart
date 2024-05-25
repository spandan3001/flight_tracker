import 'package:flutter/material.dart';
import 'app_colors.dart';

class CircularIconContainer extends StatelessWidget {
  final IconData icon; // Icon to be displayed in the container
  final Color bgColor; // Background color of the container
  final String label; // Label text to be displayed below the icon
  final String text; // Text to be displayed below the label

  // Constructor to initialize the properties
  const CircularIconContainer({
    super.key,
    required this.icon,
    required this.bgColor,
    required this.label,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50.0, // Width of the circular container
          height: 50.0, // Height of the circular container
          decoration: BoxDecoration(
            color: bgColor, // Background color of the container
            shape: BoxShape.circle, // Circular shape of the container
          ),
          child: Center(
            child: Icon(
              icon, // Icon to display inside the container
              color: AppColors.darkIconColor, // Color of the icon
              size: 35.0, // Size of the icon
            ),
          ),
        ),
        const SizedBox(height: 5), // Space between the icon and the label
        Text(
          label,
          style: const TextStyle(
            fontSize: 10, // Font size of the label
            color: Colors.white, // Color of the label text
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15, // Font size of the text
            fontWeight: FontWeight.bold, // Font weight of the text
            color: Colors.white, // Color of the text
          ),
        ),
      ],
    );
  }
}
