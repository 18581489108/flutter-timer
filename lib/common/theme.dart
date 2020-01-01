import 'package:flutter/material.dart';

final appTheme = ThemeData(
  primarySwatch: Colors.yellow,
  textTheme: TextTheme(
    display4: TextStyle(
      fontFamily: 'Corben',
      fontWeight: FontWeight.w700,
      fontSize: 24,
      color: Colors.black,
    ),
  ),
);

// 滚动条的说明
final scrollerDescTextStyle = TextStyle(
    color: Colors.black54,
    fontSize: 12,
    //height: 1.2,
    fontFamily: "微软雅黑");

/// 组数的倒计时颜色
final Color totalTimesCountDownColor = Colors.black54;
/// 单次时间的倒计时颜色
final Color singleTimesCountDownColor = Colors.blue;
/// 间隔的倒计时颜色
final Color intervalTimesCountDownColor = Colors.blueGrey;
