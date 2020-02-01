import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jd_project/config/config.dart';
import 'package:jd_project/tools/ProductModel.dart';
import 'package:jd_project/tools/RecommendModel.dart';
import 'package:jd_project/tools/ScreenAdapter.dart';
import 'package:jd_project/tools/SwiperDataModel.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  List SwiperdataList=[];
  List ProductDataList=[];
  List RecommendDataList=[];
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  Widget swiperWidget() {
    if(SwiperdataList.length>0){
      return Container(
        margin: EdgeInsets.all(10),
          child: AspectRatio(
            aspectRatio: 2 / 1,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                String pic=this.SwiperdataList[index].pic;
                return Image.network(
                  "${Config.domain}${pic.replaceAll("\\", "/")}",
                  fit: BoxFit.fill,
                );
              },
              autoplay: true,
              itemCount: this.SwiperdataList.length,
              pagination: new SwiperPagination(),
            ),
          ));
    }
    else{
     return Text("加载中...");
    }
  }

  Widget titleWidget() {
    return Container(
      height: ScreenUtilAdapter.setHeight(60),
      margin: EdgeInsets.fromLTRB(ScreenUtilAdapter.setWidth(20), 0, 0, 0),
      padding: EdgeInsets.fromLTRB(ScreenUtilAdapter.setWidth(20), 0, 0, 0),
      child: Text(
        "猜你喜欢",
        style: TextStyle(color: Colors.blue),
      ),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: Colors.red, width: ScreenUtilAdapter.setWidth(10)))),
    );
  }

  Widget title2Widget() {
    return Container(
      height: ScreenUtilAdapter.setHeight(60),
      margin: EdgeInsets.fromLTRB(ScreenUtilAdapter.setWidth(20), 0, 0, 0),
      padding: EdgeInsets.fromLTRB(ScreenUtilAdapter.setWidth(20), 0, 0, 0),
      child: Text(
        "热门推荐",
        style: TextStyle(color: Colors.blue),
      ),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: Colors.red, width: ScreenUtilAdapter.setWidth(10)))),
    );
  }

  Widget MiddleImageList() {
    return Container(
        height: ScreenUtilAdapter.setHeight(250),
        margin: EdgeInsets.fromLTRB(ScreenUtilAdapter.setHeight(20), 0,
            ScreenUtilAdapter.setHeight(20), 0),
        child: ListView.builder(
          itemCount: this.ProductDataList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String sPic = this.ProductDataList[index].sPic;
            sPic = Config.domain + sPic.replaceAll('\\', '/');
            return Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0, 0, ScreenUtilAdapter.setWidth(20), 0),
                  width: ScreenUtilAdapter.setWidth(140),
                  height: ScreenUtilAdapter.setHeight(140),
                  child: Image.network(sPic, fit: BoxFit.cover),
                ),
                SizedBox(
                  height: ScreenUtilAdapter.setHeight(20),
                ),
                Container(
                  //color: Colors.blue,
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtilAdapter.setWidth(12), 0, 0, 0),
                  width: ScreenUtilAdapter.setWidth(140),
                  child: Text(
                    "¥${this.ProductDataList[index].price}",
                    style: TextStyle(color: Colors.red),maxLines: 1,
                  ),
                )
              ],
            );
          },
        ));
  }

  Widget RecommendItemWidget() {
    if(this.RecommendDataList.length>0) {
      var itemWidth = (ScreenUtilAdapter.getScreenWidth() - 30) / 2;
      return Container(
        padding: EdgeInsets.all(10),
        child: Wrap(
          runSpacing: 10,
          spacing: 10,
          children: this.RecommendDataList.map((value) {
            //图片
            String sPic=value.sPic;
            sPic=Config.domain+sPic.replaceAll('\\', '/');
            return InkWell(
              child: Container(
                padding: EdgeInsets.all(10),
                width: itemWidth,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: AspectRatio(
                        //防止服务器返回的图片大小不一致导致高度不一致问题
                        aspectRatio: 1 / 1,
                        child: Image.network(
                          "${sPic}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtilAdapter.setHeight(20)),
                      child: Text(
                        "${value.title}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtilAdapter.setHeight(20)),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "¥${value.price}",
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text( "¥${value.oldPrice}",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                    decoration: TextDecoration.lineThrough)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              onTap: (){
                Navigator.pushNamed(context, '/ProductContent',arguments: {
                  "id":value.sId,
                });
              },
            );
          }).toList(),
        ),
      );
    }
    else{
      return Text("加载中");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSwiperData();
    getRecommendData();
    getProductData();
  }
  void getProductData() async {//商品数据
    var api="${Config.domain}api/plist?is_hot=1";
    try {
      var result = await Dio().get(api);
      var data=ProductModel.fromJson(result.data);
      setState(() {
        ProductDataList=data.result;
      });
    } catch (e) {
      print(e);
    }
  }
  void getRecommendData() async {//商品数据
    var api="${Config.domain}api/plist?is_best=1";
    print(api);
    try {
      var result = await Dio().get(api);
      var data=RecommendModel.fromJson(result.data);
      setState(() {
        RecommendDataList=data.result;
      });
    } catch (e) {
      print(e);
    }
  }
  void getSwiperData() async {//轮播图数据
    var api="${Config.domain}api/focus";
    try {
      var result = await Dio().get(api);
      var data=SwiperModel.fromJson(result.data);
      setState(() {
        SwiperdataList=data.result;
      });
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtilAdapter.init(context);
    super.build(context);
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
      body: ListView(
        children: <Widget>[
          this.swiperWidget(),
          SizedBox(height: ScreenUtilAdapter.setWidth(20)),
          this.titleWidget(),
          SizedBox(height: ScreenUtilAdapter.setWidth(20)),
          this.MiddleImageList(),
          SizedBox(height: ScreenUtilAdapter.setWidth(20)),
          this.title2Widget(),
          SizedBox(height: ScreenUtilAdapter.setWidth(20)),
          RecommendItemWidget()
        ],
      ),
    );
  }
}
