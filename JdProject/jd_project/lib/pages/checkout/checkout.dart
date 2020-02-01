import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jd_project/provider/CarProvider.dart';
import 'package:jd_project/provider/UserProvider.dart';
import 'package:jd_project/provider/checkoutProider.dart';
import 'package:jd_project/tools/ScreenAdapter.dart';
import 'package:jd_project/tools/getMyGlobals.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> with WidgetsBindingObserver{
  MyGlobals myGlobals;
  Widget checkOutItem(item) {
    return Row(
      children: <Widget>[
        Container(
          width: ScreenUtilAdapter.setWidth(160),
          child: Image.network(
              "${item["pic"]}",
              fit: BoxFit.cover),
        ),
        Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${item["title"]}", maxLines: 2),
                  Text("${item["selectedAttr"]}", maxLines: 2),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child:
                        Text("￥${item["price"]}",
                            style: TextStyle(color: Colors.red)),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text("x${item["count"]}"),
                      )
                    ],
                  )
                ],
              ),
            ))
      ],
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myGlobals = new MyGlobals();
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if(state==AppLifecycleState.resumed){
      Navigator.pop(myGlobals.scaffoldKey.currentContext);
      Fluttertoast.showToast(
          msg: "付款成功！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  @override
  Widget build(BuildContext context) {

    launchURL() async {
      const url = 'alipays:// ';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    var carProvider=Provider.of<CarProvider>(context);
    var checkOutProvider = Provider.of<ChecksOutProvider>(context);
    var UserInfoProvider=Provider.of<UsersProvider>(context);
    return Scaffold(
      key: myGlobals.scaffoldKey,
      appBar: AppBar(
        title: Text("结算"),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                     ListTile(
                       onTap: (){
                         Navigator.pushNamed(context, '/addresslist');
                       },
                       leading: Icon(Icons.add_location),
                       title: Center(
                         child: UserInfoProvider.userAddress.length>0?Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: <Widget>[
                             Text("${UserInfoProvider.shouhuoname}   ${UserInfoProvider.shouhuophone}"),
                             SizedBox(
                               height: ScreenUtilAdapter.setHeight(30),
                             ),
                             Text("${UserInfoProvider.shouhuoaddress}")
                           ],
                         ):Text("请设置收货地址")
                       ),
                       trailing: Icon(Icons.navigate_next),
                     ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(ScreenUtilAdapter.setWidth(20)),
                child: Column(
                    children: checkOutProvider.checkOutListData.map((value){
                      return Column(
                        children: <Widget>[
                          checkOutItem(value),
                          Divider()
                        ],
                      );
                    }).toList()
                ),
              ),
              SizedBox(height: 20),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(ScreenUtilAdapter.setWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("商品总金额:${carProvider.allPrice}"),
                    Divider(),
                    Text("运费:￥0"),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            width: ScreenUtilAdapter.setWidth(1080),
            height: ScreenUtilAdapter.setHeight(150),
            child: Container(
              padding: EdgeInsets.all(5),
              width: ScreenUtilAdapter.setWidth(1080),
              height: ScreenUtilAdapter.setHeight(150),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(
                          width: 1,
                          color: Colors.black26
                      )
                  )
              ),

              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("总价:${carProvider.allPrice}", style: TextStyle(color: Colors.red)),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RaisedButton(
                      child:
                      Text('立即下单', style: TextStyle(color: Colors.white)),
                      color: Colors.red,
                      onPressed: ()async{
                        if(UserInfoProvider.userAddress.length>0){
                          await checkOutProvider.initDatabase();
                          await checkOutProvider.setCheckOutDatatoSQLite(UserInfoProvider.shouhuoname,UserInfoProvider.shouhuophone,
                              UserInfoProvider.shouhuoaddress,carProvider.allPrice,UserInfoProvider.username);
                          //await launchURL();
                        }
                        else{
                          Fluttertoast.showToast(
                              msg: "请选择收货地址！",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                        //await launchURL();
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}
