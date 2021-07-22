import 'package:exam_dot_mobile/base/base_stateful.dart';
import 'package:exam_dot_mobile/provider/home/spend_state.dart';
import 'package:exam_dot_mobile/utils/app_colors.dart';
import 'package:exam_dot_mobile/utils/date_format.dart';
import 'package:exam_dot_mobile/utils/v_utils.dart';
import 'package:exam_dot_mobile/utils/v_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddSpendPage extends StatefulWidget {
  final SpendState state;

  const AddSpendPage({Key key, this.state}) : super(key: key);

  @override
  _AddSpendPageState createState() => _AddSpendPageState();
}

class _AddSpendPageState extends BaseStateful<AddSpendPage, SpendState> {
  TextEditingController name;

  DateTime dateTime;
  TextEditingController date;
  TextEditingController nominal =MaskedTextController(mask: 'Rp. 000.000.000', text: 'Rp. 0');

  @override
  Widget body(Widget child) {
    return Scaffold(
      appBar: AppBar(
        title: VText(
          "Tambah Pengeluaran Baru",
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.grey1,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              textFormField(hint: "Nama Pengeluaran", controller: name, enable: true),
              InkWell(
                onTap: () async {
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                    ),
                    builder: (context) {
                      return Container(
                        height: 400,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                            color: Colors.white),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: VText(
                                      "Pilih Kategori",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: AppColors.grey3,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      })
                                ],
                              ),
                            ),
                            Container(
                              height: 300,
                              width: width,
                              child: GridView.builder(
                                  itemCount: state.category.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 1.6,
                                      crossAxisSpacing: 12),
                                  itemBuilder: (BuildContext context, int index) => InkWell(
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Color(state.category[index].color),
                                                borderRadius: BorderRadius.circular(72),
                                              ),
                                              padding: EdgeInsets.all(6),
                                              child: SvgPicture.asset(state.category[index].logo),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            VText(
                                              state.category[index].name,
                                              color: AppColors.grey3,
                                            )
                                          ],
                                        ),
                                        onTap: () {
                                          state.onSelectCategory(index, context);
                                        },
                                      )),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: textFormField(
                    leadingVSG: state.selecetedCatagory.logo,
                    color: Color(state.selecetedCatagory.color),
                    rightWidget: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(72), color: AppColors.grey5),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.grey3,
                        size: 10,
                      ),
                    ),
                    hint: "Pilih Katagori",
                    controller: state.textCategory),
              ),
              InkWell(
                onTap: () async {
                  DateTime dateResult = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 15),
                    lastDate: DateTime(DateTime.now().year + 10),
                    builder: (BuildContext context, Widget child) {
                      return Theme(
                        data: ThemeData(primarySwatch: Colors.blue),
                        child: child,
                      );
                    },
                  );

                  if (dateResult != null) {
                    dateTime  = dateResult;
                    date.text =
                        VUtils.dateConvert(dateResult.toString(), DateFormat.FORMAT_DD_MMM_YYYY);
                    setState(() {});
                  }
                },
                child: textFormField(
                    hint: "Tanggal Pengeluaran",
                    controller: date,
                    rightWidget: Icon(
                      Icons.date_range,
                      color: AppColors.grey4,
                    )),
              ),
              textFormField(hint: "Nominal",enable: true, controller: nominal),
              PrimaryButton(
                text: "Simpan",
                onTap: (){

                  state.addSpend(name.text, state.selecetedCatagory, dateTime, nominal.text, context);
                },
                enabled: simpan,

              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textFormField(
      {String leadingVSG,
      var controller,
      @required String hint,
      Widget rightWidget,
      Color color,
      bool enable = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: boxDecoration(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            if (leadingVSG != null)
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: SvgPicture.asset(
                  leadingVSG,
                  color: color,
                ),
              ),
            Expanded(
              child: TextField(
                controller: controller,

                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: hint,
                    contentPadding: EdgeInsets.zero,
                    hintStyle: TextStyle(color: AppColors.grey3),
                    enabled: enable),
              ),
            ),
            if (rightWidget != null) rightWidget
          ],
        ),
      ),
    );
  }

  @override
  void onStart() {
    onCreate = false;
    state = widget.state;
    name = TextEditingController();
    date = TextEditingController();

    nominal.addListener(() {
      if(nominal.text.length >= 5){
        simpan = true;
      }else{
        simpan = false;
      }
      setState(() {

      });
    });

    // TODO: implement onStart
  }

  bool simpan = false;
  Decoration boxDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border, width: 1));
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final Widget child;
  final VoidCallback onTap;
  final double width;
  final bool enabled;
  final bool isOutline;

  const PrimaryButton({
    Key key,
    this.text,
    this.child,
    this.onTap,
    this.width,
    this.enabled = true,
    this.isOutline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: width ?? double.infinity,
      buttonColor: isOutline ? Colors.transparent : Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(
          color: isOutline ? AppColors.primaryColor : Colors.transparent,
          width: isOutline ? 2 : 0,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 14),
      disabledColor: Theme.of(context).dividerColor.withOpacity(0.2),
      child: RaisedButton(
        elevation: 0,
        highlightElevation: isOutline ? 0 : 2,
        child: child ??
            VText(
              "$text",
              color: isOutline ? AppColors.primaryColor : Colors.white,
              fontSize: 18,
            ),
        onPressed: enabled ? onTap : null,
      ),
    );
  }
}
