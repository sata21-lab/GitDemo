
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jd_project/Widget/JdButton.dart';
import 'package:jd_project/Widget/JdText.dart';
import 'package:jd_project/main.dart';
import 'package:jd_project/provider/UserProvider.dart';
import 'package:jd_project/tools/ScreenAdapter.dart';
import 'package:jd_project/tools/SqliteTools.dart';
import 'package:jd_project/tools/Storage.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String username="";
  String password="";
  var UserInfoProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  checkData(){
    if(username!=""&&password!=""){
      Future result=Storage.getString(username);
      result.then((value) async {
        if(value!=null){//存在数据
          Fluttertoast.showToast(
              msg: "用户名已存在！",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        else{

          await Storage.setString(username, password);
          Fluttertoast.showToast(
              msg: "注册成功！",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(builder: (context) => new MainHome()),
                  (route) => route == null);
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
  @override
  Widget build(BuildContext context) {
    this.UserInfoProvider=Provider.of<UsersProvider>(context);
    return Scaffold(
      resizeToAvoidBottomPadding:false,
      appBar: AppBar(
        title: Text("注册"),
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
                TextEditingController: null,
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
                TextEditingController:null,
                text: "请输入密码",
                password: true,
                onChanged: (value) {
                  this.password=value;
                },
              ),
              SizedBox(
                height: ScreenUtilAdapter.setHeight(40),
              ),
              SizedBox(
                height: ScreenUtilAdapter.setHeight(100),
              ),
              JdButton(
                cb: ()async{
                  await this.UserInfoProvider.initDatabase();
                  await this.UserInfoProvider.wantToRegister(username,password);
                  /*await this.UserInfoProvider.initDatabase();
                  await this.UserInfoProvider.wantToSetAddress("111");*/
                },
                color: Colors.red,
                text: "注册",
              ),
              SizedBox(height: 20,),
              JdButton(
                cb: ()async{
                  await this.UserInfoProvider.initDatabase();
                  await this.UserInfoProvider.wantToGetAddress("111");
                },
                color: Colors.red,
                text: "查询",
              )
            ],
          ),
        ),
      ),
    );
  }
}
