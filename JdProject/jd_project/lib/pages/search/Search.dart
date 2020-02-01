import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_project/provider/UserProvider.dart';
import 'package:jd_project/tools/ScreenAdapter.dart';
import 'package:jd_project/tools/SearchServices.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  Map arguments;

  Search({Key key, this.arguments}) : super(key: key);

  @override
  _SearchState createState() => _SearchState(arguments: this.arguments);
}

class _SearchState extends State<Search> {
  Map arguments;

  _SearchState({this.arguments});

  var keywords;
  List _historyListData = [];

  @override
  void initState() {
    super.initState();
    this._getHistoryData();
  }

  _getHistoryData() async {
    var _historyListData = await SearchServices.getHistoryList();
    setState(() {
      this._historyListData = _historyListData;
    });
  }

  _showAlertDialog(keywords) async {
    var result = await showDialog(
        barrierDismissible: false, //表示点击灰色背景的时候是否消失弹出框
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示信息!"),
            content: Text("您确定要删除吗?"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () {
                  print("取消");
                  Navigator.pop(context, 'Cancle');
                },
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () async {
                  //注意异步
                  await SearchServices.removeHistoryData(keywords);
                  this._getHistoryData();
                  Navigator.pop(context, "Ok");
                },
              )
            ],
          );
        });

    //  print(result);
  }

  Widget History() {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Align(
              child: Text(
                "历史记录",
                style: TextStyle(fontSize: ScreenUtilAdapter.size(60)),
                textAlign: TextAlign.left,
              ),
              alignment: Alignment.topLeft,
            )
          ],
        ),
        Column(
          children: this._historyListData.map((value) {
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text("${value}"),
                  onLongPress: (){
                    this._showAlertDialog("${value}");
                  },
                ),
                Divider()
              ],
            );
          }).toList(),
        ),
        Container(
          child: RaisedButton(
            onPressed: () {
              SearchServices.clearHistoryList();
              this._getHistoryData();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Icon(Icons.delete), Text("删除历史记录")],
            ),
          ),
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false, //解决键盘弹出问题
        appBar: AppBar(
          title: Container(
            padding: EdgeInsets.all(ScreenUtilAdapter.setHeight(15)),
            child: TextField(
              autofocus: true,
              onChanged: (value) {
                this.keywords = value;
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
                SearchServices.setHistoryData(this.keywords);
                Navigator.pushReplacementNamed(context, '/product',
                    arguments: {"keywords": keywords});
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(ScreenUtilAdapter.size(40)),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Align(
                    child: Text(
                      "热搜",
                      style: TextStyle(fontSize: ScreenUtilAdapter.size(60)),
                      textAlign: TextAlign.left,
                    ),
                    alignment: Alignment.topLeft,
                  )
                ],
              ),
              Divider(),
              Wrap(
                runSpacing: 10.0,
                spacing: 10.0,
                children: <Widget>[
                  Container(
                    height: ScreenUtilAdapter.setHeight(100),
                    width: ScreenUtilAdapter.setWidth(200),
                    child: RaisedButton(
                      onPressed: () {},
                      color: Color.fromRGBO(233, 233, 233, 0.8),
                      child: Text("测试"),
                    ),
                  ),
                  Container(
                    height: ScreenUtilAdapter.setHeight(100),
                    width: ScreenUtilAdapter.setWidth(200),
                    child: RaisedButton(
                      onPressed: () {},
                      color: Color.fromRGBO(233, 233, 233, 0.8),
                      child: Text("测试"),
                    ),
                  ),
                  Container(
                    height: ScreenUtilAdapter.setHeight(100),
                    width: ScreenUtilAdapter.setWidth(200),
                    child: RaisedButton(
                      onPressed: () {},
                      color: Color.fromRGBO(233, 233, 233, 0.8),
                      child: Text("测试"),
                    ),
                  ),
                  Container(
                    height: ScreenUtilAdapter.setHeight(100),
                    width: ScreenUtilAdapter.setWidth(200),
                    child: RaisedButton(
                      onPressed: () {},
                      color: Color.fromRGBO(233, 233, 233, 0.8),
                      child: Text("测试"),
                    ),
                  ),
                  Container(
                    height: ScreenUtilAdapter.setHeight(100),
                    width: ScreenUtilAdapter.setWidth(200),
                    child: RaisedButton(
                      onPressed: () {},
                      color: Color.fromRGBO(233, 233, 233, 0.8),
                      child: Text("测试"),
                    ),
                  ),
                ],
              ),
              Divider(),
              this._historyListData.length>0?History():Text("")
            ],
          ),
        ));
  }
}
