import 'dart:io';

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

  Future<void> addSpend(String name, Category category, DateTime time, String nominal) async {
    try {
      var dbSpend = DBSpend()
        ..name = name
        ..nominal = nominal
        ..category = category
        ..time = time;
      final box = Hive.box<DBSpend>('spend');

      box.add(dbSpend);
    } catch (x) {
      VUtils().setLog(x);
    }
  }
}
