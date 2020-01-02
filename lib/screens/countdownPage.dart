import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/common/Utility.dart';
import 'package:timer/common/theme.dart';
import 'package:timer/models/countdownData.dart';
import 'package:timer/models/timerSetting.dart';
import 'package:timer/models/globalData.dart';

class CountdownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CurrentTimerSettingModel currentTimerSettingModel =
        Provider.of<CurrentTimerSettingModel>(context);
    TimerSetting timerSetting =
        TimerSetting.copy(currentTimerSettingModel.timerSetting);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TotalTimesModel>(
          create: (context) => TotalTimesModel(timerSetting.totalTimes),
        ),
        ChangeNotifierProvider<SingleTimeModel>(
          create: (context) => SingleTimeModel(timerSetting.singleTime * 1000),
        ),
        ChangeNotifierProvider<IntervalTimeModel>(
          create: (context) =>
              IntervalTimeModel(timerSetting.singleInterval * 1000),
        ),
        ChangeNotifierProvider<CountdownFlagModel>(
          create: (context) => CountdownFlagModel(true),
        ),
        ChangeNotifierProvider<PlayStatusModel>(
          create: (context) => PlayStatusModel(true),
        ),
        /*
        ChangeNotifierProxyProvider3<TotalTimesModel, SingleTimeModel,
                IntervalTimeModel, CountdownFlagModel>(
            create: (context) => CountdownFlagModel(),
            update: (context, totalTimesModel, singleTimeModel,
                intervalTimeModel, previousCartCountdownFlagModel) {
              CountdownFlagModel model = CountdownFlagModel();
              model.countdownFlag =
                  previousCartCountdownFlagModel?.countdownFlag;
              return model;
            }),
            */
      ],
      child: Scaffold(
        appBar: AppBar(
          title:
              Text('Count Down', style: Theme.of(context).textTheme.display4),
          backgroundColor: Colors.white,
        ),
        body: _CountdownContainer(timerSetting: timerSetting),
      ),
    );
  }
}

class _CountdownContainer extends StatefulWidget {
  final TimerSetting timerSetting;

  const _CountdownContainer({Key key, this.timerSetting}) : super(key: key);

  @override
  _CountdownContainerState createState() => _CountdownContainerState();
}

class _CountdownContainerState extends State<_CountdownContainer> {
  Timer _countdownTimer;
  TimerSetting _timerSetting;

