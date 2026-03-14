import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobs/rainBowWidget.dart';
import 'package:jobs/screenutil.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:jobs/toast_util.dart';

import 'CustomProgressIndicator.dart';
import 'SVGUtil.dart';
import 'dart:math' as math;

import 'constants.dart';

// double totalProgress = 0.726;
double totalProgress = 0.242;

class ResultPage extends StatefulHookConsumerWidget {
  const ResultPage({super.key});

  @override
  ConsumerState<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends ConsumerState<ResultPage> {
  final _formKey = GlobalKey<FormState>();

  double weight = 0;
  double height = 1;
  double age = 1;
  double result = 0;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    final argList = ModalRoute.of(context)!.settings.arguments as Map;
    print("argList:$argList");
    weight = (double.tryParse(argList['weightState'] ?? "0") ?? 0);
    height = (double.tryParse(argList['heightState'] ?? "1") ?? 1);
    age = (double.tryParse(argList['ageState'] ?? "1") ?? 1);
    double result = weight / (height * height);
    //0~18.4 18.5~24.9 25~39 40~1000
    // result = 42;
    if (result < 18.5) {
      totalProgress = result / 18.5 * 0.242;
    } else if ((result + 1) < 26) {
      totalProgress = ((result + 1) - 18.5) / 6.5 * 0.242 + 0.242;
    } else if ((result + 1) < 42) {
      totalProgress = ((result + 1) - 25) / 15 * 0.242 + 0.484;
    } else {
      totalProgress = 0.736;
    }
    setResult(
        weightValue: (double.tryParse(argList['weightState'] ?? "0") ?? 0),
        heightValue: (double.tryParse(argList['heightState'] ?? "1") ?? 1),
        ageValue: (double.tryParse(argList['ageState'] ?? "1") ?? 1));
  }

  setResult({weightValue, heightValue, ageValue, callback}) {
    weight = weightValue;
    height = heightValue;
    age = ageValue;
    result = double.tryParse(
            (num.tryParse('${weight / ((height / 100) * (height / 100))}') ?? 0)
                .toStringAsFixed(2)) ??
        0;
    //0~18.4 18.5~24.9 25~39 40~1000
    // result = 42;
    if (result < 18.5) {
      totalProgress = result / 18.5 * 0.242;
    } else if ((result + 1) < 26) {
      totalProgress = ((result + 1) - 18.5) / 6.5 * 0.242 + 0.242;
    } else if ((result + 1) < 42) {
      totalProgress = ((result + 1) - 25) / 15 * 0.242 + 0.484;
    } else {
      totalProgress = 0.736;
    }

    if (callback != null) {
      callback(result, totalProgress);
    }
  }

