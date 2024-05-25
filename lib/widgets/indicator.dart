
import 'package:flutter/material.dart';

double calculateRiskPercentage(double T, double P, double W) {
  double temperatureRisk = 0.3 * (T + 10) / 50;
  //manipulated
  double precipitationRisk = 0.2 * (P < 1 ? P : 1);
  double windSpeedRisk = 0.5 * W / 50;

  double totalRisk = temperatureRisk + precipitationRisk + windSpeedRisk;
  double riskPercentage = (totalRisk * 100)/2;
  riskPercentage = double.parse(riskPercentage.toStringAsFixed(2));

  return riskPercentage;
}

Map<String, dynamic> getWeatherCondition(double percentage) {
  Color color;
  String condition;
  String text;
  IconData icon;

  if (percentage >= 0 && percentage <= 20) {
    color = Colors.green;
    condition = 'Excellent!!,You Can Fly Easily';
    text = "Clear";
    icon = Icons.wb_sunny_outlined;

  } else if (percentage > 20 && percentage <= 60) {
    color = Colors.orange;
    text = "little Cloudy";
    condition = 'Fair,But Risky Too';
    icon = Icons.wb_cloudy_outlined;
  } else if (percentage > 60 && percentage <= 100) {
    color = Colors.red;
    text = "Rainy";
    condition = 'Bad!!!,Yon Cannot Fly';
    icon = Icons.cloudy_snowing;
  } else {
    // Handle invalid percentage values
    color = Colors.grey;
    condition = 'Unknown';
    text = "Tsunami";
    icon = Icons.tsunami;
  }

  return {
    'color': color,
    'condition': condition,
    'text':text,'icon':icon,
    'percentage':percentage,
  };
}

