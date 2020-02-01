import 'package:flutter/material.dart';
import 'package:jd_project/provider/UserProvider.dart';
import 'package:jd_project/provider/checkoutProider.dart';
import 'package:jd_project/tools/ScreenAdapter.dart';
import 'package:provider/provider.dart';
class Mine extends StatefulWidget {
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<Mine> {
  var UserInfoProvider;
  var CheckOutProvider;
  @override
  Widget build(BuildContext context) {
    this.UserInfoProvider=Provider.of<UsersProvider>(context);
    CheckOutProvider=Provider.of<ChecksOutProvider>(context);
    return ListView(
        children: <Widget>[
          Container(
            height: ScreenUtilAdapter.setHeight(320),
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/user_bg.jpg'), fit: BoxFit.cover)),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ClipOval(
                    child: Image.asset(
                      'images/user.jpg',
                      fit: BoxFit.cover,
                      width: ScreenUtilAdapter.setWidth(200),
                      height: ScreenUtilAdapter.setWidth(200),
                    ),
                  ),
                ),
                 this.UserInfoProvider.isLoginSuccess?Expanded(
                   flex: 1,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       Text("用户名：${this.UserInfoProvider.username}",
                           style: TextStyle(
                               color: Colors.white,
                               fontSize: ScreenUtilAdapter.size(50))),
                       Text("普通会员",
                           style: TextStyle(
                               color: Colors.white,
                               fontSize: ScreenUtilAdapter.size(50))),
                     ],
                   ),
                 ):Expanded(
                   flex: 1,
                   child: InkWell(
                     onTap: (){
                       Navigator.pushNamed(context, '/login');
                     },
                     child: Text("登录/注册",style: TextStyle(
                         color: Colors.white
                     )),
                   )
                 )
              ],
            ),
          ),
          ListTile(
            onTap: ()async{
              await CheckOutProvider.initDatabase();
              await CheckOutProvider.getCheckOutDataSQLite();
              Navigator.pushNamed(context, '/mycheckout');
            },
            leading: Icon(Icons.assignment, color: Colors.red),
            title: Text("全部订单"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment, color: Colors.green),
            title: Text("待付款"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_car_wash, color: Colors.orange),
            title: Text("待收货"),
          ),
          Container(
              width: double.infinity,
              height: 10,
              color: Color.fromRGBO(242, 242, 242, 0.9)),
          ListTile(
            leading: Icon(Icons.favorite, color: Colors.lightGreen),
            title: Text("我的收藏"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people, color: Colors.black54),
            title: Text("在线客服"),
          ),
          Divider(),
        ],
    );
  }
}
