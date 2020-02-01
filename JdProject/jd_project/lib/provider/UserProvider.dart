

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jd_project/tools/Storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
class UsersProvider with ChangeNotifier{
  bool isLoginSuccess=false;
  bool isRegisterSuccess=false;
  String username="";
  List userInfo=[{"用户名":"测试","密码":"测试","收货地址":"北京市"}];
  List userAddress=[];
  String shouhuoname="";
  String shouhuophone="";
  String shouhuoaddress="";
  /*setUserInfo(username,password,{String address})async{
    /*await Storage.setString(username,password);
    this.username=username;
    notifyListeners();*/
    /*Map temp={"用户名":username,"密码":password,"收货地址":"北京市"};
    for (int i = 0; i < userInfo.length; i++) {
      if (userInfo[i]["用户名"] == username){
        Fluttertoast.showToast(
            msg: "用户名已存在",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0
        );
        userInfo.remove(temp);
        print(userInfo.length);
      }
      else {
        Fluttertoast.showToast(
            msg: "注册成功!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0
        );
        print(userInfo.length);
        await Storage.setString("user", json.encode(userInfo));
      }
    }*/
    isRegisterSuccess=false;
    Map temp={"用户名":username,"密码":password,"收货地址":"北京市"};
    bool result=userInfo.any((value){
      return value["用户名"]==username;
    });
    if(result){
      Fluttertoast.showToast(
          msg: "注册失败!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else{
      userInfo.add(temp);
      isRegisterSuccess=true;
      Fluttertoast.showToast(
          msg: "注册成功!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
      await Storage.setString("user", json.encode(userInfo));
    }
  }
  getUserInfo(username,password)async{
    isLoginSuccess=false;
    List temp = json.decode(await Storage.getString("user"));
    bool result=temp.any((value){
      return value["用户名"]==username&&value["密码"]==password;
    });
    if(result){
      Fluttertoast.showToast(
          msg: "登录成功!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
      this.username=username;
      isLoginSuccess=true;
    }
    else{
      userInfo.add(temp);
      Fluttertoast.showToast(
          msg: "登录失败!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
  setUserAddress(String username,Map addressList)async{
    List temp = json.decode(await Storage.getString("user"));
    bool result=temp.any((value){
      if(value["用户名"]==username){
        value["收货地址"]=addressList;
      }
      return true;
    });
    print(temp[1]);
  }*/
  Database database;
  initDatabase()async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'user.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE User (username TEXT PRIMARY KEY, password TEXT)');
          await db.execute(
              'CREATE TABLE Address (id INTEGER PRIMARY KEY,username TEXT,shouhuoname TEXT,shouhuophone TEXT,useraddress TEXT)');
          await db.execute(
              'CREATE TABLE CheckList (Checkid INTEGER PRIMARY KEY,'
                  ' detail TEXT, shouhuoname TEXT,shouhuophone TEXT,shouhuoAddress TEXT,allPrice TEXT,username TEXT)');
        });
  }
  wantToRegister(String username,String password)async{
    List<Map>  list = await database.rawQuery('SELECT * FROM User where username=$username');
    if(list.length!=0){
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
      await database.transaction((txn) async {
        try {
          int result = await txn.rawInsert(
              'INSERT INTO User(username,password) VALUES("$username", "$password")');
          if(result==1){
            Fluttertoast.showToast(
                msg: "注册成功！",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 16.0
            );

          }
        }
        catch(e){
          print(e);
        }
      });
    }
  }
  wantToLogin(String username,String password)async{
    isLoginSuccess=false;
    List<Map>  list = await database.rawQuery('SELECT * FROM User where username=$username and password=$password');
    if(list.length==1){
      this.username=username;
      isLoginSuccess=true;
      Fluttertoast.showToast(
          msg: "登录成功!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
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
  wantToGetAddress(username)async{
    List<Map>  list = await database.rawQuery('SELECT * FROM Address where username=$username');
    //print(list[0]);
    this.userAddress=list;
    notifyListeners();
  }
  wantToSetAddress(username,shouhuoname,shouhuophone,useraddress)async{
    await database.transaction((txn) async {
      try {
        await txn.rawInsert(
            'INSERT INTO Address(username,shouhuoname,shouhuophone,useraddress) '
                'VALUES("$username", "$shouhuoname","$shouhuophone","$useraddress")');
      }
      catch(e){
        print(e);
      }
    });
  }
  wantToDeleteAddress(index)async{
    /*int num=Sqflite.firstIntValue(await database.rawQuery('SELECT COUNT(*) FROM Address'));//获取总行数
    print(num);*/
    //print(index);
    List list=await database.rawQuery("select id from Address limit $index,1");
    print(list[0]["id"]);
    await database.rawDelete("delete from Address where id=?",[list[0]["id"]]);
  }
  getTempAddress(index)async{
    List list=await database.rawQuery("select id from Address limit $index,1");
    //print(list[0]["id"]);
    List detail=await database.rawQuery("select * from Address where id=${list[0]["id"]}");
    print(detail[0]["shouhuoname"]);
    this.shouhuoname=detail[0]["shouhuoname"];
    this.shouhuophone=detail[0]["shouhuophone"];
    this.shouhuoaddress=detail[0]["useraddress"];
    notifyListeners();
  }
}