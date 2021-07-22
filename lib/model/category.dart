import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
class Category extends HiveObject{

  @HiveField(0)
  final String logo;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int color;

  Category({this.logo, this.name,this.color});
}