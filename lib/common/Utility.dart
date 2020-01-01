import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:timer/models/globalData.dart';
import 'package:timer/models/timerSetting.dart';

class Utility {
  static TimerSetting getTimerSetting(
      BuildContext context, InitTimerSettingModel initTimerSetting) {
    AllTimerSettingsModel allTimerSettings = Provider.of<AllTimerSettingsModel>(context);
    TimerSettingItem item = allTimerSettings
        .getTimerSettingItemById(initTimerSetting.timerSettingItemId);
    return item == null ? null : item.timerSetting;
  }
}
