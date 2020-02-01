import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jd_project/config/config.dart';
import 'package:jd_project/tools/RecommendModel.dart';
import 'package:jd_project/tools/ScreenAdapter.dart';
import 'package:jd_project/tools/SmartDrawer.dart';

class ProductList extends StatefulWidget {
  Map arguments;

  ProductList({Key key, this.arguments}) : super(key: key);

  @override
  _ProductListState createState() =>
      _ProductListState(arguments: this.arguments);
}

class _ProductListState extends State<ProductList> {
  List ProductListData = [];
  var initKeyWordsController = new TextEditingController();
  String keywords;
  Map arguments;
  bool hasData = true;
  int page = 1;
  String sort = "";
  bool flag = true;
  int selectIndex = 1;
  List _subHeaderList = [
    {
      "id": 1,
      "title": "综合",
      "fileds": "all",
      "sort":
          -1, //排序     升序：price_1     {price:1}        降序：price_-1   {price:-1}
    },
    {"id": 2, "title": "销量", "fileds": 'salecount', "sort": -1},
    {"id": 3, "title": "价格", "fileds": 'price', "sort": -1},
    {"id": 4, "title": "筛选"}
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController scrollController = new ScrollController();

  _ProductListState({this.arguments});

  Widget PeoductItemList() {
    if (this.ProductListData.length > 0) {
      return Container(
        margin: EdgeInsets.only(top: ScreenUtilAdapter.setHeight(160)),
        padding: EdgeInsets.all(ScreenUtilAdapter.setHeight(30)),
        child: ListView.builder(
          controller: scrollController,
          itemCount: ProductListData.length,
          itemBuilder: (context, index) {
            String sPic = this.ProductListData[index].pic;
            sPic = Config.domain + sPic.replaceAll('\\', '/');
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: ScreenUtilAdapter.setWidth(200),
                      width: ScreenUtilAdapter.setWidth(200),
                      child: Image.network(sPic),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(
                              left: ScreenUtilAdapter.setHeight(30)),
                          height: ScreenUtilAdapter.setWidth(200),
                          child: Stack(
                            children: <Widget>[
                              Align(
                                child: Text(
                                  this.ProductListData[index].title,
                                  style: TextStyle(
                                      fontSize: ScreenUtilAdapter.size(40)),
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              Align(
                                child: Text(
                                  "￥${this.ProductListData[index].price}",
                                  style: TextStyle(color: Colors.red),
                                ),
                                alignment: Alignment.bottomLeft,
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
                Divider(
                  height: 5,
                ),
                (index == this.ProductListData.length - 1)
                    ? Text("加载中")
                    : Text("")
              ],
            );
          },
        ),
      );
    } else {
      return Text("加载中");
    }
  }

  Widget showIcons(id, sort) {
    if (id == 3 || id == 2) {
      if (sort == 1) {
        return Icon(Icons.arrow_drop_down);
      } else {
        return Icon(Icons.arrow_drop_up);
      }
    } else {
      return Text("");
    }
  }

  Widget HeadTitle() {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
          height: ScreenUtilAdapter.setHeight(150),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: this._subHeaderList.map((value) {
              return Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectIndex = value["id"];
                      this.sort =
                          "${this._subHeaderList[value["id"] - 1]["fileds"]}_${this._subHeaderList[value["id"] - 1]["sort"]}";
                      print("${this._subHeaderList[value["id"] - 1]["sort"]}");
                      this.page = 1;
                      this.ProductListData = [];
                      this._subHeaderList[value["id"] - 1]["sort"] =
                          this._subHeaderList[value["id"] - 1]["sort"] * -1;
                      getProductListData();
                      scrollController.jumpTo(0);
                    });
                  },
                  child: Padding(
                      padding: EdgeInsets.all(ScreenUtilAdapter.setHeight(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            value["title"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: (this.selectIndex == value["id"]
                                    ? Colors.red
                                    : Colors.black)),
                          ),
                          showIcons(value["id"],
                              this._subHeaderList[value["id"] - 1]["sort"]),
                        ],
                      )),
                ),
              );
            }).toList(),
          ),
        ));
  }

  Widget SmartDrawer() {
    return SmartDrawerWidget(
      widthPercent: 0.6,
      child: Text("测试"),
      key: _scaffoldKey,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    arguments["keywords"] == null
        ? this.initKeyWordsController.text = ""
        : this.initKeyWordsController.text = arguments["keywords"];
    getProductListData();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (flag) {
          getProductListData();
        }
      }
    });
  }

  void getProductListData({String keywords}) async {
    var api;
    setState(() {
      flag = false;
    });

    try {
//      if (arguments["keywords"] == null){//分类跳转hasData初试true
//        api =
//            "${Config.domain}api/plist?cid=${arguments["cid"]}&page=${this.page}&sort=${this.sort}";
//      } else {//搜索跳转
//        api =
//            "${Config.domain}api/plist?search=${this.initKeyWordsController.text}&page=${this.page}&sort=${this.sort}";
//      }
      if(keywords!=null){
        api =
        "${Config.domain}api/plist?search=${this.initKeyWordsController.text}&page=${this.page}&sort=${this.sort}";
      }
      else {
        if (arguments["keywords"] == null) {
          api =
          "${Config.domain}api/plist?cid=${arguments["cid"]}&page=${this
              .page}&sort=${this.sort}";
        } else {
          //搜索跳转
          api =
          "${Config.domain}api/plist?search=${this.initKeyWordsController
              .text}&page=${this.page}&sort=${this.sort}";
        }
      }
      //print(api);
      var result = await Dio().get(api);
      var DataList = RecommendModel.fromJson(result.data);
      setState(() {
        this.ProductListData.addAll(DataList.result);
        page++;
        flag = true;
      });
    } catch (e) {
      print(e);
    }
    if (ProductListData.length == 0) {
      setState(() {
        this.hasData = false;
      });
    } else {
      setState(() {
        this.hasData = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: this._scaffoldKey,
        appBar: AppBar(
          title: Container(
            padding: EdgeInsets.all(ScreenUtilAdapter.setWidth(15)),
            child: TextField(
              controller: this.initKeyWordsController,
              autofocus: false,
              onChanged: (value) {
                setState(() {
                  this.keywords = value;
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none)),
            ),
            height: ScreenUtilAdapter.setHeight(100),
            decoration: BoxDecoration(
                color: Color.fromRGBO(233, 233, 233, 0.8),
                borderRadius: BorderRadius.circular(30)),
          ),
          actions: <Widget>[
            InkWell(
              child: Container(
                height: ScreenUtilAdapter.setHeight(68),
                width: ScreenUtilAdapter.setWidth(160),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Text("搜索")],
                ),
              ),
              onTap: () {
                setState(() {
                  this.ProductListData = []; //不清空列表将会叠加数据
                  this.page = 1;
                  getProductListData(keywords: keywords);
                });
                //print(this.initKeyWordsController.text);
              },
            )
          ],
        ),
        endDrawer: Drawer(child: Text("测试")),
        body: hasData
            ? Stack(
                children: <Widget>[PeoductItemList(), HeadTitle()],
              )
            : Center(
                child: Text("没有数据"),
              ));
  }
}

/*class ProductMain extends StatefulWidget {
  @override
  _ProductMainState createState() => _ProductMainState();
}

class _ProductMainState extends State<ProductMain> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductList(),
      theme: ThemeData(
        primaryColor: Colors.yellow
      ),
    );
  }
}*/
