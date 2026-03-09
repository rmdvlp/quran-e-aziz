import 'package:flutter/material.dart';

import 'global_class.dart';

class ScfWidget extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  const ScfWidget({super.key, this.appBar, this.body, this.drawer, this.floatingActionButton, this.floatingActionButtonLocation, this.bottomNavigationBar});

  @override
  State<ScfWidget> createState() => _ScfWidgetState();
}

class _ScfWidgetState extends State<ScfWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalClass.scaffoldKey,
      appBar: widget.appBar,
      body: widget.body,
      drawer: widget.drawer,
      floatingActionButton: widget.floatingActionButton,
        floatingActionButtonLocation:widget.floatingActionButtonLocation,
        bottomNavigationBar:widget.bottomNavigationBar

    );
  }
}
