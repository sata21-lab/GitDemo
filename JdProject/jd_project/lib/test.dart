import 'package:flutter/material.dart';

class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("跳转测试"),
        ),
        body: Center(
          child: Text("跳转成功"),
        ),
      ),
    );
  }
}