  editWidget(title, value, controller, {node, unit, autoFocus, callback}) {
    return Stack(
      children: [
        Row(
          children: [
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
            SizedBox(
              width: HYSizeFit.setRpx(6),
            ),
            Container(
              alignment: AlignmentDirectional.centerStart,
              width: HYSizeFit.setRpx(204),
              height: HYSizeFit.setRpx(70),
              decoration: ShapeDecoration(
                color: Color(0xFFEFF0F2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Container()
                            // Text(
                            //   '$value',
                            //   style: TextStyle(
                            //     color: Colors.black,
                            //     fontSize: HYSizeFit.setRpx(30),
                            //     fontFamily: 'PingFang SC',
                            //     fontWeight: FontWeight.w600,
                            //     height: 0,
                            //   ),
                            //   textAlign: TextAlign.center,
                            // ),
                            ),
                        Container(
                          margin: EdgeInsets.only(right: HYSizeFit.setRpx(12)),
                          child: Text(
                            '$unit',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: HYSizeFit.setRpx(28),
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      autoFocus();
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: HYSizeFit.setRpx(17)),
                      width: HYSizeFit.setRpx(36),
                      height: HYSizeFit.setRpx(36),
                      child: SvgPicture.string(
                        SVGUtil.edit,
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.fill,
                        // color: string2Color("#b2b2b2"),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        Container(
          width: HYSizeFit.setRpx(190),
          height: HYSizeFit.setRpx(70),
          padding: EdgeInsets.only(bottom: HYSizeFit.setRpx(13)),
          margin: EdgeInsets.only(
              left: HYSizeFit.setRpx(title == "Age" ? 40 : 60),
              bottom: HYSizeFit.setRpx(32)),
          alignment: Alignment.center,
          child: TextFormField(
            maxLength: 3,
            focusNode: node,
            showCursor: true,
            cursorWidth: 2.5,
            cursorHeight: HYSizeFit.setRpx(28),
            cursorColor: const Color(0xFF3A5FF5),
            cursorRadius: const Radius.circular(1),
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            textAlign: TextAlign.center,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: HYSizeFit.setRpx(20),
                horizontal: HYSizeFit.setRpx(12),
              ),
              counterText: "",
              filled: true,
              hintStyle: TextStyle(
                color: const Color(0xFF999999),
                fontSize: HYSizeFit.setRpx(30),
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
              border: InputBorder.none,
              fillColor: Colors.transparent,
            ),
            style: TextStyle(
              color: Colors.black,
              fontSize: HYSizeFit.setRpx(30),
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

  double calculatePointerAngle(double progress) {
    // Full circle in radians is 2 * PI, we subtract PI/2 because 0 radians is at the 3 o'clock position,
    // and we want 0 progress to be at the 12 o'clock position.
    // The progress arc starts at the top of the circle (12 o'clock position) and proceeds clockwise.
    return (2 * math.pi * progress) - (math.pi / 2);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // weightController.dispose();
    // heightController.dispose();
    // ageController.dispose();
    super.dispose();
  }

  DateTime _lastPressedAt = DateTime.now();

  @override
  Widget build(BuildContext context) {
    HYSizeFit.initialize(context);
    var isFamale = useState(true);
    var weightState = useState(weight);
    var heightState = useState(height);
    var ageState = useState(age);
    var resultState = useState(result);
    var totalProgressState = useState(totalProgress);
    var tipDescTitle = useState("Severe underweight");
    var tipDescsubTitle = useState("Too thin, eat more to gain weight");

    var weightNode = useFocusNode();
    var heightNode = FocusNode();
    var ageNode = FocusNode();

    final weightController = useTextEditingController(text: "$weight");
    final heightController = useTextEditingController(text: "$height");
    final ageController = useTextEditingController(text: "$age");

    useEffect(() {
      // totalProgressState.value = totalProgress;
      // resultState.value = result;

      if (result <= 15.99) {
        tipDescTitle.value = "Severe underweight";
        tipDescsubTitle.value = "Too thin, eat more to gain weight";
      } else if (result <= 16.99) {
        tipDescTitle.value = "Moderate underweight";
        tipDescsubTitle.value = "Too thin, eat more to gain weight";
      } else if (result <= 18.4) {
        tipDescTitle.value = "Mild underweight";
        tipDescsubTitle.value = "Too thin, eat more to gain weight";
      } else if (result <= 24.99) {
        tipDescTitle.value = "Healthy weight";
        tipDescsubTitle.value =
            "you are now at a healthy weight, please continue to maintain a healthy weight.";
      } else if (result <= 29.99) {
        tipDescTitle.value = "Overweight (Pre-Obese)";
        tipDescsubTitle.value =
            "you are now at a healthy weight, please continue to maintain a healthy weight.";
      } else if (result <= 34.99) {
        tipDescTitle.value = "Obese (Class I)";
        tipDescsubTitle.value =
            "What are you waiting for? It's time to get moving for your goal weight!";
      } else if (result <= 39.99) {
        tipDescTitle.value = "Obese (Class II)";
        tipDescsubTitle.value = "It's time to lose weight to keep fit";
      } else
      // if (result <= 46.7)
      {
        tipDescTitle.value = "Obese (Class III)";
        tipDescsubTitle.value = "It's time to lose weight to keep fit";
      }
    });

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
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: HYSizeFit.setRpx(32)),
              child: Column(
                // alignment: AlignmentDirectional.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, routeNameSeatPlanPage);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: HYSizeFit.setRpx(100)),
                          width: HYSizeFit.setRpx(48),
                          height: HYSizeFit.setRpx(48),
                          child: SvgPicture.string(
                            SVGUtil.infoAlarm,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                            // color: string2Color("#b2b2b2"),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: HYSizeFit.setRpx(100)),
                        width: HYSizeFit.setRpx(400),
                        height: HYSizeFit.setRpx(33),
                        child: SvgPicture.string(
                          SVGUtil.titleResult,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                          // color: string2Color("#b2b2b2"),
                        ),
                      ),
                      SizedBox(
                        width: HYSizeFit.setRpx(48),
                      )
                    ],
                  ),
                  SizedBox(
                    height: HYSizeFit.setRpx(60),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      editWidget(
                          'Weight', '${weightState.value}', weightController,
                          unit: "kg", node: weightNode, autoFocus: () {
                        // print("autoFocus");
                        weightController.clear();
                        Future.delayed(const Duration(milliseconds: 0), () {
                          weightState.value = 0;
                          Future.delayed(const Duration(milliseconds: 300), () {
                            FocusScope.of(context).requestFocus(weightNode);
                          });
                        });
                      }, callback: (value) {
                        print("value:$value");
                        weightState.value = double.tryParse(value) ?? 0;
                      }),
                      editWidget(
                          'Height', '${heightState.value}', heightController,
                          unit: "cm", node: heightNode, autoFocus: () {
                        // print("autoFocus");
                        heightController.clear();
                        Future.delayed(const Duration(milliseconds: 0), () {
                          heightState.value = 0;
                          Future.delayed(const Duration(milliseconds: 300), () {
                            FocusScope.of(context).requestFocus(heightNode);
                          });
                        });
                      }, callback: (value) {
                        print("value:$value");
                        heightState.value = double.tryParse(value) ?? 0;
                      })
                    ],
                  ),
                  SizedBox(
                    height: HYSizeFit.setRpx(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: editWidget(
                            'Age', '${ageState.value}', ageController,
                            unit: "", node: ageNode, autoFocus: () {
                          print("autoFocus");
                          ageController.clear();
                          // 在需要获取焦点的时候调用
                          Future.delayed(const Duration(milliseconds: 0), () {
                            ageState.value = 0;
                            Future.delayed(const Duration(milliseconds: 300),
                                () {
                              FocusScope.of(context).requestFocus(ageNode);
                            });
                          });
                        }, callback: (value) {
                          print("value:$value");
                          ageState.value = double.tryParse(value) ?? 0;
                        }),
                        margin: EdgeInsets.only(left: HYSizeFit.setRpx(42)),
                      ),
                      GestureDetector(
                        onTap: () {
                          isFamale.value = !isFamale.value;
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              right: HYSizeFit.setRpx(52),
                              bottom: HYSizeFit.setRpx(30)),
                          width: HYSizeFit.setRpx(199),
                          height: HYSizeFit.setRpx(70),
                          child: SvgPicture.string(
                            isFamale.value
                                ? SVGUtil.calculatorFamale
                                : SVGUtil.calculatorMale,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                            // color: string2Color("#b2b2b2"),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: HYSizeFit.setRpx(60),
                  ),

                  ///TODO:结果条
                  RainBowWidget(
                    progress: totalProgressState.value,
                  ),
                  SizedBox(
                    height: HYSizeFit.setRpx(58),
                  ),

                  ///TODO：
                  Text(
                    'Your bMI is……',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: HYSizeFit.setRpx(30),
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    height: HYSizeFit.setRpx(10),
                  ),
                  Text(
                    '${resultState.value}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: HYSizeFit.setRpx(90),
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    height: HYSizeFit.setRpx(10),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: HYSizeFit.setRpx(30),
                        vertical: HYSizeFit.setRpx(10)),
                    decoration: ShapeDecoration(
                      color: Color(0xFF7370FE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          tipDescTitle.value,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: HYSizeFit.setRpx(30),
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: HYSizeFit.setRpx(29),
                  ),
                  Text(
                    tipDescsubTitle.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: HYSizeFit.setRpx(30),
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    height: HYSizeFit.setRpx(105),
                  ),
                  GestureDetector(
                    onTap: () {
                      ToastUtil.hideKeyboard(context);
                      // ToastUtil.showEasyLoading();

                      if (weightState.value == 0) {
                        ToastUtil.show("Please input weight");
                        return;
                      }
                      if (heightState.value == 0 || heightState.value == 1) {
                        ToastUtil.show("Please input height");
                        return;
                      }
                      if (ageState.value == 0 || ageState.value == 1) {
                        ToastUtil.show("Please input age");
                        return;
                      }
                      setResult(
                          weightValue: weightState.value,
                          heightValue: heightState.value,
                          ageValue: ageState.value,
                          callback: (result, totalProgress) {
                            totalProgressState.value = totalProgress;
                            resultState.value = result;

                            if (result <= 15.99) {
                              tipDescTitle.value = "Severe underweight";
                              tipDescsubTitle.value =
                                  "Too thin, eat more to gain weight";
                            } else if (result <= 16.99) {
                              tipDescTitle.value = "Moderate underweight";
                              tipDescsubTitle.value =
                                  "Too thin, eat more to gain weight";
                            } else if (result <= 18.4) {
                              tipDescTitle.value = "Mild underweight";
                              tipDescsubTitle.value =
                                  "Too thin, eat more to gain weight";
                            } else if (result <= 24.99) {
                              tipDescTitle.value = "Healthy weight";
                              tipDescsubTitle.value =
                                  "you are now at a healthy weight, please continue to maintain a healthy weight.";
                            } else if (result <= 29.99) {
                              tipDescTitle.value = "Overweight (Pre-Obese)";
                              tipDescsubTitle.value =
                                  "you are now at a healthy weight, please continue to maintain a healthy weight.";
                            } else if (result <= 34.99) {
                              tipDescTitle.value = "Obese (Class I)";
                              tipDescsubTitle.value =
                                  "What are you waiting for? It's time to get moving for your goal weight!";
                            } else if (result <= 39.99) {
                              tipDescTitle.value = "Obese (Class II)";
                              tipDescsubTitle.value =
                                  "It's time to lose weight to keep fit";
                            } else
                            // if (result <= 46.7)
                            {
                              tipDescTitle.value = "Obese (Class III)";
                              tipDescsubTitle.value =
                                  "It's time to lose weight to keep fit";
                            }
                          });
                    },
                    child: Container(
                      width: HYSizeFit.setRpx(402),
                      height: HYSizeFit.setRpx(98),
                      decoration: ShapeDecoration(
                        color: Color(0xFF3A5FF5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                        ),
                      ),
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        'Complete',
                        style: TextStyle(
                          color: Color(0xFFFFF8F8),
                          fontSize: HYSizeFit.setRpx(30),
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
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

