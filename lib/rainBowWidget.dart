import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs/screenutil.dart';

import 'CustomProgressIndicator.dart';
import 'ResultPage.dart';
import 'SVGUtil.dart';

class RainBowWidget extends StatefulWidget {
  final double progress;
  final bool isShowLine;

  const RainBowWidget(
      {super.key, required this.progress, this.isShowLine = false});

  @override
  State<RainBowWidget> createState() => _RainBowWidgetState();
}

class _RainBowWidgetState extends State<RainBowWidget> {
  @override
  Widget build(BuildContext context) {
    HYSizeFit.initialize(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: HYSizeFit.setRpx(113)),
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: HYSizeFit.setRpx(20), top: HYSizeFit.setRpx(75)),
            width: HYSizeFit.setRpx(72),
            height: HYSizeFit.setRpx(255),
            child: SvgPicture.string(
              SVGUtil.leftRoColor,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
              // color: string2Color("#b2b2b2"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                right: HYSizeFit.setRpx(52), left: HYSizeFit.setRpx(80)),
            width: HYSizeFit.setRpx(275),
            height: HYSizeFit.setRpx(75),
            child: SvgPicture.string(
              SVGUtil.topRoColor,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
              // color: string2Color("#b2b2b2"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: HYSizeFit.setRpx(75), left: HYSizeFit.setRpx(340)),
            width: HYSizeFit.setRpx(72),
            height: HYSizeFit.setRpx(255),
            child: SvgPicture.string(
              SVGUtil.rightRoColor,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
              // color: string2Color("#b2b2b2"),
            ),
          ),
          if (widget.isShowLine)
            Container(
              margin: EdgeInsets.only(
                  top: HYSizeFit.setRpx(65),
                  right: HYSizeFit.setRpx(52),
                  left: HYSizeFit.setRpx(80)),
              width: HYSizeFit.setRpx(271),
              height: HYSizeFit.setRpx(221),
              child: SvgPicture.string(
                SVGUtil.smallColor,
                allowDrawingOutsideViewBox: true,
                fit: BoxFit.fill,
                // color: string2Color("#b2b2b2"),
              ),
            ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: HYSizeFit.setRpx(100),
                    right: HYSizeFit.setRpx(52),
                    left: HYSizeFit.setRpx(95)),
                width: HYSizeFit.setRpx(241),
                height: HYSizeFit.setRpx(191),
                child: CustomProgressIndicator(
                    // progress: 0.75, pointerSvg: SVGUtil.linePurpose),
                    progress: widget.progress,
                    pointerSvg: SVGUtil.linePurpose),
              ),
              Container(
                width: HYSizeFit.setRpx(21),
                height: HYSizeFit.setRpx(21),
                margin: EdgeInsets.only(
                    top: HYSizeFit.setRpx(100), left: HYSizeFit.setRpx(38)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.5),
                    color: Color(0xff395FF5)),
              )
              // Container(
              //   width: 100,
              //   height: 100,
              //   // color: Colors.black,
              //   child: Transform.rotate(
              //     angle: calculatePointerAngle(0.1),
              //     // You'll need to write this function
              //     child: Container(
              //       width: HYSizeFit.setRpx(128),
              //       height: HYSizeFit.setRpx(77),
              //       child: SvgPicture.string(
              //         SVGUtil.linePurpose,
              //         allowDrawingOutsideViewBox: true,
              //         fit: BoxFit.fill,
              //         // color: string2Color("#b2b2b2"),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
