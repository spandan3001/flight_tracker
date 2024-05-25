import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as lac;
import 'package:flutter/services.dart';

Future<ui.Image> loadImage(String assetPath) async {
  final ByteData data = await rootBundle.load(assetPath);
  final Completer<ui.Image> completer = Completer();
  ui.decodeImageFromList(data.buffer.asUint8List(), (ui.Image img) {
    completer.complete(img);
  });
  return completer.future;
}

class AirplanePainter extends CustomPainter {
  final List<lac.LatLng> points;
  final Animation<double> animation;
  final ui.Image airplaneImage;

  AirplanePainter({
    required this.points,
    required this.animation,
    required this.airplaneImage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    final offsets = getOffsets(points, size);

    if (offsets.isEmpty) return;

    path.moveTo(offsets.first.dx, offsets.first.dy);
    for (var i = 0; i < offsets.length - 1; i++) {
      final p0 = offsets[i];
      final p1 = offsets[i + 1];
      final controlPoint = Offset(
        (p0.dx + p1.dx) / 2 + (p1.dy - p0.dy) * 0.5,
        (p0.dy + p1.dy) / 2 - (p1.dx - p0.dx) * 0.5,
      );
      path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, p1.dx, p1.dy);
    }

    canvas.drawPath(path, paint);

    final position = animation.value;
    final totalLength = path.computeMetrics().fold<double>(
        0.0, (previousValue, metric) => previousValue + metric.length);
    final currentLength = totalLength * position;

    final tangent = path.computeMetrics().fold<ui.Tangent?>(
        null, (ui.Tangent? previousValue, ui.PathMetric metric) {
      final length = metric.length;
      if (currentLength <= length) {
        return metric.getTangentForOffset(currentLength);
      }
      return previousValue;
    });

    if (tangent != null) {
      final iconSize = 24.0; // Adjust the size of the airplane icon
      final angle = tangent.angle;
      final position = tangent.position;

      canvas.save();
      canvas.translate(position.dx, position.dy);
      canvas.rotate(angle);
      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: iconSize,
        height: iconSize,
      );
      canvas.drawImageRect(
        airplaneImage,
        Rect.fromLTWH(0, 0, airplaneImage.width.toDouble(),
            airplaneImage.height.toDouble()),
        rect,
        Paint(),
      );
      canvas.restore();
    }
  }

  List<Offset> getOffsets(List<lac.LatLng> points, Size size) {
    final offsets = <Offset>[];
    for (final point in points) {
      final offset = Offset(
        (point.longitude - points.first.longitude) * size.width / 2 + size.width / 2,
        (points.first.latitude - point.latitude) * size.height / 2 + size.height / 2,
      );
      offsets.add(offset);
    }
    return offsets;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}



class FlightPathAnimation extends StatefulWidget {
  final List<lac.LatLng> points;
  final String airplaneImagePath;

  FlightPathAnimation({
    required this.points,
    required this.airplaneImagePath,
  });

  @override
  _FlightPathAnimationState createState() => _FlightPathAnimationState();
}

class _FlightPathAnimationState extends State<FlightPathAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  ui.Image? airplaneImage;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _loadAirplaneImage();
  }

  Future<void> _loadAirplaneImage() async {
    final image = await loadImage(widget.airplaneImagePath);
    setState(() {
      airplaneImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (airplaneImage == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: AirplanePainter(
            points: widget.points,
            animation: _animation,
            airplaneImage: airplaneImage!,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