  /// 倒计时的间隔
  static const int COUNTDOWN_INTERVAL_MILL = 100;
  @override
  void initState() {
    super.initState();
    _timerSetting = widget.timerSetting;
    _resetCountdownTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _resetCountdownTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    _countdownTimer = new Timer.periodic(
        new Duration(milliseconds: COUNTDOWN_INTERVAL_MILL), (timer) {
      TotalTimesModel totalTimesModel = Provider.of<TotalTimesModel>(context);
      if (totalTimesModel.totalTimes <= 0) {
        _countdownTimer.cancel();
        _countdownTimer = null;
        return;
      }

      CountdownFlagModel countdownFlagModel =
          Provider.of<CountdownFlagModel>(context);
      SingleTimeModel singleTimeModel = Provider.of<SingleTimeModel>(context);
      IntervalTimeModel intervalTimeModel =
          Provider.of<IntervalTimeModel>(context);
      if (countdownFlagModel.countdownFlag) {
        if (singleTimeModel.singleTime > 0) {
          singleTimeModel.decSingleTime(COUNTDOWN_INTERVAL_MILL);
        } else {
          countdownFlagModel
              .setCountdownFlag(!countdownFlagModel.countdownFlag);
        }
      } else {
        if (intervalTimeModel.intervalTime > 0) {
          intervalTimeModel.decSingleTime(COUNTDOWN_INTERVAL_MILL);
        } else {
          countdownFlagModel
              .setCountdownFlag(!countdownFlagModel.countdownFlag);
          totalTimesModel.decTotalTimes();
          if (totalTimesModel.totalTimes > 0) {
            singleTimeModel.setSingleTime(_timerSetting.singleTime * 1000);
            intervalTimeModel
                .setIntervalTime(_timerSetting.singleInterval * 1000);
          }
        }
      }
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
                child: _TotalTimesCircularProgressIndicator(_timerSetting),
              ),
              SizedBox(
                height: 200,
                width: 200,
                child: _IntervalTimeCircularProgressIndicator(_timerSetting),
              ),
              SizedBox(
                height: 150,
                width: 150,
                child: _SingleTimeCircularProgressIndicator(_timerSetting),
              ),
              _CountdownText(),
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
              _colorSummary('间隔时间', intervalTimeCountDownColor),
              _colorSummary('单次时间', singleTimeCountDownColor),
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
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: 10,
            right: 65,
            child: _PauseOrPlayButton(
              onPressed: () {
                PlayStatusModel playStatusModel = Provider.of<PlayStatusModel>(context);
                if (playStatusModel.isPlaying) {
                  _countdownTimer?.cancel();
                  _countdownTimer = null;
                } else {
                  _resetCountdownTimer();
                }

                playStatusModel.setIsPlaying(!playStatusModel.isPlaying);
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

class _TotalTimesCircularProgressIndicator extends StatelessWidget {
  final TimerSetting timerSetting;

  _TotalTimesCircularProgressIndicator(this.timerSetting);

  @override
  Widget build(BuildContext context) {
    return Consumer<TotalTimesModel>(
      builder: (BuildContext context, TotalTimesModel totalTimesModel,
          Widget child) {
        return CircularProgressIndicator(
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation(totalTimesCountDownColor),
          value: (totalTimesModel.totalTimes / timerSetting.totalTimes),
        );
      },
    );
  }
}

class _IntervalTimeCircularProgressIndicator extends StatelessWidget {
  final TimerSetting timerSetting;

  _IntervalTimeCircularProgressIndicator(this.timerSetting);

  @override
  Widget build(BuildContext context) {
    return Consumer<IntervalTimeModel>(
      builder: (BuildContext context, IntervalTimeModel intervalTimeModel,
          Widget child) {
        return CircularProgressIndicator(
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation(intervalTimeCountDownColor),
          value: (intervalTimeModel.intervalTime / (timerSetting.singleInterval * 1000)),
        );
      },
    );
  }
}

class _SingleTimeCircularProgressIndicator extends StatelessWidget {
  final TimerSetting timerSetting;

  _SingleTimeCircularProgressIndicator(this.timerSetting);

  @override
  Widget build(BuildContext context) {
    return Consumer<SingleTimeModel>(
      builder: (BuildContext context, SingleTimeModel singleTimeModel,
          Widget child) {
            //print((singleTimeModel.singleTime / (timerSetting.singleTime * 1000)));
        return CircularProgressIndicator(
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation(singleTimeCountDownColor),
          value: (singleTimeModel.singleTime / (timerSetting.singleTime * 1000)),
        );
      },
    );
  }
}

class _CountdownText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer4<TotalTimesModel, SingleTimeModel, IntervalTimeModel,
        CountdownFlagModel>(
      builder: (BuildContext context,
          TotalTimesModel totalTimesModel,
          SingleTimeModel singleTimeModel,
          IntervalTimeModel intervalTimeModel,
          CountdownFlagModel countdownFlagModel,
          Widget child) {
        if (totalTimesModel.totalTimes <= 0) {
          return Text('END',
              style: TextStyle(
                color: totalTimesCountDownColor,
                fontSize: 32,
              ));
        }

        String text;
        Color color;
        if (countdownFlagModel.countdownFlag) {
          text = _formatTimeString(singleTimeModel.singleTime);
          color = singleTimeCountDownColor;
        } else {
          text = _formatTimeString(intervalTimeModel.intervalTime);
          color = intervalTimeCountDownColor;
        }

        return Text(text,
            style: TextStyle(
              color: color,
              fontSize: 32,
            ));
      },
    );
  }

  String _formatTimeString(int time) {
    String integerPart = Utility.zeroPadding(time ~/ 1000, pad: 2);
    String decimalPart = ((time % 1000) ~/ 100).toString();

    return '$integerPart.$decimalPart';
  }
}

class _PauseOrPlayButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _PauseOrPlayButton({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer2<PlayStatusModel, TotalTimesModel>(
      builder: (BuildContext context, PlayStatusModel playStatusModel, TotalTimesModel totalTimesModel,
          Widget child) {
            return IconButton(
              icon: Icon(
                playStatusModel.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
              ),
              color: Colors.blue,
              iconSize: 64,
              onPressed: totalTimesModel.totalTimes > 0 ? onPressed : null);
          },
    );
  }
}
