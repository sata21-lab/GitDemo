import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jd_project/provider/CarProvider.dart';
import 'package:jd_project/provider/UserProvider.dart';
import 'package:jd_project/provider/checkoutProider.dart';
import 'package:jd_project/tools/CarService.dart';
import 'package:jd_project/tools/ScreenAdapter.dart';
import 'package:provider/provider.dart';

class CarItem extends StatefulWidget {
  Map itemData;
  CarItem(this.itemData);
  @override
  _CarItemState createState() => _CarItemState();
}

class _CarItemState extends State<CarItem> {
  Map itemData;
  var carProvider;
  @override
  Widget build(BuildContext context) {
    this.itemData=widget.itemData;
    this.carProvider=Provider.of<CarProvider>(context);
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: 2))),
      height: ScreenUtilAdapter.setHeight(320),
      child: Row(
        children: <Widget>[
          Container(
            height: ScreenUtilAdapter.setWidth(60),
            child: Checkbox(
              value: itemData["checked"],
              onChanged: (value) {
                setState(() {
                  itemData["checked"]=!itemData["checked"];
                });
                this.carProvider.itemChange();
              },
              activeColor: Colors.red,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenUtilAdapter.setWidth(20)),
            child: Container(
              child: Image.network("${itemData["pic"]}",fit: BoxFit.cover,)
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(ScreenUtilAdapter.setWidth(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${this.itemData["title"]}",
                      maxLines: 2,
                    ),
                    Text(
                      "${this.itemData["selectedAttr"]}",
                      maxLines: 2,
                    ),
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "￥${this.itemData["price"]}",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: NumItem(itemData),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class NumItem extends StatefulWidget {
  Map itemData;
  NumItem(this.itemData);
  @override
  _NumItemState createState() => _NumItemState();
}

class _NumItemState extends State<NumItem> {
  Map itemData;
  var carProvider;
  @override
  Widget build(BuildContext context) {
    this.itemData=widget.itemData;
    this.carProvider=Provider.of<CarProvider>(context);
    return Container(
      height: ScreenUtilAdapter.setHeight(80),
      width: ScreenUtilAdapter.setWidth(267),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: (){
              if(itemData["count"]>1){
                setState(() {
                  itemData["count"]--;
                });
              }
              this.carProvider.changeItemCount();
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
            child: Text("${this.itemData["count"]}"),
          ),
          InkWell(
            onTap: (){
              setState(() {
                itemData["count"]++;
              });
              this.carProvider.changeItemCount();
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

class Shopping_Car extends StatefulWidget {
  @override
  _Shopping_CarState createState() => _Shopping_CarState();
}

class _Shopping_CarState extends State<Shopping_Car> {
  bool isEdit=false;
  var checkOutProvider;
  var UserInfoProvider;
  doCheckOut() async {
    //1、获取购物车选中的数据
    List checkOutData = await CartServices.getCheckOutData();
    //2、保存购物车选中的数据
    this.checkOutProvider.changeCheckOutListData(checkOutData);
    //3、购物车有没有选中的数据
    if (checkOutData.length < 0) {
      Fluttertoast.showToast(
        msg: '购物车没有选中的数据',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    else{
      Navigator.pushNamed(context, '/checkout');
    }
  }
  @override
  Widget build(BuildContext context) {
    var carProvider=Provider.of<CarProvider>(context);
    checkOutProvider = Provider.of<ChecksOutProvider>(context);
    this.UserInfoProvider=Provider.of<UsersProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("购物车"),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.all(ScreenUtilAdapter.setWidth(25)),
              child:  Center(
                  child: IconButton(icon: Icon(Icons.edit), onPressed: (){
                    setState(() {
                      isEdit=!isEdit;
                    });
                  })
              ),
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            ListView(
              children: carProvider.carList.map((value){
                return CarItem(value);
              }).toList(),
            ),
            Positioned(
              bottom: 0,
              width: ScreenUtilAdapter.setWidth(1080),
              height: ScreenUtilAdapter.setHeight(150),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: 1,
                          color: Colors.black12
                      )
                  ),
                  color: Colors.white,
                ),
                width: ScreenUtilAdapter.setWidth(1080),
                height: ScreenUtilAdapter.setHeight(150),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: carProvider.isCheckedAll,
                            activeColor: Colors.pink,
                            onChanged: (value) {
                              carProvider.checkAll(value);
                            },
                          ),
                          Text("全选"),
                          SizedBox(width: ScreenUtilAdapter.setWidth(50),),
                          this.isEdit==false?Text("合计："):Text(""),
                          this.isEdit==false?Text("${carProvider.allPrice}",style: TextStyle(fontSize: ScreenUtilAdapter.size(55),color: Colors.red),):Text("")
                        ],
                      ),
                    ),
                    isEdit==true?Align(
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                        child: Text("删除",style: TextStyle(
                            color: Colors.white
                        )),
                        color:Colors.red,
                        onPressed: (){
                          carProvider.deleteData();
                        },
                      ),
                    ):Align(
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                        child: Text("结算",style: TextStyle(
                            color: Colors.white
                        )),
                        color:Colors.red,
                        onPressed: (){
                          if(this.UserInfoProvider.username==""){
                            Fluttertoast.showToast(
                                msg: "请先登录！",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }
                          else {
                            doCheckOut();
                          }
                          //Navigator.pushNamed(context, '/checkout');
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
