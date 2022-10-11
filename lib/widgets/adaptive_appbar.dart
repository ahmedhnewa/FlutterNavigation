import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveAppBar {
  static PreferredSizeWidget create(String title) {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            brightness: Brightness.dark,
            backgroundColor: ThemeData.dark().bottomAppBarColor,
            middle: Text(title),
          )
        : AppBar(
            title: Text(title),
          ) as PreferredSizeWidget;
  }
}
