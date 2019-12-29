import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 返回滚动到的元素对象
typedef StopScrollCallback<E> = void Function(E item);

/// 获取元素的显示
typedef DisplayItemFunc<E> = String Function(E item);

/// 循环滚动
class CyclicScroller<E> extends StatefulWidget {
  /// 整个滚动区域的显示高度
  final double totalHeight;

  /// 滚动区域宽度
  final double width;

  /// 区域内显示的元素数量，需要为奇数
  final int showItemCount;

  /// 用来指定初始选中的下标
  final int selectIndex;

  /// 滚动停止的回调方法
  final StopScrollCallback<E> onStopScroll;

  /// 用于显示的list
  final List<E> list;

  /// 用于显示元素的方法回调
  final DisplayItemFunc<E> displayItemFunc;

  CyclicScroller(
      {this.selectIndex,
      this.onStopScroll,
      this.list,
      this.totalHeight,
      this.showItemCount,
      this.displayItemFunc,
      this.width});

  @override
  _CyclicScrollerState<E> createState() => _CyclicScrollerState<E>();
}

class _CyclicScrollerState<E> extends State<CyclicScroller<E>> {
  bool isScrollEndNotification = false;
  ScrollController _controller;

  /// 整个区域的高度
  double _totalHeight;

  /// 整个区域显示的数量
  int _showItemCount;

  /// 单个item的高度
  double _singleItemHeight;

  /// 一半区域（不包含选中中间区域）显示的数量
  int _halfZoneCount;

  /// 向上滚动的限制
  double _upLimit;

  /// 向下滚动的限制
  double _downLimit;
  List<E> _list;

  @override
  void initState() {
    super.initState();
    this._totalHeight = widget.totalHeight;
    this._showItemCount = widget.showItemCount;
    this._list = widget.list;
    this._singleItemHeight = this._totalHeight / this._showItemCount;
    this._halfZoneCount = this._showItemCount ~/ 2;
    this._upLimit = _singleItemHeight * (_list.length - _halfZoneCount);
    this._downLimit = _singleItemHeight * (2 * _list.length - _halfZoneCount);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller = ScrollController(
      initialScrollOffset: _singleItemHeight *
          (_list.length - _halfZoneCount + widget.selectIndex),
    );

    _controller.addListener(() {
      if (_controller.offset > _downLimit) {
        double newPosition =
            _singleItemHeight * (_list.length - _halfZoneCount);
        _controller.jumpTo(newPosition);
      }

      if (_controller.offset < _upLimit) {
        double newPosition =
            _singleItemHeight * (2 * _list.length - _halfZoneCount);
        _controller.jumpTo(newPosition);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      child: Row(
        children: <Widget>[
          _line(_totalHeight),
          Container(
            width: widget.width,
            //color: Colors.white,
            height: _totalHeight,
            child: _listView(_totalHeight),
          ),
          _line(_totalHeight),
        ],
      ),
    );
  }

  Widget _line(double height) {
    return Container(
      width: 0.5,
      height: height,
      color: Colors.black87,
    );
  }

  Widget _listView(double height) {
    double singleItemHeight = _singleItemHeight;
    return Stack(
      children: <Widget>[
        NotificationListener<ScrollNotification>(
          child: ListView.builder(
            controller: _controller,
            itemCount: _list.length * 3,
            itemExtent: singleItemHeight,
            itemBuilder: (BuildContext context, int index) {
              return _listViewItem(
                  widget.displayItemFunc(_list[index % _list.length]),
                  index,
                  singleItemHeight);
            },
            scrollDirection: Axis.vertical,
          ),
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollStartNotification) {
              isScrollEndNotification = false;
              return true;
            }

            if (!(notification is ScrollEndNotification) ||
                isScrollEndNotification) {
              return true;
            }
            isScrollEndNotification = true;

            int count =
                (notification.metrics.pixels / _singleItemHeight).round();

            _controller.jumpTo(count * _singleItemHeight);
            int itemIndex = (count + _halfZoneCount) % _list.length;
            widget.onStopScroll(_list[itemIndex]);
            return true;
          },
        ),
        Positioned(
          top: singleItemHeight * (_showItemCount ~/ 2),
          left: 0,
          child: Container(
            width: 2,
            height: singleItemHeight,
            color: Colors.blueGrey,
          ),
        ),
        Positioned(
          top: singleItemHeight * (_showItemCount ~/ 2),
          right: 0,
          child: Container(
            width: 2,
            height: singleItemHeight,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }

  Widget _listViewItem(String title, int index, double singleItemHeight) {
    return GestureDetector(
      child: Container(
        //margin: const EdgeInsets.all(5),
        //color: Colors.w,
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            //fontFamily: 'Corben',
            fontWeight: FontWeight.w200,
            fontSize: 32,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
