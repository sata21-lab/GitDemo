import 'package:flutter/material.dart';
import 'package:jd_project/tools/ScreenAdapter.dart';

class BigText extends StatelessWidget {

  final String text;
  final bool password;
  final Object onChanged;
  final Object TextEditingController;
  final int maxLength;
  final double height;
  BigText({Key key,this.text="输入内容",this.height=68,this.password=false,this.onChanged=null,this.TextEditingController=null,this.maxLength=20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        maxLength: maxLength,
        controller: TextEditingController,
        obscureText: this.password,
        decoration: InputDecoration(
            hintText: this.text,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none)),
        onChanged: this.onChanged,
      ),
      height: ScreenUtilAdapter.setHeight(this.height),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1,
                  color: Colors.black12
              )
          )
      ),
    );
  }
}