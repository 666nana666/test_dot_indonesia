import 'package:exam_dot_mobile/page/spend/add_spend_page.dart';
import 'package:exam_dot_mobile/provider/home/spend_state.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class Navigation{
  void addSpending(SpendState state,Callback function){
    Get.to(AddSpendPage(state: state,)).then((value) {
      function();
    }).then((value) {function();});
  }
}