import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/common/Utility.dart';
import 'package:timer/common/theme.dart';
import 'package:timer/models/timerSetting.dart';
import 'package:timer/models/globalData.dart';

class CountdownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CurrentTimerSettingModel currentTimerSettingModel =
        Provider.of<CurrentTimerSettingModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Count Down', style: Theme.of(context).textTheme.display4),
        backgroundColor: Colors.white,
      ),
      body: _CountdownContainer(
          timerSetting: TimerSetting.copy(currentTimerSettingModel.timerSetting)),
    );
  }
}

class _CountdownContainer extends StatefulWidget {
  final TimerSetting timerSetting;

  const _CountdownContainer({Key key, this.timerSetting}) : super(key: key);

  @override
  _CountdownContainerState createState() => _CountdownContainerState();
  void test() {
    
  }
}

class _CountdownContainerState extends State<_CountdownContainer> {
  Timer _countdownTimer;
  int _countdownNum = 59;
  TimerSetting _timerSetting;
  int _totalTimes;
  int _singleTime;
  int _intervalTime;
  
  /// 标记倒计时是单次时间还是间隔时间
  /// true 为单次时间
  /// false 为间隔时间
  bool _countdownFlag;

  /// 倒计时的间隔
  static const int CONTDOWN_INTERVAL_MILL = 100;
  @override
  void initState() {
    super.initState();

    _timerSetting = widget.timerSetting;
    _totalTimes = _timerSetting.totalTimes;
    _singleTime = _timerSetting.singleTime * 1000;
    _intervalTime = _timerSetting.singleInterval * 1000;
    _countdownFlag = true;

    _countdownTimer =
        new Timer.periodic(new Duration(milliseconds: CONTDOWN_INTERVAL_MILL), (timer) {
          setState(() {
            if (_totalTimes <= 0) {
              _countdownTimer.cancel();
              _countdownTimer = null;
              return;
            }
            if (_countdownFlag) {
              if (_singleTime > 0) {
                _singleTime -= CONTDOWN_INTERVAL_MILL;
              } else {
                _countdownFlag = !_countdownFlag;
              }
            } else {
              if (_intervalTime > 0) {
                _intervalTime -= CONTDOWN_INTERVAL_MILL;
              } else {
                _countdownFlag = !_countdownFlag;
                _totalTimes--;
                if (_totalTimes > 0) {
                  _singleTime = _timerSetting.singleTime * 1000;
                  _intervalTime = _timerSetting.singleInterval * 1000;
                }
              }
            }
            
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: <Widget>[
          _buildDisplayArea(),
          _buldButtons(),
        ],
      ),
    );
  }

  Widget _buildDisplayArea() {
    return Column(
      children: <Widget>[
        Container(
          height: 300.0,
          alignment: Alignment.center,
          //color: Colors.red,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              SizedBox(
                height: 250,
                width: 250,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(totalTimesCountDownColor),
                  value: (_totalTimes / _timerSetting.totalTimes),
                ),
              ),
              SizedBox(
                height: 200,
                width: 200,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor:
                      AlwaysStoppedAnimation(intervalTimesCountDownColor),
                  value: (_intervalTime / (_timerSetting.singleInterval * 1000)),
                ),
              ),
              SizedBox(
                height: 150,
                width: 150,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(singleTimesCountDownColor),
                  value: (_singleTime / (_timerSetting.singleTime * 1000)),
                ),
              ),
              _countdownText(),
            ],
          ),
        ),
        Container(
          height: 50.0,
          alignment: Alignment.center,
          //color: Colors.blue,
          child: Row(
            children: <Widget>[
              _colorSummary('剩余组数', totalTimesCountDownColor),
              _colorSummary('间隔时间', intervalTimesCountDownColor),
              _colorSummary('单次时间', singleTimesCountDownColor),
            ],
          ),
        )
      ],
    );
  }

  /// 颜色的说明
  Widget _colorSummary(String text, Color color) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 5,
            width: 20,
            color: color,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _countdownText() {
    
    if (_totalTimes <= 0) {
      return Text('END', style: TextStyle(
        color: totalTimesCountDownColor,
        fontSize: 32,
      ));
    }

    String text;
    Color color;
    if (_countdownFlag) {
      text = _formatTimeString(_singleTime);
      color = singleTimesCountDownColor;
    } else {
      text = _formatTimeString(_intervalTime);
      color = intervalTimesCountDownColor;
    }
    
    return Text(text, style: TextStyle(
      color: color,
      fontSize: 32,
    ));
  }

  String _formatTimeString(int time) {
    String integerPart = Utility.zeroPadding(time ~/ 1000, pad: 2);
    String decimalPart = ((time % 1000) ~/ 100).toString();

    return '$integerPart.$decimalPart';

  }
  
   /// 构建按钮区域
  Widget _buldButtons() {
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
                Icons.stop,
              ),
              color: Colors.blue,
              iconSize: 64,
              onPressed: () {
              },
            ),
          ),
          Positioned(
            top: 10,
            right: 65,
            child: IconButton(
              icon: Icon(
                Icons.pause_circle_filled,
              ),
              color: Colors.blue,
              iconSize: 64,
              onPressed: () {
                // TODO 暂停功能
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }
}
