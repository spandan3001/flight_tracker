import 'package:flight_tracker/constants/weather_details.dart';
import 'package:flutter/material.dart';
import '../constants/flight_details.dart';
import 'dart:math' show pi;
import 'package:flutter_screenutil/flutter_screenutil.dart';
class DetailCard extends StatefulWidget {
  const DetailCard({super.key});

  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard>
    with SingleTickerProviderStateMixin {
  double _height = 0.0;
  final double _boxHeight = 0.25.sh;
  bool isPlaying = false;
  double _currentAngle = pi;
  late final AnimationController _animationController;
  void _handleOnPressed() {
    setState(() {
      _height = _height == 0 ? _boxHeight : 0;
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    _animationController.addListener(() {
      setState(() {
        _currentAngle = pi-(pi*_animationController.value);
      });
    });
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
      decoration: const BoxDecoration(color: Colors.transparent, boxShadow: [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(-4, -3),
          spreadRadius: 1,
          blurRadius: 30,
        ),
      ]),
      child: Column(

        children: [
          FlightDetail(height:_height),
          WeatherDetail(height: _height, currentAngle: _currentAngle, animationController: _animationController, isPlaying: isPlaying, onMore: _handleOnPressed),
        ],
      ),
    );
  }
}
