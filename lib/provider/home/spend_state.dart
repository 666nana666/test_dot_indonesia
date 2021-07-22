import 'package:exam_dot_mobile/base/base_provider.dart';
import 'package:exam_dot_mobile/model/based_on_category.dart';
import 'package:exam_dot_mobile/model/category.dart';
import 'package:exam_dot_mobile/repository/db_spend.dart';
import 'package:exam_dot_mobile/repository/repo_spend.dart';
import 'package:exam_dot_mobile/utils/app_colors.dart';
import 'package:exam_dot_mobile/utils/svg.dart';
import 'package:flutter/material.dart';

class SpendState extends BaseProvider {
  List<Category> category = [];
  int nominalToday = 0;
  int nominalTomorrow = 0;

  List<BasedOnCategory> listSpendCategory = [];
  List<DBSpend> listSpendToday = [];
  List<DBSpend> listSpendTomorrow = [];
  RepoSpend repoSpend;
  Category selecetedCatagory = Category(name: "", logo: "");

  @override
  void init(BuildContext context) {
    // TODO: implement init

    repoSpend = RepoSpend.instance;
    category = [];

     nominalToday = 0;
     nominalTomorrow = 0;
    category.add(Category(logo: VSvg.pizza, name: "Makanan", color: AppInt.yellow));
    category.add(Category(logo: VSvg.internet, name: "Internet", color: AppInt.blue3));
    category.add(Category(logo: VSvg.book, name: "Edukasi", color: AppInt.orange));
    category.add(Category(logo: VSvg.gift, name: "Hadiah", color: AppInt.red));
    category.add(Category(logo: VSvg.car, name: "Transport", color: AppInt.purple1));
    category.add(Category(logo: VSvg.shopping, name: "Belanja", color: AppInt.green2));
    category.add(Category(logo: VSvg.home, name: "Alat Rumah", color: AppInt.purple2));
    category.add(Category(logo: VSvg.basketball, name: "Olahraga", color: AppInt.blue2));
    category.add(Category(logo: VSvg.clapper, name: "Hiburan", color: AppInt.blue));

    listSpendCategory = [];
    listSpendToday = [];
    listSpendTomorrow = [];
    getToday();
    getTomorrow();
    getCategory();
  }

  @override
  void onBackPressed(BuildContext context) {

     nominalToday = 0;
     nominalTomorrow = 0;

    getToday();
    getTomorrow();
    getCategory();
  }

  @override
  void onDestroy(BuildContext context) {
    // TODO: implement onDestroy
  }

  void onSelectCategory(int i, BuildContext context) {
    selecetedCatagory = category[i];
    textCategory.text = selecetedCatagory.name;
    Navigator.pop(context);
    notifyListeners();
  }

  TextEditingController textCategory;

  @override
  void onResume(BuildContext context) {
    selecetedCatagory = category.first;
    textCategory = TextEditingController();
    textCategory.text = selecetedCatagory.name;
    notifyListeners();
    // TODO: implement onResume
  }

  void addSpend(
    String name,
    Category category,
    DateTime time,
    String nominal,
    BuildContext context,
  ) async {
    try {
      repoSpend.addSpend(name, category, time, nominal);
      Navigator.pop(context);
    } catch (ex) {
      setLog("$ex error");
    }
  }

  void getCategory() async {
    try {

      final response = await repoSpend.getCategory();

      listSpendCategory = [];
      if(response.isNotEmpty)
      setLog(response.first,d: "length");
      listSpendCategory.addAll(response);
    } catch (ex) {}

    notifyListeners();
  }

  void getToday() async {
    try {
      listSpendToday = [];
      listSpendToday.addAll(await repoSpend.getToday());
      listSpendToday.forEach((element) {
        nominalToday += element.nominal;
      });
    } catch (ex) {}
    notifyListeners();
  }

  void getTomorrow() async {
    try {
      listSpendTomorrow = [];
      listSpendTomorrow.addAll(await repoSpend.getTomorrow());
      listSpendToday.forEach((element) {
        nominalTomorrow += element.nominal;
      });
      nominalTomorrow += nominalToday;
    } catch (ex) {}
    notifyListeners();
  }
}
