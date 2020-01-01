import 'package:flutter/material.dart';
import 'package:timer/common/theme.dart';

class CountdownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Count Down', style: Theme.of(context).textTheme.display4),
        backgroundColor: Colors.white,
      ),
      body: _CountdownContainer(),
    );
  }
}

class _CountdownContainer extends StatefulWidget {
  @override
  _CountdownContainerState createState() => _CountdownContainerState();
}

class _CountdownContainerState extends State<_CountdownContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: <Widget>[
          _buildDisplayArea(),
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
                  value: .7,
                ),
              ),
              SizedBox(
                height: 200,
                width: 200,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor:
                      AlwaysStoppedAnimation(intervalTimesCountDownColor),
                  value: .7,
                ),
              ),
              SizedBox(
                height: 150,
                width: 150,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(singleTimesCountDownColor),
                  value: .7,
                ),
              ),
              Text('剩余时间')
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
}
