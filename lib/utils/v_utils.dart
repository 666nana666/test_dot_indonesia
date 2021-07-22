
import 'dart:io';

import 'package:intl/intl.dart';
import 'date_format.dart' as DateCustomFormat;
import 'package:flutter/services.dart';

class VUtils{

  static String dateConvertCustom(String input, String formatInput, String formatOutput){
    try{
      var date = DateFormat(formatInput).parse(input);
      return  DateFormat(formatOutput).format(date);
    }catch(e){
      return "";
    }
  }

  static String dateConvert (String input, String formatOutput){
    try {
      var date = DateTime.parse(input);
      return DateFormat(formatOutput).format(date);
    } catch (e) {
      return "";
    }
  }
  void setLog(dynamic message, {String d = "Log.d"}) {
    print("$d ==> $message");
  }
  void exitApp(){

    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }
  static String handlerErrorMessage(int statusCode, dynamic errorBody){
    String msg = "";
    if (statusCode == 404){
      try {
        msg = errorBody["message"];
      } catch (ex) {
        msg = "Data not found";
      }
    }
    return msg;
  }

}