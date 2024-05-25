
import 'package:flight_tracker/model/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../api/api.dart';
import '../controller/main_controller.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  bool _isExpanded = false;
  final MainController controller = Get.find<MainController>();
  //final TextEditingController _startController = TextEditingController();
  //final TextEditingController _endController = TextEditingController();

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: GestureDetector(
          onTap: _toggleExpand,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isExpanded)
                  CupertinoSearchTextField(
                    backgroundColor: Colors.white,
                    controller: controller.startController,
                    placeholder: "Start Location",
                    padding: EdgeInsets.all(14.sp),
                    onTap: _toggleExpand,
                  ),
                if (_isExpanded) ...[
                  const SizedBox(height: 10),
                  TextField(
                    controller: controller.startController,
                    decoration: InputDecoration(
                      hintText: 'Start Location',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: controller.endController,
                    decoration: InputDecoration(
                      hintText: 'End Location',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                    ),
                    onSubmitted: (value) async{
                      _toggleExpand();
                      final MainController controller = Get.find();
                      await controller.apiCall();
                    },
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
