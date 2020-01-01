// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/common/theme.dart';
import 'package:timer/screens/countdownPage.dart';
import 'package:timer/screens/home.dart';
import 'package:timer/models/globalData.dart';

void main() => runApp(TimerApp());

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => initGlobalData()),
        ChangeNotifierProvider<AllTimerSettingsModel>(
          create: (context) => AllTimerSettingsModel(),
        ),
        ChangeNotifierProvider<InitTimerSettingModel>(
          create: (context) => InitTimerSettingModel(),
        ),
        ChangeNotifierProvider<CurrentTimerSettingModel>(
          create: (context) => CurrentTimerSettingModel(),
        ),
      ],
      child: MaterialApp(
        title: '计时',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          RouteConsts.HOME_PAGE: (context) => HomePage(),
          RouteConsts.COUNT_DOWN_PAGE: (context) => CountdownPage(),
          //'/saved': (context) =>
          
        },
      ),
    );
  }
}
