import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Color color;
  final bool isBottomReSize;
  final bool fullScreen;
  final Color? statusColor;
  final Widget? appDrawer;
  final Key? globalKey;
  final Widget? endDrawer;
  final Widget? floatingActionButton;
  final Widget? bottomWidget;
  const CustomScaffold(
      {Key? key,
      this.appBar,
      this.body,
      this.color = Colors.white,
      this.isBottomReSize = true,
      this.fullScreen = false,
      this.appDrawer,
      this.endDrawer,
      this.globalKey,
      this.floatingActionButton,
      this.statusColor,
      this.bottomWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: statusColor ?? Colors.white,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness:
              statusColor == null ? Brightness.dark : Brightness.light,
        ),
        child: Scaffold(
            resizeToAvoidBottomInset: isBottomReSize,
            backgroundColor: color,
            key: globalKey,
            appBar: appBar,
            floatingActionButton: floatingActionButton,
            drawerEdgeDragWidth: 0,
            drawer: appDrawer,
            endDrawer: endDrawer,
            bottomNavigationBar: bottomWidget,
            body: _buildBody(context)));
  }

  Widget _buildBody(BuildContext context) {
    if (fullScreen) {
      return _buildLoader(context);
    } else {
      return SafeArea(
        child: _buildLoader(context),
      );
    }
  }

  Widget _buildLoader(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: body,
    );
  }
}
