// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/common/theme.dart';
import 'package:timer/models/timer.dart';
import 'package:timer/screens/home.dart';

void main() => runApp(TimerApp());

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModel>(
      create: (context) => TimerModel(),
      child: MaterialApp(
        title: '计时',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          //'/saved': (context) =>
        },
      ),
    );
  }
}

