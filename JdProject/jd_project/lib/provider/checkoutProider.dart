import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class ChecksOutProvider with ChangeNotifier {
  List _checkOutListData = []; //购物车数据
  List get checkOutListData => this._checkOutListData;
  List CheckList=[];
  List CheckDetailList=[];
  List AllCheckDetailList=[];
  List AllCheckList=[];
  int Checkid=0;
  changeCheckOutListData(data){
    this._checkOutListData=data;
    notifyListeners();
  }

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
  setCheckOutDatatoSQLite(shouhuoname,shouhuophone,shouhuoAddress,allPrice,username) async {
    String before = json.encode(this._checkOutListData).toString();
    //print("替换前：$before");
    String after=before.replaceAll('\"','\'');
    //print("替换后：$after");
    await database.transaction((txn) async {
      try {
        await txn.rawInsert(
            'INSERT INTO CheckList(detail,shouhuoname,shouhuophone,shouhuoAddress,allPrice,username)'
                ' VALUES("$after","$shouhuoname","$shouhuophone","$shouhuoAddress","$allPrice","$username")');
      }
      catch (e) {
        print(e);
      }
    });
  }
  getCheckOutDataSQLite()async{
    CheckList=[];
    List list=await database.rawQuery("select * from CheckList");
    CheckList=list;
    //print(CheckList.length);
    /*String after=list.toString().replaceAll('\'', '\"');
    CheckList.add(after);
    print(CheckList.length);*/
    //print(CheckList);
  }
  getMyCheckOutDetailData(index){
    String after=CheckList[index]["detail"].replaceAll('\'', '\"');
    CheckDetailList=json.decode(after);
    print(CheckDetailList[0]);
    return CheckDetailList[0]["title"];
  }
  getMyCheckOutDetailImage(index){
    String after=CheckList[index]["detail"].replaceAll('\'', '\"');
    CheckDetailList=json.decode(after);
    print("长度${CheckDetailList.length}");
    return CheckDetailList[0]["pic"];
  }
  getAllCheckOutDetail(id)async{
    AllCheckList=[];
    AllCheckDetailList=[];
    List list=await database.rawQuery("select * from CheckList where Checkid=$id");
    AllCheckList=list;
    String after=list[0]["detail"].replaceAll('\'', '\"');
    AllCheckDetailList=json.decode(after);
    print(AllCheckDetailList);
  }
}
