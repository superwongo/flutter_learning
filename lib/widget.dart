import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'My app',
      home: Myscaffold(),
    )
  );
}

class Myscaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Material 是UI呈现的“一张纸”
    return Material(
      // Column is 垂直方向的线性布局
      child: Column(
        children: <Widget>[
          // 将一个Text widget作为其标题传递给应用程序栏
          MyAppBar(
            title: Text(
              'Example title',
              style: Theme.of(context).primaryTextTheme.title,
            )
          ),
          Expanded(
            child: Center(
              child: Text('Hello World!'),
            ),
          )
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  MyAppBar({this.title});

  // Widget子类中的字段往往都会定义为"final"
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      // 单位是逻辑上的像素（并非真实的像素，类似于浏览器中的像素）
      height: 56.0,
      // 左侧和右侧均有8像素的填充
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      // 装饰为一个BoxDecoration, 如 background、一个边框、或者一个阴影
      decoration: BoxDecoration(color: Colors.blue[500]),
      // Row 是水平方向的线性布局（linear layout）
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation menu',
            // null 会禁用 button
            onPressed: null,
          ),
          // 中间的title widget被标记为Expanded，会填充尚未被其他子项占用的的剩余可用空间
          // Expanded可以拥有多个children，然后使用flex参数来确定他们占用剩余空间的比例
          Expanded(
            child: title,
          ),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          )
        ],
      ),
    );
  }
}
