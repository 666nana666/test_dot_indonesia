import 'package:exam_dot_mobile/model/category.dart';
import 'package:exam_dot_mobile/page/home/home_page.dart';
import 'package:exam_dot_mobile/repository/db_spend.dart';
import 'package:exam_dot_mobile/repository/hive.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DBSpendAdapter());
  Hive.registerAdapter(CategoryAdapter());
  await Hive.openBox<DBSpend>('spend');
  runApp(MyApp());
}

@immutable
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        dividerColor: Colors.white,
        fontFamily: "rubik",
        hoverColor: Colors.black,
        inputDecorationTheme:
            InputDecorationTheme(border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
      theme: ThemeData(
        dividerColor: Colors.black,
        hoverColor: Colors.white,
        fontFamily: "rubik",
        inputDecorationTheme:
            InputDecorationTheme(border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
      themeMode: ThemeMode.system,
      home: HomePage(),

    );
  }
}
