import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs/screenutil.dart';

class CustomProgressIndicator extends StatefulWidget {
  final double progress;
  final String pointerSvg; // Add a property for the SVG asset

  const CustomProgressIndicator({
    Key? key,
    required this.progress,
    required this.pointerSvg, // Initialize the SVG asset
  }) : super(key: key);

  @override
  _CustomProgressIndicatorState createState() =>
      _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..addListener(() {
            setState(() {});
          });
    _controller.animateTo(widget.progress);
  }

  @override
  void didUpdateWidget(CustomProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _controller.animateTo(widget.progress);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _calculatePointerAngle() {
    // Adjust the angle to match your arc's starting point
    final startAngle = math.pi / 1.35;
    // Calculate the angle based on progress
    return startAngle + (2 * math.pi * _controller.value);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          painter: _CustomProgressPainter(progress: _controller.value),
          size: Size(200, 200),
        ),
        // Use Transform.rotate to rotate the SvgPicture for the pointer
        Transform.rotate(
          angle: _calculatePointerAngle(),
          // child: SvgPicture.asset(
          //   widget.pointerSvg,
          //   width: 128, // Adjust the size of the pointer as needed
          // )

          child: Transform.translate(
            offset: Offset(HYSizeFit.setRpx(60), -1),
            // Moves the child 50 units right and 100 units down
            child: Transform.rotate(
              angle: 280.3,
              // You'll need to write this function
              child: SizedBox(
                width: HYSizeFit.setRpx(96),
                height: HYSizeFit.setRpx(90),
                child: SvgPicture.string(
                  widget.pointerSvg,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                  // color: string2Color("#b2b2b2"),
                ),
              ),
            ), // Replace with your widget
          ),
        ),
      ],
    );
  }
}

class _CustomProgressPainter extends CustomPainter {
  final double progress;

  _CustomProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xff395FF5)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Start the progress arc from the bottom of the circle (6 o'clock position)
    final double startAngle = math.pi / 1.35; // 90 degrees in radians

    // Draw the arc
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ),
      startAngle,
      math.pi * 2 * progress,
      false,
      paint,
    );

    // Calculate the position for the pointer
    final double pointerAngle = startAngle + math.pi * 2 * progress;
    final double pointerLength = size.width / 2;
    final Offset pointerEnd = Offset(
      size.width / 2 + pointerLength * math.cos(pointerAngle),
      size.height / 2 + pointerLength * math.sin(pointerAngle),
    );

    // Draw the pointer
    paint..strokeWidth = 3;
    // canvas.drawLine(Offset(size.width / 2, size.height / 2), pointerEnd, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
