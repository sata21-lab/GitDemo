import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jd_project/Widget/AddShopping.dart';
import 'package:jd_project/Widget/BuyNow.dart';
import 'package:jd_project/Widget/JdButton.dart';
import 'package:jd_project/config/config.dart';
import 'package:jd_project/provider/CarProvider.dart';
import 'package:jd_project/tools/CarService.dart';
import 'package:jd_project/tools/EventBus.dart';
import 'package:jd_project/tools/ProductContentModel.dart';
import 'package:jd_project/tools/ScreenAdapter.dart';
import 'package:provider/provider.dart';

class ProductContentFirst extends StatefulWidget {
  List _productContentList;

  ProductContentFirst(this._productContentList);

  @override
  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  ProductContentItem _productContent;
  List attr = [];
  String _selectedValue;
  var carProvider;
  showBottomDialog() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return GestureDetector(
            //解决showModalBottomSheet点击消失的问题
            onTap: () {
              return false;
            },
            child: Stack(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(ScreenUtilAdapter.setWidth(20)),
                    child: ListView(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "颜色：",
                                  style: TextStyle(
                                      fontSize: ScreenUtilAdapter.size(60),
                                      color: Colors.black),
                                ),
                                Container(
                                  child: Center(
                                    child: Text("蓝色"),
                                  ),
                                  margin: EdgeInsets.only(
                                      left: ScreenUtilAdapter.setWidth(20)),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(50)),
                                  height: ScreenUtilAdapter.setHeight(100),
                                  width: ScreenUtilAdapter.setWidth(200),
                                ),
                                Container(
                                  child: Center(
                                    child: Text("蓝色"),
                                  ),
                                  margin: EdgeInsets.only(
                                      left: ScreenUtilAdapter.setWidth(20)),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(50)),
                                  height: ScreenUtilAdapter.setHeight(100),
                                  width: ScreenUtilAdapter.setWidth(200),
                                ),
                                Container(
                                  child: Center(
                                    child: Text("蓝色"),
                                  ),
                                  margin: EdgeInsets.only(
                                      left: ScreenUtilAdapter.setWidth(20)),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(50)),
                                  height: ScreenUtilAdapter.setHeight(100),
                                  width: ScreenUtilAdapter.setWidth(200),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "尺寸：",
                                  style: TextStyle(
                                      fontSize: ScreenUtilAdapter.size(60),
                                      color: Colors.black),
                                ),
                                Container(
                                  child: Center(
                                    child: Text("X"),
                                  ),
                                  margin: EdgeInsets.only(
                                      left: ScreenUtilAdapter.setWidth(20)),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(50)),
                                  height: ScreenUtilAdapter.setHeight(100),
                                  width: ScreenUtilAdapter.setWidth(200),
                                ),
                                Container(
                                  child: Center(
                                    child: Text("XL"),
                                  ),
                                  margin: EdgeInsets.only(
                                      left: ScreenUtilAdapter.setWidth(20)),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(50)),
                                  height: ScreenUtilAdapter.setHeight(100),
                                  width: ScreenUtilAdapter.setWidth(200),
                                ),
                                Container(
                                  child: Center(
                                    child: Text("XXL"),
                                  ),
                                  margin: EdgeInsets.only(
                                      left: ScreenUtilAdapter.setWidth(20)),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(50)),
                                  height: ScreenUtilAdapter.setHeight(100),
                                  width: ScreenUtilAdapter.setWidth(200),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    )),
                Positioned(
                  bottom: 0,
                  width: ScreenUtilAdapter.setWidth(1080),
                  height: ScreenUtilAdapter.setHeight(150),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: JdButton(
                              cb: (){

                              },
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: JdButton(
                              cb: (){

                              },
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  //底部弹出框
  _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, setBottomState) {
              return GestureDetector(
                //解决showModalBottomSheet点击消失的问题
                onTap: () {
                  return false;
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(ScreenUtilAdapter.setWidth(40)),
                      child: ListView(
                          children: <Widget>[
                              Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: _getAttrWidget(setBottomState),
                              ),
                            Divider(),
                            Row(
                              children: <Widget>[
                                Text("数量:",style: TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(width: ScreenUtilAdapter.setWidth(80),),
                                NumItem(this._productContent)
                              ],
                            )
                          ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      width: ScreenUtilAdapter.setWidth(1080),
                      height: ScreenUtilAdapter.setHeight(150),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: JdButton(
                                  text: "加入购物车",
                                  color: Color.fromRGBO(253, 1, 0, 0.9),
                                  cb: ()async{
                                    await CartServices.addCart(this._productContent);
                                    this.carProvider.init();
                                    Navigator.of(context).pop();
                                    Fluttertoast.showToast(
                                        msg: "加入购物车成功!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIos: 1,
                                        backgroundColor: Colors.grey,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  },
                                )),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: JdButton(
                                    text: "立即购买",
                                    color: Color.fromRGBO(255, 165, 0, 0.9),
                                    cb: (){

                            },
                            )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  List<Widget> _getAttrItemWidget(attrItem, setBottomState) {
    List<Widget> attrItemList = [];
    attrItem.attrlist.forEach((item) {
      attrItemList.add(Container(
          margin: EdgeInsets.all(ScreenUtilAdapter.setHeight(20)),
          child: InkWell(
            onTap: () {
              changeAttr(attrItem.cate, item["title"], setBottomState);
            },
            child: Chip(
              label: Text("${item["title"]}"),
              backgroundColor: item["checked"] ? Colors.red : Colors.grey,
              padding: EdgeInsets.all(ScreenUtilAdapter.setHeight(20)),
            ),
          )));
    });
    return attrItemList;
  }

  //封装一个组件 渲染attr
  List<Widget> _getAttrWidget(setBottomState) {
    //左
    List<Widget> attrList = [];
    this.attr.forEach((attrItem) {
      attrList.add(Wrap(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: ScreenUtilAdapter.setHeight(50)),
              width: ScreenUtilAdapter.setWidth(200),
              child: Text("${attrItem.cate}: ",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Container(
            width: ScreenUtilAdapter.setWidth(690),
            child: Wrap(
              children: _getAttrItemWidget(attrItem, setBottomState),
            ),
          ),
        ],
      ),
      );
    });
    return attrList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._productContent = widget._productContentList[0];
    this.attr = this._productContent.attr;
    initAttr();
    eventBus.on<ProductContentEvent>().listen((event){
      print(event.text);
      this._attrBottomSheet();
    });
  }

  initAttr() {
    var attr = this.attr;
    for (var i = 0; i < attr.length; i++) {
      attr[i].attrlist.clear();
      for (var j = 0; j < attr[i].list.length; j++) {
        if (j == 0) {
          attr[i].attrlist.add({
            "title": attr[i].list[j],
            "checked": true,
          });
        } else {
          attr[i].attrlist.add({
            "title": attr[i].list[j],
            "checked": false,
          });
        }
      }
    }
    getSelectedAttrValue();
  }

  changeAttr(cate, title, setBottomState) {
    var attr = this.attr;
    for (var i = 0; i < attr.length; i++) {
      if (attr[i].cate == cate) {
        for (var j = 0; j < attr[i].attrlist.length; j++) {
          attr[i].attrlist[j]["checked"] = false;
          if (title == attr[i].attrlist[j]["title"]) {
            attr[i].attrlist[j]["checked"] = true;
          }
        }
      }
    }
    setBottomState(() {
      //注意  改变showModalBottomSheet里面的数据 来源于StatefulBuilder
      this.attr = attr;
    });
    getSelectedAttrValue();
  }
  getSelectedAttrValue() {
    var _list = this.attr;
    List tempArr = [];
    for (var i = 0; i < _list.length; i++) {
      for (var j = 0; j < _list[i].attrlist.length; j++) {
        if (_list[i].attrlist[j]['checked'] == true) {
          tempArr.add(_list[i].attrlist[j]["title"]);
        }
      }
    }
    print(tempArr.join(','));
    setState(() {
      this._selectedValue = tempArr.join(',');
      this._productContent.selectedAttr=this._selectedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    String pic = Config.domain + this._productContent.pic;
    pic = pic.replaceAll('\\', '/');
    this.carProvider=Provider.of<CarProvider>(context);
    return Container(
      padding: EdgeInsets.all(ScreenUtilAdapter.setWidth(50)),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 4 / 3,
            child: Image.network(
              "${pic}",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: ScreenUtilAdapter.setHeight(40)),
            child: Text("${this._productContent.title}",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: ScreenUtilAdapter.size(50))),
          ),
          Container(
              padding: EdgeInsets.only(top: ScreenUtilAdapter.setHeight(40)),
              child: Text("${this._productContent.subTitle}",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: ScreenUtilAdapter.size(28)))),
          //价格
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Text("特价: "),
                      Text("¥${this._productContent.price}",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: ScreenUtilAdapter.size(46))),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("原价: "),
                      Text("¥${this._productContent.oldPrice}",
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: ScreenUtilAdapter.size(28),
                              decoration: TextDecoration.lineThrough)),
                    ],
                  ),
                )
              ],
            ),
          ),
          //筛选
          Container(
              margin: EdgeInsets.only(top: 10),
              height: ScreenUtilAdapter.setHeight(80),
              child: InkWell(
                onTap: () {
                  _attrBottomSheet();
                },
                child: Row(
                  children: <Widget>[
                    Text("已选: ", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("${this._selectedValue}")
                  ],
                ),
              )),
          Divider(),
          Container(
            height: ScreenUtilAdapter.setHeight(80),
            child: Row(
              children: <Widget>[
                Text("运费: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("免运费")
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}


class NumItem extends StatefulWidget {
  var productContent;
  NumItem(this.productContent);
  @override
  _NumItemState createState() => _NumItemState(this.productContent);
}

class _NumItemState extends State<NumItem> {
  var productContent;
  _NumItemState(this.productContent);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtilAdapter.setHeight(80),
      width: ScreenUtilAdapter.setWidth(267),
      decoration:
      BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: (){
              setState(() {
                if(this.productContent.count>1){
                  this.productContent.count=this.productContent.count-1;
                }
              });
            },
            child: Container(
              alignment: Alignment.center,
              height: ScreenUtilAdapter.setWidth(80),
              width: ScreenUtilAdapter.setHeight(80),
              child: Text("-"),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(width: 1, color: Colors.black12),
                  right: BorderSide(width: 1, color: Colors.black12),
                )),
            alignment: Alignment.center,
            height: ScreenUtilAdapter.setWidth(80),
            width: ScreenUtilAdapter.setHeight(100),
            child: Text("${this.productContent.count}"),
          ),
          InkWell(
            onTap: (){
              setState(() {
                this.productContent.count=this.productContent.count+1;
              });
            },
            child: Container(
              alignment: Alignment.center,
              height: ScreenUtilAdapter.setWidth(80),
              width: ScreenUtilAdapter.setHeight(80),
              child: Text("+"),
            ),
          )
        ],
      ),
    );
  }
}
