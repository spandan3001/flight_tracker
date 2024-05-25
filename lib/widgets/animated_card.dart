import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconAnimationButton extends StatefulWidget {
  const IconAnimationButton(
      {super.key,
      required this.isScrollable,
      required this.text,
      required this.color,
      required this.content,
      required this.onPressed});

  final bool isScrollable;
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final String content;

  @override
  State<IconAnimationButton> createState() => _IconAnimationButtonState();
}

class _IconAnimationButtonState extends State<IconAnimationButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  var isPlaying = false;
  double _height = 0;
  final double _boxHeight = 0.45.sh;

  void _handleOnPressed() {
    setState(() {
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

  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          height: _height,
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)),
            border: Border.all(
              color: _height == 0 ? Colors.white : widget.color,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
        ),
        TextButton(
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(
                Size(1.sw, 0.5)),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(widget.color),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(5),
                  topLeft: const Radius.circular(5),
                  bottomLeft: Radius.circular(_height == 0 ? 0 : 0),
                  bottomRight: Radius.circular(_height == 0 ? 0 : 0),
                ),
              ),
            ),
          ),
          onPressed: () {
            _handleOnPressed();
            setState(() {
              _height = _height == 0 ? _boxHeight : 0;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.text,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      widget.content,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (widget.isScrollable)
                      const SizedBox(
                        width: 10,
                      ),
                    if (widget.isScrollable)
                      AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        progress: _animationController,

                      ),
                  ],
                ),

                //Rive(artboard: artBoard),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
