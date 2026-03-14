import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobs/rainBowWidget.dart';
import 'package:jobs/screenutil.dart';

import 'SVGUtil.dart';

class SeatPlanPage extends StatefulWidget {
  const SeatPlanPage({super.key});

  @override
  State<SeatPlanPage> createState() => _SeatPlanPageState();
}

class _SeatPlanPageState extends State<SeatPlanPage> {
  itemWidget(color, title, subTitle) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: HYSizeFit.setRpx(16)),
      child: Column(
        children: [
          Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: HYSizeFit.setRpx(22),
                      height: HYSizeFit.setRpx(22),
                      decoration: ShapeDecoration(
                        color: color,
                        shape: OvalBorder(),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      '$title',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: HYSizeFit.setRpx(30),
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(width: 243),
              Text(
                '$subTitle',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: HYSizeFit.setRpx(30),
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: HYSizeFit.setRpx(10),
          ),
          Divider(
            color: Color(0xffEBEBEB),
            height: 1,
          ),
          SizedBox(
            height: HYSizeFit.setRpx(20),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: HYSizeFit.setRpx(16)),
        child: Column(
          children: [
            SizedBox(height: HYSizeFit.setRpx(100)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: HYSizeFit.setRpx(48),
                    height: HYSizeFit.setRpx(48),
                    child: SvgPicture.string(
                      SVGUtil.backPress,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                      // color: string2Color("#b2b2b2"),
                    ),
                  ),
                ),
                Text(
                  'INSTRUCTIONS',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: HYSizeFit.setRpx(30),
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                Container(
                  width: HYSizeFit.setRpx(50),
                  height: HYSizeFit.setRpx(50),
                ),
              ],
            ),
            // RainBowWidget(progress: 0.01, isShowLine: true),
            Transform.scale(
              scale: 0.92,
              child: Container(
                margin: EdgeInsets.only(
                  top: HYSizeFit.setRpx(53),
                ),
                width: HYSizeFit.setRpx(494),
                height: HYSizeFit.setRpx(396),
                child: SvgPicture.string(
                  SVGUtil.placeholderLine,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                  // color: string2Color("#b2b2b2"),
                ),
              ),
            ),
            SizedBox(
              height: HYSizeFit.setRpx(60),
            ),
            itemWidget(Color(0xFF7370FE), "Severe underweight", "< 16.0"),
            itemWidget(
                Color(0xFF8694FE), "Moderate underweight", "16.0 - 16.9"),
            itemWidget(Color(0xFFA4CDFF), "Mild underweight", "17.0 - 18.4"),
            itemWidget(Color(0xFF01D044), "Healthy weight", "18.5 - 24.9"),
            itemWidget(
                Color(0xFFFBA422), "Overweight (Pre-Obese)", "25.0 - 29.9"),
            itemWidget(Color(0xFFFB862B), "Obese (Class I)", "30.0 - 34.9"),
            itemWidget(Color(0xFFFB6B34), "Obese (Class II)", "35.0 - 39.9"),
            itemWidget(Color(0xFFFB5A3A), "Obese (Class III)", "≥ 40.0"),
          ],
        ),
      ),
    );
  }
}
