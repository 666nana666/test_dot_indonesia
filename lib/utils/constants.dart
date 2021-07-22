import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

setStatusBarColorToPrimary() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark));
}