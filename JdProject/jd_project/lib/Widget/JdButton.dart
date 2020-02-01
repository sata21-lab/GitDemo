import 'package:flutter/material.dart';
import 'package:jd_project/tools/ScreenAdapter.dart';

class JdButton extends StatelessWidget {

  final Color color;
  final String text;
  final Object cb;
  JdButton({Key key,this.color=Colors.black,this.text="按钮",this.cb=null}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.cb,
      child: Container(
        margin: EdgeInsets.all(ScreenUtilAdapter.setHeight(20)),
        padding: EdgeInsets.all(ScreenUtilAdapter.setHeight(20)),
        height: ScreenUtilAdapter.setHeight(140),
        width: double.infinity,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            "${text}",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
