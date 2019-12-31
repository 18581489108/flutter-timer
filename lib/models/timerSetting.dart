class TimerSetting {
  /// 单次时间，单位秒
  int singleTime = 0;

  /// 单次间隔，单位秒
  int singleInterval = 0;

  /// 总次数
  int totalTimes = 0;

  static TimerSetting copy(TimerSetting source) {
    assert(source != null);

    TimerSetting newObj = TimerSetting();
    newObj.totalTimes = source.totalTimes;
    newObj.singleTime = source.singleTime;
    newObj.singleInterval = source.singleInterval;
    return newObj;
  }
}

class TimerSettingItem {
  /// 唯一id
  int id = 0;

  /// 配置摘要
  String summary = '';

  /// 具体配置
  TimerSetting timerSetting;
}