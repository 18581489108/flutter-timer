import 'package:flutter/foundation.dart';
import 'package:timer/models/timerSetting.dart';

//GlobalData globalData = initGlobalData();

GlobalData initGlobalData() {
  return GlobalData();
}

/// 全局数据
class GlobalData {
  /// 全局的timerSettingid
  static int _timerSettingItemId = 0;
  
  static int spawnNextTimerSettingItemId() {
    _timerSettingItemId++;
    return _timerSettingItemId;
  }
}

/// 所有配置信息
class AllTimerSettings extends ChangeNotifier {
  final List<TimerSettingItem> _settingList = List<TimerSettingItem>();
  
  /// 添加多个配置
  void addSettingItems(List<TimerSettingItem> settings) {
    bool addSuccessful = false;
    for (int i = 0; i < settings.length; i++) {
      if (_onlyAddSettingItem(settings[i])) {
        addSuccessful = true;
      }
    }

    if (addSuccessful) {
      notifyListeners();
    }
    
  }

  void addSettingItem(TimerSettingItem item) {
    if (_settingList.any((e) => e.id == item.id)) {
      return;
    }

    if (_onlyAddSettingItem(item)) {
      notifyListeners();
    }
  }

  bool _onlyAddSettingItem(TimerSettingItem item) {
    if (_settingList.any((e) => e.id == item.id)) {
      return false;
    }
    _settingList.add(item);
    return true;
  }

  /// 添加一个新的配置
  void addTimerSetting(String summary, TimerSetting timerSetting) {
    TimerSettingItem item = TimerSettingItem();
    item.id = GlobalData.spawnNextTimerSettingItemId();
    item.summary = summary;
    item.timerSetting = TimerSetting.copy(timerSetting);

    addSettingItem(item);
  }
  
  /// 根据id获取对应的配置项
  TimerSettingItem getTimerSettingItemById(int id) {
    return _settingList.firstWhere((e) => e.id == id);
  }
}

/// 初始的配置，如果这个配置发生变化，那么需要重建输入
class InitTimerSetting extends ChangeNotifier {
  /// 对应的配置id
  int timerSettingItemId;

  void updateInitTimerSetting(int itemId) {
    timerSettingItemId = itemId;
    notifyListeners();
  }

}

/// 生效的配置信息
class CurrentTimerSetting extends ChangeNotifier {
  /// 生效的配置信息
  TimerSetting timerSetting;

  void updateCurrentTimerSetting(TimerSetting setting) {
    timerSetting = TimerSetting.copy(setting);
    notifyListeners();
  }
} 
