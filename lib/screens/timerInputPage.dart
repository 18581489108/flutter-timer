
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:timer/common/Utility.dart';
import 'package:timer/common/cyclicScroller.dart';
import 'package:timer/common/listdata.dart';
import 'package:timer/common/theme.dart';
import 'package:timer/models/globalData.dart';
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
  static const int SCROLLER_SHOW_ITEM_COUNT = 5;

  /// 当前生效的timer配置
  TimerSetting _tempTimerSetting = new TimerSetting();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: <Widget>[
          _buildInputScrollers(),
          _buldButtons(context),
        ],
      ),
    );
  }

  /// 构建输入用的滚动条
  Widget _buildInputScrollers() {
    return Container(
      height: 350.0,
      //color: Colors.blue,
      child: Consumer<CurrentTimerSettingModel>(
          builder: (context, currentTimerSettingModel, child) {
        TimerSetting timerSetting = currentTimerSettingModel.timerSetting;
        int totalTimesInitSelectIndex;
        int singleTimeInitSelectIndex;
        int intervalTimeInitSelectIndex;
        if (timerSetting == null) {
          totalTimesInitSelectIndex = 0;
          singleTimeInitSelectIndex = 0;
          intervalTimeInitSelectIndex = 0;
        } else {
          totalTimesInitSelectIndex = GlobalConstData.getIndexByTotalTimesValue(
              timerSetting.totalTimes);
          singleTimeInitSelectIndex = GlobalConstData.getIndexBySingleTimeValue(
              timerSetting.singleTime);
          intervalTimeInitSelectIndex =
              GlobalConstData.getIndexByIntervalTimeValue(
                  timerSetting.singleInterval);
        }

        _tempTimerSetting.totalTimes = GlobalConstData
            .totalTimesItemList[totalTimesInitSelectIndex].number;
        _tempTimerSetting.singleTime = GlobalConstData
            .singleTimeItemList[singleTimeInitSelectIndex].number;
        _tempTimerSetting.singleInterval = GlobalConstData
            .intervalTimeItemList[intervalTimeInitSelectIndex].number;

        return Row(
          children: <Widget>[
            _buildScroller(
                GlobalConstData.totalTimesItemListHintGroup,
                CyclicScroller<DisplayItem>(
                  selectIndex: totalTimesInitSelectIndex,
                  onStopScroll: (DisplayItem item) {
                    _tempTimerSetting.totalTimes = item.number;
                  },
                  list: GlobalConstData.totalTimesItemList,
                  totalHeight: SCROLLER_TOTAL_HEIGHT,
                  width: SCROLLER_WIDTH,
                  showItemCount: SCROLLER_SHOW_ITEM_COUNT,
                  displayItemFunc: (DisplayItem item) => item.display,
                )),
            _buildScroller(
                GlobalConstData.singleTimeItemListHintGroup,
                CyclicScroller<DisplayItem>(
                  selectIndex: singleTimeInitSelectIndex,
                  onStopScroll: (DisplayItem item) {
                    _tempTimerSetting.singleTime = item.number;
                  },
                  list: GlobalConstData.singleTimeItemList,
                  totalHeight: SCROLLER_TOTAL_HEIGHT,
                  width: SCROLLER_WIDTH,
                  showItemCount: SCROLLER_SHOW_ITEM_COUNT,
                  displayItemFunc: (DisplayItem item) => item.display,
                )),
            _buildScroller(
                GlobalConstData.intervalTimeItemListHintGroup,
                CyclicScroller<DisplayItem>(
                  selectIndex: intervalTimeInitSelectIndex,
                  onStopScroll: (DisplayItem item) {
                    _tempTimerSetting.singleInterval = item.number;
                  },
                  list: GlobalConstData.intervalTimeItemList,
                  totalHeight: SCROLLER_TOTAL_HEIGHT,
                  width: SCROLLER_WIDTH,
                  showItemCount: SCROLLER_SHOW_ITEM_COUNT,
                  displayItemFunc: (DisplayItem item) => item.display,
                )),
          ],
        );
      }),
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

  /// 构建按钮区域
  Widget _buldButtons(BuildContext context) {
    return Container(
      height: 100.0,
      //color: Colors.blueGrey,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 65,
            child: IconButton(
              icon: Icon(
                Icons.play_circle_filled,
              ),
              color: Colors.blue,
              iconSize: 64,
              onPressed: () {
                CurrentTimerSettingModel currentTimerSettingModel = Provider.of<CurrentTimerSettingModel>(context);
                currentTimerSettingModel.updateCurrentTimerSetting(_tempTimerSetting);
                Navigator.pushNamed(context, RouteConsts.COUNT_DOWN_PAGE);
              },
            ),
          ),
          Positioned(
            top: 10,
            right: 65,
            child: IconButton(
              icon: Icon(
                Icons.favorite_border,
              ),
              color: Colors.blue,
              iconSize: 64,
              onPressed: () {
                print('need save');
              },
            ),
          ),

          /*
          Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.play_circle_filled,
                    size: 64,
                    color: Colors.blue,
                  ),
                  onPressed: () {},
                ),
              )),*/
        ],
      ),
    );
  }
}
