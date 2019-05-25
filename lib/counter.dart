import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Tutorial',
      home: TutorialHome(),
    )
  );
}

class TutorialHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Scaffold是Material中主要的布局组件，
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: Text('Example title'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          )
        ],
      ),
      //body占屏幕的大部分
      body: Center(
        // child: Text('Hello World!'),
        child: CounterDisplay(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}


// ------------------升级版计数器----------------- //
class CounterDisplay extends StatelessWidget {
  CounterDisplay({this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text('Count: $count');
  }
}

class CounterIncrementor extends StatelessWidget {
  CounterIncrementor({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: Text('Increment'),
    );
  }
}

// 事件流是“向上”传递的，而状态流是“向下”传递的
class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter ++ ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
       children: <Widget>[
         CounterIncrementor(onPressed: _increment),
         CounterDisplay(count: _counter),
       ],
    );
  }
}

// ------------检测用户点击手势widget-------------- //
class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 该GestureDetector widget并不具有显示效果，而是检测由用户做出的手势
    // 当用户点击Container时， GestureDetector会调用它的onTap回调， 在回调中，将消息打印到控制台
    // 可以使用GestureDetector来检测各种输入手势，包括点击、拖动和缩放。
    return GestureDetector(
      onTap: () {
        print('MyButton was tapped!');
      },
      child: Container(
        height: 36.0,
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightGreen[500],
        ),
        child: Center(
          child: Text('Engage'),
        ),
      ),
    );
  }
}