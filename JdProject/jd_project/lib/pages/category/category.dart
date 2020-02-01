import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jd_project/config/config.dart';
import 'package:jd_project/tools/CategoryLeftModel.dart';
import 'package:jd_project/tools/CategoryRightModel.dart';
import 'package:jd_project/tools/ScreenAdapter.dart';

class CateGory extends StatefulWidget {
  @override
  _CateGoryState createState() => _CateGoryState();
}

class _CateGoryState extends State<CateGory> with AutomaticKeepAliveClientMixin{
  int select=0;
  List LeftDataList=[];
  List RightDataList=[];
  String pid="59f1e1ada1da8b15d42234e9";

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLeftData();
    getRightData();
  }
  void getLeftData() async {
    try {
      var result = await Dio().get("${Config.domain}api/pcate");
      var leftCateList=CateGoryLeftModel.fromJson(result.data);
      setState(() {
        this.LeftDataList=leftCateList.result;
      });
    } catch (e) {
      print(e);
    }
  }
  void getRightData()async{
    try {
      var result = await Dio().get("${Config.domain}api/pcate?pid=${this.pid}");
      var RightCateList=CateGoryRightModel.fromJson(result.data);
      setState((){
        this.RightDataList=RightCateList.result;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var leftWidth=ScreenUtilAdapter.getScreenWidth()/4;
    var rightItemWidth=(ScreenUtilAdapter.getScreenWidth()-leftWidth-40)/3;
    rightItemWidth=ScreenUtilAdapter.setWidth(rightItemWidth);
    var rightItemHeight=rightItemWidth+ScreenUtilAdapter.setHeight(28);
    Widget LeftItemWidget(){
      if(this.LeftDataList.length>0) {
        return Container(
            height: double.infinity,
            width: leftWidth,
            child: ListView.builder(
              itemCount: this.LeftDataList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Container(
                                color: select == index ? Colors.red : Colors
                                    .white,
                                width: 6,
                                height: 20,
                              ),
                              padding: EdgeInsets.only(bottom: 8, left: 5),
                            ),
                            Container(
                                child: Text(this.LeftDataList[index].title + ""),
                                padding: EdgeInsets.only(left: 10, bottom: 8)
                            )
                          ],
                        ),
                        height: ScreenUtilAdapter.setHeight(140),
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            top: ScreenUtilAdapter.setHeight(20)),
                        color: select == index ? Color.fromRGBO(
                            240, 246, 246, 0.9) : Colors.white,
                      ),
                      onTap: () {
                        setState(() {
                          pid=this.LeftDataList[index].sId;
                          select = index;
                          getRightData();
                        });
                      },
                    ),
                    Divider(height: 1,)
                  ],
                );
              },
            )
        );
      }
      else{
        return Container(
          width: leftWidth,
        );
      }
    }
    Widget RightItemWidget(){
      return Expanded(
        child: Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          child: GridView.builder(
            itemCount: this.RightDataList.length,
            itemBuilder: (context,index){
              String sPic = this.RightDataList[index].pic;
              sPic = Config.domain + sPic.replaceAll('\\', '/');
              return InkWell(
                onTap: (){
                  print(this.RightDataList[index].title);
                  Navigator.pushNamed(context, '/product',arguments: {
                    "cid":this.RightDataList[index].sId,
                    "test":123
                  });
                },
                child: Container(
                  height: 110,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 80,
                        width: 80,
                        child: Image.network(sPic, fit: BoxFit.cover),
                      ),
                      Text(this.RightDataList[index].title)
                    ],
                  ),
                ),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: rightItemWidth/rightItemHeight,
              crossAxisSpacing: 5,
            ),
          ),
        ),
        flex: 1,
      );
    }
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: (){

            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.message),
              onPressed: (){

              },
            ),
          ],
          title: InkWell(
            child: Container(
              padding: EdgeInsets.all(ScreenUtilAdapter.size(5)),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 233, 233, 0.8),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: <Widget>[
                  Icon(Icons.search),
                  Text("  "),
                  Text("搜索",)
                ],
              ),

            ),
            onTap: (){
              Navigator.pushNamed(context, '/search');
            },
          )
      ),
      body: Row(
        children: <Widget>[
          LeftItemWidget(),
          RightItemWidget()
        ],
      ),
    );
  }

}



