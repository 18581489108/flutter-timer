import 'package:flutter/cupertino.dart';
import 'package:timer/models/timerSetting.dart';

class TimerModel extends ChangeNotifier {
  /// 当前的计时器的配置
  final TimerSetting _curTimerSetting = TimerSetting();

  void modifyTimerSetting(TimerSetting newSetting) {
    _curTimerSetting.singleTime = newSetting.singleTime;
    _curTimerSetting.singleInterval = newSetting.singleInterval;
    _curTimerSetting.totalTimes = newSetting.totalTimes;

    notifyListeners();
  }
}