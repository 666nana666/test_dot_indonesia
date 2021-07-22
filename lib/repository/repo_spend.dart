import 'dart:io';

import 'package:exam_dot_mobile/model/based_on_category.dart';
import 'package:exam_dot_mobile/model/category.dart';
import 'package:exam_dot_mobile/repository/db_spend.dart';
import 'package:exam_dot_mobile/utils/v_utils.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class RepoSpend {
  RepoSpend._privateConstructor();

  static final RepoSpend _instance = RepoSpend._privateConstructor();

  static RepoSpend get instance {
    return _instance;
  }

  static Future<String> cachePath() async {
    if (Platform.isIOS) {
      var dir = await getApplicationDocumentsDirectory();
      return dir.path;
    } else {
      var dir = await getTemporaryDirectory();
      return dir.path;
    }
  }

  final box = Hive.box<DBSpend>('spend');

  Future<void> addSpend(String name, Category category, DateTime time, String nominal) async {
    var dbSpend = DBSpend()
      ..name = name
      ..nominal = 100000
      ..category = category
      ..time = time;

    box.add(dbSpend);
  }

  Future<List<DBSpend>> getToday() async {
    List<DBSpend> dbSpend = [];
    box.values.forEach((element) {
      if (element.time.day == DateTime.now().day) {
        dbSpend.add(element);
      }
    });

    return await dbSpend;
  }

  Future<List<DBSpend>> getTomorrow() async {
    List<DBSpend> dbSpend = [];
    box.values.forEach((element) {
      if (element.time.day == DateTime.now().day - 1) {
        dbSpend.add(element);
      }
    });

    return await dbSpend;
  }

  Future<List<BasedOnCategory>> getCategory() async {
    List<BasedOnCategory> dbSpend = [];
    await box.values.forEach((element) async {

      if (dbSpend.isEmpty) {
         dbSpend.add(BasedOnCategory(element.nominal,
            logo: element.category.logo,
            name: element.category.name,
            color: element.category.color));
         VUtils().setLog(dbSpend.first.name, d: "Category");

         VUtils().setLog("isEmpty", d: "Category");
      } else {

        VUtils().setLog("isNotEmpty", d: "Category");
         for (var value in dbSpend) {
          VUtils().setLog("${element.category.name}${value.name}", d: "tambah");
          if (element.category.name == value.name) {
            value.nominal += element.nominal;
          } else {
             dbSpend.add(BasedOnCategory(element.nominal,
                logo: element.category.logo,
                name: element.category.name,
                color: element.category.color));
          }
        }
      }
    });

    return dbSpend;
  }
}
