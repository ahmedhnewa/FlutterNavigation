import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveApp {
  static StatefulWidget createApp(
    String title,
    ThemeData? theme,
    ThemeData? darkTheme,
    ThemeMode themeMode,
    Map<String, WidgetBuilder> routes,
  ) {
    return Platform.isIOS
        ? CupertinoApp(
            debugShowCheckedModeBanner: false,
            title: title,
            routes: routes,
            theme: CupertinoThemeData(),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            title: title,
            theme: theme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            routes: routes,
          );
  }
}
