import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_project/tools/ScreenAdapter.dart';
import 'home/home.dart';
import 'category/category.dart';
import 'shopping_car/shopping_car.dart';
import 'mine/mine.dart';
class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int currentIndex=0;
  List<Widget> pages=[HomePage(),CateGory(),Shopping_Car(),Mine()];
  PageController pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController=new PageController(initialPage: this.currentIndex);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: this.pages,
        onPageChanged: (index){
          setState(() {
            this.currentIndex=index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        fixedColor: Colors.red,
        onTap: (index){
          setState(() {
            currentIndex=index;
            pageController.jumpToPage(index);
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              title: Text("首页"),
              icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
              title: Text("分类"),
              icon: Icon(Icons.category)
          ),
          BottomNavigationBarItem(
              title: Text("购物车"),
              icon: Icon(Icons.shopping_cart)
          ),
          BottomNavigationBarItem(
              title: Text("我的"),
              icon: Icon(Icons.people)
          ),
        ],
      ),
    );
  }
}
