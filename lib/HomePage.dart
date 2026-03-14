import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobs/screenutil.dart';
import 'package:jobs/toast_util.dart';

import 'SVGUtil.dart';
import 'constants.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _formKey = GlobalKey<FormState>();

  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadInterstitialAd();
  }

  void _loadInterstitialAd() {
    // Future.delayed(Duration(milliseconds: 20000), () {
    //   FirebaseCrashlytics.instance.crash();
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  itemWidget(title, value, unit, callback) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '$title',
              style: TextStyle(
                color: Colors.black,
                fontSize: HYSizeFit.setRpx(40),
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
            SizedBox(
              width: HYSizeFit.setRpx(15),
            ),
            Container(
              width: HYSizeFit.setRpx(331),
              height: HYSizeFit.setRpx(82),
              decoration: ShapeDecoration(
                color: Color(0xFFEFF0F2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(29),
                ),
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: HYSizeFit.setRpx(0),
                              bottom: HYSizeFit.setRpx(0)),
                          alignment: Alignment.center,

                          // Text(
                          //   '$value',
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: HYSizeFit.setRpx(40),
                          //     fontFamily: 'PingFang SC',
                          //     fontWeight: FontWeight.w600,
                          //     height: 0,
                          //   ),
                          // ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: HYSizeFit.setRpx(40)),
                        child: Text(
                          '$unit',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: HYSizeFit.setRpx(40),
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: HYSizeFit.setRpx(140), top: HYSizeFit.setRpx(5)),
          height: HYSizeFit.setRpx(82),
          alignment: Alignment.center,
          child: TextFormField(
            maxLength: 3,
            showCursor: true,
            cursorWidth: 2.5,
            cursorHeight: HYSizeFit.setRpx(36),
            cursorColor: const Color(0xFF3A5FF5),
            cursorRadius: const Radius.circular(1),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: HYSizeFit.setRpx(22),
                horizontal: HYSizeFit.setRpx(16),
              ),
              hintText: '$value',
              counterText: "",
              filled: true,
              hintStyle: TextStyle(
                color: const Color(0xFF999999),
                fontSize: HYSizeFit.setRpx(40),
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
              border: InputBorder.none,
              fillColor: Colors.transparent,
            ),
            style: TextStyle(
              color: Colors.black,
              fontSize: HYSizeFit.setRpx(40),
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w600,
              height: 1.2,
              letterSpacing: 0.5,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please input $title';
              }
              return null;
            },
            onChanged: (value) {
              callback(value);
            },
          ),
        )
      ],
    );
  }

  DateTime _lastPressedAt = DateTime.now();

  @override
  Widget build(BuildContext context) {
    HYSizeFit.initialize(context);

    var isFamale = useState(true);

    var weightState = useState("");
    var heightState = useState("");
    var ageState = useState("");

    return WillPopScope(
      onWillPop: () {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 2)) {
          // 如果两次按下时间间隔大于2秒，则更新时间戳，并显示一个提示消息
          _lastPressedAt = DateTime.now();
          ToastUtil.show("再按一次退出");
          HapticFeedback.mediumImpact();
          return Future.value(false);
        }
        // 如果两次按下时间间隔小于2秒，则退出应用程序
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () => ToastUtil.hideKeyboard(context),
          behavior: HitTestBehavior.translucent,
          child: Container(
            width: HYSizeFit.screenWidth,
            height: HYSizeFit.screenHeight,
            child: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: HYSizeFit.setRpx(100)),
                        child: Text(
                          'Personal data setting',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: HYSizeFit.setRpx(40),
                            fontFamily: 'Suez One',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: HYSizeFit.setRpx(9)),
                        child: Text(
                          'Calculate your BMI based on your profile',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: HYSizeFit.setRpx(28),
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          isFamale.value = !isFamale.value;
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: HYSizeFit.setRpx(46)),
                          width: HYSizeFit.setRpx(372),
                          height: HYSizeFit.setRpx(157),
                          decoration: ShapeDecoration(
                            color: Color(0xFFD6D6D6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(69),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: HYSizeFit.setRpx(372),
                                  height: HYSizeFit.setRpx(157),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: HYSizeFit.setRpx(372),
                                          height: HYSizeFit.setRpx(157),
                                          decoration: ShapeDecoration(
                                            color: Color(0xFFD6D6D6),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(69),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 254,
                                        top: 26,
                                        child: Container(
                                          width: 66,
                                          height: 106,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 66,
                                                  height: 106,
                                                  decoration: BoxDecoration(
                                                      color: Color(0x00D9D9D9)),
                                                ),
                                              ),
                                              Positioned(
                                                left: 6,
                                                top: 6,
                                                child: Container(
                                                  width: 54.06,
                                                  height: 95,
                                                  child: Stack(
                                                    children: [
                                                      Positioned(
                                                        left: 17,
                                                        top: 0,
                                                        child: Opacity(
                                                          opacity: 0.20,
                                                          child: Container(
                                                            width: 21,
                                                            height: 21,
                                                            decoration:
                                                                ShapeDecoration(
                                                              color: Color(
                                                                  0xFF474747),
                                                              shape:
                                                                  OvalBorder(),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //TODO：女
                              isFamale.value
                                  ? Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        // width: HYSizeFit.setRpx(234),
                                        // height: HYSizeFit.setRpx(157),
                                        child: Stack(
                                          children: [
                                            // Positioned(
                                            //   left: 0,
                                            //   top: 0,
                                            //   child: Container(
                                            //     width: HYSizeFit.setRpx(234),
                                            //     height: HYSizeFit.setRpx(157),
                                            //     decoration: ShapeDecoration(
                                            //       gradient: LinearGradient(
                                            //         begin: Alignment(-0.86, -0.51),
                                            //         end: Alignment(0.86, 0.51),
                                            //         colors: [
                                            //           Color(0xFF94A9FF),
                                            //           Color(0xFF3A5FF5)
                                            //         ],
                                            //       ),
                                            //       shape: RoundedRectangleBorder(
                                            //         borderRadius:
                                            //             BorderRadius.circular(69),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: HYSizeFit.setRpx(3),
                                                  top: HYSizeFit.setRpx(0.5)),
                                              width: HYSizeFit.setRpx(234),
                                              height: HYSizeFit.setRpx(157),
                                              child: SvgPicture.string(
                                                SVGUtil.svg_z3315x,
                                                allowDrawingOutsideViewBox:
                                                    true,
                                                fit: BoxFit.fill,
                                                // color: string2Color("#b2b2b2"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(
                                          left: HYSizeFit.setRpx(52),
                                          top: HYSizeFit.setRpx(26)),
                                      width: HYSizeFit.setRpx(66),
                                      height: HYSizeFit.setRpx(106),
                                      child: SvgPicture.string(
                                        SVGUtil.famale_nor,
                                        allowDrawingOutsideViewBox: true,
                                        fit: BoxFit.fill,
                                        // color: string2Color("#b2b2b2"),
                                      ),
                                    ),
                              isFamale.value
                                  ? Positioned(
                                      right: HYSizeFit.setRpx(40),
                                      top: HYSizeFit.setRpx(26),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: HYSizeFit.setRpx(3),
                                            top: HYSizeFit.setRpx(0.5)),
                                        width: HYSizeFit.setRpx(66),
                                        height: HYSizeFit.setRpx(106),
                                        child: SvgPicture.string(
                                          SVGUtil.male,
                                          allowDrawingOutsideViewBox: true,
                                          fit: BoxFit.fill,
                                          // color: string2Color("#b2b2b2"),
                                        ),
                                      ),
                                    )
                                  : Positioned(
                                      right: 0,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: HYSizeFit.setRpx(3),
                                            top: HYSizeFit.setRpx(0.5)),
                                        width: HYSizeFit.setRpx(234),
                                        height: HYSizeFit.setRpx(157),
                                        child: SvgPicture.string(
                                          SVGUtil.male_press,
                                          allowDrawingOutsideViewBox: true,
                                          fit: BoxFit.fill,
                                          // color: string2Color("#b2b2b2"),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: HYSizeFit.setRpx(140)),
                        width: HYSizeFit.screenWidth,
                        child: Center(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: HYSizeFit.setRpx(100),
                                ),
                                itemWidget("Weight", "", "kg", (value) {
                                  weightState.value = value;
                                }),
                                SizedBox(
                                  height: HYSizeFit.setRpx(75),
                                ),
                                itemWidget("Height", "", "cm", (value) {
                                  heightState.value = value;
                                }),
                                SizedBox(
                                  height: HYSizeFit.setRpx(75),
                                ),
                                itemWidget("Age", "", "years", (value) {
                                  ageState.value = value;
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: HYSizeFit.setRpx(100),
                      ),
                      GestureDetector(
                        onTap: () {
                          Future.delayed(const Duration(milliseconds: 0), () {
                            // ToastUtil.showEasyLoading(delay: 500);
                            ToastUtil.hideKeyboard(context);
                            ToastUtil.show("Calculating...");
                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    routeNameSearchResultPage, (route) => false,
                                    arguments: {
                                      "weightState": weightState.value,
                                      "heightState": heightState.value,
                                      "ageState": ageState.value,
                                    });
                              }
                            });
                          });
                        },
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          width: HYSizeFit.setRpx(402),
                          height: HYSizeFit.setRpx(98),
                          decoration: ShapeDecoration(
                            color: Color(0xFF3A5FF5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60),
                            ),
                          ),
                          child: Text(
                            'complete',
                            style: TextStyle(
                              color: Color(0xFFFFF8F8),
                              fontSize: HYSizeFit.setRpx(30),
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

