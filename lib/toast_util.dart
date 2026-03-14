import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class ToastUtil {
  static show(String msg, {toastLength = Toast.LENGTH_SHORT}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  //TODO:隐藏软件盘
  static bool hideKeyboard(context) {
    // if (KeyboardVisibilityController().isVisible) {
    FocusManager.instance.primaryFocus?.unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return true;
    // } else {
    //   return false;
    // }
  }

  static void showEasyLoading({delay = 1000}) {
    EasyLoading.show(
      status: 'Calculating...',
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
      indicator: CircularProgressIndicator(
        backgroundColor: Colors.white,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );
    Future.delayed(Duration(milliseconds: delay), () {
      EasyLoading.dismiss();
    });
  }
}
