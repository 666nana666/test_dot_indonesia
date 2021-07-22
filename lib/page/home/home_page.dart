import 'package:exam_dot_mobile/base/base_stateful.dart';
import 'package:exam_dot_mobile/provider/home/spend_state.dart';
import 'package:exam_dot_mobile/utils/app_colors.dart';
import 'package:exam_dot_mobile/utils/navigation.dart';
import 'package:exam_dot_mobile/utils/v_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseStateful<HomePage, SpendState> {
  BorderRadiusGeometry borderRadius = BorderRadius.circular(12);

  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
  List<BoxShadow> shadow = [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 3,
      blurRadius: 5,
      offset: Offset(0, 3), // changes position of shadow
    ),
  ];

  @override
  Widget body(Widget child) {
    // TODO: implement body
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: AppColors.blue,
        onPressed: () {
          Navigation().addSpending(state, () {
            state.init(context);
          });
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VText(
                    "Halo, User!",
                    color: AppColors.grey1,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  VText(
                    "Jangan lupa catat keuanganmu setiap hari!",
                    color: AppColors.grey3,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: borderRadius,
                        ),
                        padding: EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            VText(
                              "Pengeluaranmu\nhari ini",
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            VText(
                              '${formatCurrency.format(state.nominalToday)}',
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            )
                          ],
                        ),
                      )),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.teal,
                          borderRadius: borderRadius,
                        ),
                        padding: EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            VText(
                              "Pengeluaranmu\nbulan ini",
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            VText(
                              '${formatCurrency.format(state.nominalTomorrow)}',
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            )
                          ],
                        ),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  title("Pengeluaran berdasarkan kategori"),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Container(
              height: 140,
              width: double.infinity,
              child: ListView.builder(
                padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                itemBuilder: (c, i) => Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      borderRadius: borderRadius, color: Colors.white, boxShadow: shadow),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconCircleSVG(
                        color: state.listSpendCategory[i].color,
                        svgName: state.listSpendCategory[i].logo,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      VText(
                        state.listSpendCategory[i].name,
                        color: AppColors.grey3,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      VText('${formatCurrency.format(state.listSpendCategory[i].nominal)}')
                    ],
                  ),
                ),
                itemCount: state.listSpendCategory.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 28,
                  ),
                  title("Hari ini"),
                  SizedBox(
                    height: 28,
                  ),
                  ListView.builder(
                    itemBuilder: (c, i) => Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 23),
                      decoration: BoxDecoration(
                          borderRadius: borderRadius, boxShadow: shadow, color: Colors.white),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            state.listSpendToday[i].category.logo,
                            color: Color(state.listSpendToday[i].category.color),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: VText(
                              state.listSpendToday[i].name,
                              color: AppColors.grey1,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          VText(
                            '${formatCurrency.format(state.listSpendToday[i].nominal)}',
                            color: AppColors.grey1,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                    itemCount: state.listSpendToday.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                  title("Kemarin"),
                  SizedBox(
                    height: 8,
                  ),
                  ListView.builder(
                    itemBuilder: (c, i) => Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 23),
                      decoration: BoxDecoration(
                          borderRadius: borderRadius, boxShadow: shadow, color: Colors.white),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            state.listSpendTomorrow[i].category.logo,
                            color: Color(state.listSpendTomorrow[i].category.color),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: VText(
                              state.listSpendTomorrow[i].name,
                              color: AppColors.grey1,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          VText(
                            '${formatCurrency.format(state.listSpendTomorrow[i].nominal)}',
                            color: AppColors.grey1,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                    itemCount: state.listSpendTomorrow.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget title(String title) {
    return VText(
      title,
      color: AppColors.grey1,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    );
  }

  @override
  void onStart() {
    state = SpendState();
    // TODO: implement onStart
  }
}
