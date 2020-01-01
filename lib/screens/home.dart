import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/models/timer.dart';
import 'package:timer/models/timerSetting.dart';
import 'package:timer/screens/timerInputPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() =>_HomePageState();
  
}

class _HomePageState extends State<HomePage> {
  /// 当前生效的timer配置
  TimerSetting _tempTimerSetting = new TimerSetting();
  
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer', style: Theme.of(context).textTheme.display4),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () => Navigator.pushNamed(context, '/saved'),
          ),
        ],
        
      ),

      body: Container(
        //child: _buildBody(context),
        child: TimerInputPage(),
      ),
    );
  }
  
    Widget _buildBody(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTextFomField('每组时间', '请输入每组的时间，单位为秒', 
            (String singleTimeValue) {
              _tempTimerSetting.singleTime = int.parse(singleTimeValue);
            }),
          _buildTextFomField('每组间隔时间', '请输入每组间隔时间，单位为秒',
            (String singleIntervalValue) {
              _tempTimerSetting.singleInterval = int.parse(singleIntervalValue);
            }),
          _buildTextFomField('总组数', '请输入总共的组数', 
            (String totalTimesValue) {
              _tempTimerSetting.totalTimes = int.parse(totalTimesValue);
            }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            onPressed: () {
              // Validate will return true if the form is valid, or false if
              // the form is invalid.
              if (_formKey.currentState.validate()) {
                // Process data.
                _formKey.currentState.save();
                TimerModel timerModel = Provider.of<TimerModel>(context);
                timerModel.modifyTimerSetting(_tempTimerSetting);
                //_startTimer(context);
              }
            },
            child: Text('开始'),
          ),
          )
        ],
      ),
    );
  }

  Widget _buildTextFomField(String label, String hintText, FormFieldSetter<String> savedFunc) {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(Icons.mood),
        hintText: hintText,
        labelText: label,
      ),
      onSaved: savedFunc,
      validator: (value) {
        if (value.isEmpty || !_isInt(value)) {
          return '请输入数字';
        }

        return null;
      },
    );
  }

  bool _isInt(String value) {
    try {
      int.parse(value);
      return true;
    } catch (Exception) {
      return false;
    }
  }

  void _startTimer(BuildContext context) {
    Navigator.pushNamed(context, '/timer');
  }

}