import 'package:exam_dot_mobile/page/spend/add_spend_page.dart';
import 'package:exam_dot_mobile/provider/home/spend_state.dart';
import 'package:get/get.dart';

class Navigation{
  void addSpending(SpendState state){
    Get.to(AddSpendPage(state: state,));
  }
}