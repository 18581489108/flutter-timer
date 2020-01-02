import 'package:flutter/foundation.dart';

/// 倒计时相关的model
class TotalTimesModel extends ChangeNotifier {
  int totalTimes;

  void decTotalTimes() {
    if (totalTimes <= 0) {
      return;
    }

    totalTimes--;
    notifyListeners();
  }

  void setTotalTimes(int totalTimes) {
    this.totalTimes = totalTimes;
    notifyListeners();
  }
}

class SingleTimeModel extends ChangeNotifier {
  int singleTime;

  void decSingleTime(int number) {
    singleTime -= number;
    notifyListeners();
  }

  void setSingleTime(int singleTime) {
    this.singleTime = singleTime;
    notifyListeners();
  }

}

class IntervalTimeModel extends ChangeNotifier {
  int intervalTime;

  void decSingleTime(int number) {
    intervalTime -= number;
    notifyListeners();
  }

  void setIntervalTime(int intervalTime) {
    this.intervalTime = intervalTime;
    notifyListeners();
  }

}

class CountdownFlagModel extends ChangeNotifier {
  /// 标记倒计时是单次时间还是间隔时间
  /// true 为单次时间
  /// false 为间隔时间
  bool countdownFlag;

  void setCountdownFlag(bool countdownFlag) {
    this.countdownFlag = countdownFlag;
    notifyListeners();
  }
}