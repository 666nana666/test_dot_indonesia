import 'package:exam_dot_mobile/base/base_provider.dart';
import 'package:exam_dot_mobile/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class BaseStateful<S extends StatefulWidget, P extends BaseProvider>
    extends State<S> {
  P state;
  bool onCreate = true;
  double height;
  double width;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    onStart();
    if (onCreate) {
      state.init(context);

      state.setLog("OnStart");
    } else {
      state.onResume(context);
      state.setLog("OnResume");
    }
    state.bodyMap.clear();
  }

  @override
  void dispose() {
    state.onDestroy(context);
    super.dispose();
  }

  void onStart();

  Widget refreshIndicator({@required Widget child}) {
    return RefreshIndicator(
      child: child,
      onRefresh:() async {
       state.onRefresh(context);
    },
      key: state.refreshIndicatorKey,
    );
  }

  BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    setStatusBarColorToPrimary();

    return mainWidget(onCreate: onCreate);
  }

  Widget body(Widget child);

  Widget mainWidget({bool onCreate = true}) {
    return onCreate
        ? ChangeNotifierProvider(
            create: (_) => state,
            child: Consumer(
              builder: (BuildContext context, P state, Widget child) {
                this.state = state;

                return WillPopScope(
                  onWillPop: () async {
                    state.onBackPressed(
                        context); // Action to perform on back pressed

                    return Future.value(true);
                  },
                  child: SafeArea(child: body(child)),
                );
              },
            ),
          )
        : ChangeNotifierProvider.value(
            value: state,
            child: Consumer(
              builder: (BuildContext context, P state, Widget child) {
                this.state = state;
                return WillPopScope(
                  onWillPop: () async {
                    state.onBackPressed(context); // Act
                    return Future.value(true);
                  },
                  child: body(child),
                );
              },
            ),
          );
  }
}
