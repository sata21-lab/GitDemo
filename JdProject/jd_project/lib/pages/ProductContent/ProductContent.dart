import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jd_project/Widget/JdButton.dart';
import 'package:jd_project/config/config.dart';
import 'package:jd_project/pages/ProductContent/ProductContentFirst.dart';
import 'package:jd_project/pages/ProductContent/ProductContentThird.dart';
import 'package:jd_project/pages/ProductContent/ProductContentTwo.dart';
import 'package:jd_project/provider/CarProvider.dart';
import 'package:jd_project/tools/CarService.dart';
import 'package:jd_project/tools/EventBus.dart';
import 'package:jd_project/tools/ProductContentModel.dart';
import 'package:jd_project/tools/ScreenAdapter.dart';
import 'package:provider/provider.dart';

class ProductContentPage extends StatefulWidget {
  Map arguments;

  ProductContentPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductContentPageState createState() =>
      _ProductContentPageState(arguments: this.arguments);
}

class _ProductContentPageState extends State<ProductContentPage> {
  Map arguments;
  List _productContentList=[];
  var carProvider;
  _ProductContentPageState({this.arguments});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
  }
  getData()async{
    var api="${Config.domain}api/pcontent?id=${arguments["id"]}";
    print(api);
    var result = await Dio().get(api);
    var data=ProductContentModel.fromJson(result.data);
    setState(() {
      this._productContentList.add(data.result);
    });
  }
  @override
  Widget build(BuildContext context) {
    this.carProvider=Provider.of<CarProvider>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: TabBar(
                indicatorColor: Colors.red,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: <Widget>[
                  Tab(
                    child: Text("商品"),
                  ),
                  Tab(
                    child: Text("详情"),
                  ),
                  Tab(
                    child: Text("评价"),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                child: IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {
                    showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(
                            ScreenUtilAdapter.setWidth(600),
                            ScreenUtilAdapter.setWidth(200),
                            ScreenUtilAdapter.setWidth(10),
                            ScreenUtilAdapter.setWidth(0)),
                        items: [
                          PopupMenuItem(
                            child: Text("测试"),
                          ),
                          PopupMenuItem(
                            child: Text("测试"),
                          )
                        ]);
                  },
                ),
                padding: EdgeInsets.only(right: ScreenUtilAdapter.setWidth(40)),
              )
            ],
          ),
          body: this._productContentList.length>0?Stack(
            children: <Widget>[
              TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  ProductContentFirst(this._productContentList),
                  ProductContentTwo(this._productContentList),
                  ProductContentThird(this._productContentList),
                ],
              ),
              Positioned(
                bottom: 0,
                height: ScreenUtilAdapter.setHeight(180),
                width: ScreenUtilAdapter.setWidth(1080),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          top: BorderSide(color: Colors.black26, width: 1))),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          padding:EdgeInsets.all(ScreenUtilAdapter.setHeight(20)),
                          height: ScreenUtilAdapter.setHeight(250),
                          width: ScreenUtilAdapter.setWidth(280),
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.shopping_cart),
                              Text("购物车")
                            ],
                          ),
                        ),
                        onTap: (){
                          Navigator.pushReplacementNamed(context,'/cart');
                        },
                      ),
                      Expanded(
                          flex: 1,
                          child:JdButton(
                            text: "加入购物车",
                            color: Color.fromRGBO(253, 1, 0, 0.9),
                            cb: ()async{
                              if(this._productContentList[0].attr.length>0){
                                eventBus.fire(ProductContentEvent(""));
                              }
                              else {
                                await CartServices.addCart(this._productContentList[0]);
                                carProvider.init();
                                Fluttertoast.showToast(
                                    msg: "加入购物车成功!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIos: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }
                            },
                          )),
                      Expanded(
                          flex: 1,
                          child: JdButton(
                            text: "立即购买",
                            color: Color.fromRGBO(255, 165, 0, 0.9),
                            cb: (){

                            },
                          )),
                    ],
                  ),
                ),
              )
            ],
          ):Text("加载中")),
    );
  }
}
