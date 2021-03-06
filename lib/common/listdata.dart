import 'package:timer/common/Utility.dart';

///==================== 滚动区域的显示对象 ========================
class DisplayItem {
  final int number;
  final String display;

  DisplayItem(this.number, this.display);
}

///==================== 滚动区域的提示对象 ========================
class HintTextGroup {
  final String firstHintText;
  final String secondHintText;

  HintTextGroup(this.firstHintText, this.secondHintText);
}

/// 全局的静态数据
class GlobalConstData {
  static String zeroPadding(int num, {int pad: 0}) {
    return Utility.zeroPadding(num, pad: pad);
  }

  // 显示总次数
  static final List<DisplayItem> totalTimesItemList = initTotalTimesItems();
  static List<DisplayItem> initTotalTimesItems() {
    int count = 99;
    List<DisplayItem> list = new List();
    for (int i = 1; i <= count; i++) {
      list.add(new DisplayItem(i, zeroPadding(i, pad: 2)));
    }
    return list;
  }

  // 通过group的值找到对应的DisplayItem的下标
  static int getIndexByTotalTimesValue(int gourpValue) {
    return gourpValue - 1;
  }

  // 显示单次时间
  static final List<DisplayItem> singleTimeItemList = initSginleTimeItems();
  static List<DisplayItem> initSginleTimeItems() {
    int count = 99;
    List<DisplayItem> list = new List();
    for (int i = 1; i <= count; i++) {
      list.add(new DisplayItem(i, zeroPadding(i, pad: 2)));
    }
    return list;
  }

  // 通过singleTime的值找到对应的DisplayItem的下标
  static int getIndexBySingleTimeValue(int singleTimeValue) {
    return singleTimeValue - 1;
  }

  // 显示间隔时间
  static final List<DisplayItem> intervalTimeItemList = initIntervalTimeItems();
  static List<DisplayItem> initIntervalTimeItems() {
    int count = 99;
    List<DisplayItem> list = new List();
    for (int i = 1; i <= count; i++) {
      list.add(new DisplayItem(i, zeroPadding(i, pad: 2)));
    }
    return list;
  }

  // 通过intervalTime的值找到对应的DisplayItem的下标
  static int getIndexByIntervalTimeValue(int intervalTimeValue) {
    return intervalTimeValue - 1;
  }

  // 显示多少组的提示
  static final HintTextGroup totalTimesItemListHintGroup =
      new HintTextGroup('进行', '组');

  // 显示单次时间的提示
  static final HintTextGroup singleTimeItemListHintGroup =
      new HintTextGroup('单次', '秒');

  // 显示间隔时间的提示
  static final HintTextGroup intervalTimeItemListHintGroup =
      new HintTextGroup('间隔', '秒');
}
