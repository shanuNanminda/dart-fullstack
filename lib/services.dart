import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ftoast/ftoast.dart' as ft;

class Services {
  static toast({required String message,required BuildContext context}) {
    if (Platform.isAndroid) {
      Fluttertoast.showToast(msg: message);
    } else if (Platform.isWindows) {
      ft.FToast.toast(context,msg: message);
    }
  }
}
