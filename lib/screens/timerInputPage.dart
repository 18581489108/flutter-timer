import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timer/common/cyclicScroller.dart';
import 'package:timer/common/listdata.dart';
import 'package:timer/common/theme.dart';
import 'package:timer/models/timerSetting.dart';



class TimerInputPage extends StatefulWidget {
  @override
  _TimerInputPageState createState() => _TimerInputPageState();
  
}

class _TimerInputPageState extends State<TimerInputPage> {
  // 滚动条显示总高度
  static const double SCROLLER_TOTAL_HEIGHT = 330;
  // 滚动条的宽度
  static const double SCROLLER_WIDTH = 45;
  // 同时显示的个数
  static const int  SCROLLER_SHOW_ITEM_COUNT = 5;

  /// 当前生效的timer配置
  TimerSetting _tempTimerSetting = new TimerSetting();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 350.0,
            //color: Colors.blue,
            child: Row(
              children: <Widget>[
                _buildScroller(
                    groupItemListHintGroup,
                    CyclicScroller<DisplayItem>(
                      selectIndex: 2,
                      onStopScroll: (DisplayItem item) {
                        print(item.number);
                      },
                      list: groupItemList,
                      totalHeight: SCROLLER_TOTAL_HEIGHT,
                      width: SCROLLER_WIDTH,
                      showItemCount: SCROLLER_SHOW_ITEM_COUNT,
                      displayItemFunc: (DisplayItem item) => item.display,
                    )),
                _buildScroller(
                    singleTimeItemListHintGroup,
                    CyclicScroller<DisplayItem>(
                      selectIndex: 2,
                      onStopScroll: (DisplayItem item) {
                        print(item.number);
                      },
                      list: singleTimeItemList,
                      totalHeight: SCROLLER_TOTAL_HEIGHT,
                      width: SCROLLER_WIDTH,
                      showItemCount: SCROLLER_SHOW_ITEM_COUNT,
                      displayItemFunc: (DisplayItem item) => item.display,
                    )),
                _buildScroller(
                    intervalTimeItemListHintGroup,
                    CyclicScroller<DisplayItem>(
                      selectIndex: 2,
                      onStopScroll: (DisplayItem item) {
                        print(item.number);
                      },
                      list: intervalTimeItemList,
                      totalHeight: SCROLLER_TOTAL_HEIGHT,
                      width: SCROLLER_WIDTH,
                      showItemCount: SCROLLER_SHOW_ITEM_COUNT,
                      displayItemFunc: (DisplayItem item) => item.display,
                    )),
              ],
            ),
          ),
          Container(
            height: 100.0,
            color: Colors.blueGrey,
          ),
        ],
      ),
    );
  }

  Widget _buildScroller(
      HintTextGroup hintTextGroup, CyclicScroller<DisplayItem> scroller) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Text(hintTextGroup.firstHintText,
              textAlign: TextAlign.center, style: scrollerDescTextStyle),
          SizedBox(
            width: 3,
          ),
          scroller,
          SizedBox(
            width: 3,
          ),
          Text(hintTextGroup.secondHintText,
              textAlign: TextAlign.center, style: scrollerDescTextStyle),
        ],
      ),
    );
  }
}