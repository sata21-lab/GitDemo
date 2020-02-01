import 'package:flutter/material.dart';
import 'package:jd_project/tools/ScreenAdapter.dart';

class BuyNow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          print("立即购买");
        },
        child: Container(
            margin: EdgeInsets.all(ScreenUtilAdapter.setHeight(20)),
            height: ScreenUtilAdapter.setHeight(140),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 165, 0, 0.9),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "立即购买",
                style: TextStyle(color: Colors.white),
              ),
            )));
  }
}
