import 'package:flutter/material.dart';
import 'package:jd_project/tools/EventBus.dart';
import 'package:jd_project/tools/ScreenAdapter.dart';

class AddShopping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          eventBus.fire(new ProductContentEvent('购物车'));
        },
        child: Container(
            margin: EdgeInsets.all(ScreenUtilAdapter.setHeight(20)),
            height: ScreenUtilAdapter.setHeight(140),
            decoration: BoxDecoration(
                color: Color.fromRGBO(253, 1, 0, 0.9),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "加入购物车",
                style: TextStyle(color: Colors.white),
              ),
            )));
  }
}
