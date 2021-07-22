import 'package:exam_dot_mobile/base/base_stateful.dart';
import 'package:exam_dot_mobile/provider/home/spend_state.dart';
import 'package:exam_dot_mobile/utils/app_colors.dart';
import 'package:exam_dot_mobile/utils/navigation.dart';
import 'package:exam_dot_mobile/utils/v_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseStateful<HomePage, SpendState> {
  BorderRadiusGeometry borderRadius = BorderRadius.circular(12);

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
          Navigation().addSpending(state);
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
                  SizedBox(
                    height: 35,
                  ),
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
                              "Rp. 30.000",
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
                              "Rp. 300.000",
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
              height: 120,
              width: double.infinity,
              child: ListView.builder(
                padding: EdgeInsets.only(left: 20),
                itemBuilder: (c, i) => Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      borderRadius: borderRadius, color: Colors.white, boxShadow: shadow),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      VText(
                        "Makanan",
                        color: AppColors.grey3,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      VText("Rp. 70.000")
                    ],
                  ),
                ),
                itemCount: 3,
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
                          Expanded(
                            child: VText(
                              "Ayam Geprek",
                              color: AppColors.grey1,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    itemCount: 2,
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
                          Expanded(
                            child: VText(
                              "Ayam Geprek",
                              color: AppColors.grey1,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    itemCount: 1,
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
