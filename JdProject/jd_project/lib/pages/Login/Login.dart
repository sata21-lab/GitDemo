import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jd_project/Widget/JdButton.dart';
import 'package:jd_project/Widget/JdText.dart';
import 'package:jd_project/provider/UserProvider.dart';
import 'package:jd_project/tools/ScreenAdapter.dart';
import 'package:jd_project/tools/Storage.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username="";
  String password="";
  var UserInfoProvider;
  checkData(){
    if(username!=""&&password!=""){
      Future result=Storage.getString(username);
      result.then((value) async {
        if(value!=null){//存在数据
          if(value==password){//验证通过
            Fluttertoast.showToast(
                msg: "登陆成功!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 16.0
            );
            this.UserInfoProvider.isLogin=true;
            Navigator.pop(context);
          }
          else{
            Fluttertoast.showToast(
                msg: "用户名或密码错误",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        }
      });
    }
    else{
      Fluttertoast.showToast(
          msg: "用户名或密码不得为空!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  Future<bool> _requestPop() {
    int i=1;
    if(i==0){
      print("请求退出");
      return new Future.value(false);
    }
    else {
      print("退出");
      return new Future.value(true);
    }
  }
  @override
  Widget build(BuildContext context) {
    this.UserInfoProvider=Provider.of<UsersProvider>(context);
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomPadding:false,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text("登录"),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(ScreenUtilAdapter.setWidth(50)),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: ScreenUtilAdapter.setHeight(40)),
                  height: ScreenUtilAdapter.setHeight(300),
                  width: ScreenUtilAdapter.setWidth(300),
                  child: Image.asset("images/tap.jpg"),
                ),
                SizedBox(
                  height: ScreenUtilAdapter.setHeight(150),
                ),
                JdText(
                  text: "请输入用户名",
                  password: false,
                  onChanged: (value) {
                    this.username=value;
                  },
                ),
                SizedBox(
                  height: ScreenUtilAdapter.setHeight(100),
                ),
                JdText(
                  text: "请输入密码",
                  password: true,
                  onChanged: (value) {
                    this.password=value;
                  },
                ),
                SizedBox(
                  height: ScreenUtilAdapter.setHeight(40),
                ),
                Padding(
                  padding: EdgeInsets.only(left:ScreenUtilAdapter.setWidth(40),right: ScreenUtilAdapter.setWidth(20)),
                  child: Stack(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            child: Text("忘记密码",style: TextStyle(color: Colors.black26),),
                          )
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            child: Text("新用户注册",style: TextStyle(color: Colors.black26),),
                            onTap: (){
                              Navigator.pushNamed(context,'/register');
                            },
                          )
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtilAdapter.setHeight(100),
                ),
                JdButton(
                  cb: ()async{
                    //this.UserInfoProvider.setUserInfo(username,password);
                    //checkData();
                    await this.UserInfoProvider.initDatabase();
                    await this.UserInfoProvider.wantToLogin(username,password);
                    if(this.UserInfoProvider.isLoginSuccess){
                      Navigator.pop(context);
                    }
                  },
                  color: Colors.red,
                  text: "登录",
                )
              ],
            ),
          ),
        ),
      ),
      onWillPop: _requestPop
    );
  }
}
