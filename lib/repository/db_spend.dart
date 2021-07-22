import 'package:exam_dot_mobile/model/category.dart';
import 'package:hive/hive.dart';

part 'db_spend.g.dart';

@HiveType(typeId: 0)
class DBSpend extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  DateTime time;

  @HiveField(2)
  Category category;

  @HiveField(3)
  int nominal= 0;

}
