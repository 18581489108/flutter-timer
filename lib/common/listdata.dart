///==================== 滚动区域的显示对象 ========================
class DisplayItem {
  final int number;
  final String display;

  DisplayItem(this.number, this.display);
}

String zeroPadding(int num, {int pad: 0}) {
  var str = num.toString();
  var paddingToAdd = pad - str.length;
  return (paddingToAdd > 0) 
      ? "${new List.filled(paddingToAdd, '0').join('')}$num" : str;
}

List<DisplayItem> initGroupItems() {
  int count = 99;
  List<DisplayItem> list = new List();
  for (int i = 1; i <= count; i++) {
    list.add(new DisplayItem(i, zeroPadding(i, pad: 2)));
  }
  return list;
}  
// 显示多少组
final List<DisplayItem> groupItemList = initGroupItems();

List<DisplayItem> initSginleTimeItems() {
  int count = 99;
  List<DisplayItem> list = new List();
  for (int i = 1; i <= count; i++) {
    list.add(new DisplayItem(i, zeroPadding(i, pad: 2)));
  }
  return list;
}  

// 显示单次时间
final List<DisplayItem> singleTimeItemList = initSginleTimeItems();

List<DisplayItem> initIntervalTimeItems() {
  int count = 99;
  List<DisplayItem> list = new List();
  for (int i = 1; i <= count; i++) {
    list.add(new DisplayItem(i, zeroPadding(i, pad: 2)));
  }
  return list;
}  

// 显示间隔时间
final List<DisplayItem> intervalTimeItemList = initIntervalTimeItems();

///==================== 滚动区域的提示对象 ========================
class HintTextGroup {
  final String firstHintText;
  final String secondHintText;

  HintTextGroup(this.firstHintText, this.secondHintText);
}

// 显示多少组的提示
final HintTextGroup groupItemListHintGroup = new HintTextGroup('进行', '组');

// 显示单次时间的提示
final HintTextGroup singleTimeItemListHintGroup = new HintTextGroup('单次', '秒');

// 显示间隔时间的提示
final HintTextGroup intervalTimeItemListHintGroup = new HintTextGroup('间隔', '秒');