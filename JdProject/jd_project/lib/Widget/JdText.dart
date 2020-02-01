import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jd_project/tools/ScreenAdapter.dart';

class JdText extends StatelessWidget {

  final String text;
  final bool password;
  final Object onChanged;
  final Object TextEditingController;
  JdText({Key key,this.text="输入内容",this.password=false,this.onChanged=null,this.TextEditingController=null}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: TextEditingController,
        obscureText: this.password,
        decoration: InputDecoration(
            hintText: this.text,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none)),
        onChanged: this.onChanged,
      ),
      height: ScreenUtilAdapter.setHeight(68),
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
