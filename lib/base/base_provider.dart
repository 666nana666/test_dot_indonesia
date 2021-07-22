import 'package:exam_dot_mobile/utils/v_utils.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseProvider extends ChangeNotifier {
  var refreshIndicatorKey;
  Widget errorDisplay = SizedBox();
  Map<String, dynamic> bodyMap = {};
  Map<String, dynamic> params = {};
  String errorMessage = "";
  ValueNotifier<bool> isValid = ValueNotifier<bool>(false);
  bool visibleError = false;

  setLog(dynamic message, {String d = "Log.d"}) {
    VUtils().setLog(message, d: d);
  }

  void exitApp() {
    VUtils().exitApp();
  }

  void init(BuildContext context);

  void onResume(BuildContext context);

  void onRefresh(BuildContext context) {
    setLog("on refresh data");
  }

  void onDestroy(BuildContext context);

  void onBackPressed(BuildContext context);
}
