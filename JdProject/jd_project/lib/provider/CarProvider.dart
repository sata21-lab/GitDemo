import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:jd_project/tools/Storage.dart';

class CarProvider extends ChangeNotifier {
  List carList = [];
  bool isCheckedAll = false;
  double allPrice = 0;

  List getCarList() {
    return this.carList;
  }

  bool getisCheckedAll() {
    return this.isCheckedAll;
  }

  double getAllPrice() {
    return this.allPrice;
  }

  CarProvider() {
    this.init();
  }

  init() async {
    try {
      List carListData = json.decode(await Storage.getString("cartList"));
      this.carList = carListData;
    }
    catch (e) {
      this.carList = [];
    }
    this.isCheckedAll = this.isCheckAll();
    computerAllPrice();
    notifyListeners();
  }

  changeItemCount() async {
    await Storage.setString("cartList", json.encode(this.carList));
    computerAllPrice();
    notifyListeners();
  }

  //全选 反选
  checkAll(value) async {
    for (var i = 0; i < this.carList.length; i++) {
      this.carList[i]["checked"] = value;
    }
    this.isCheckedAll = value;
    computerAllPrice();
    await Storage.setString("cartList", json.encode(this.carList));
    notifyListeners();
  }

  //判断是否全选
  bool isCheckAll() {
    if (this.carList.length > 0) {
      for (var i = 0; i < this.carList.length; i++) {
        if (this.carList[i]["checked"] == false) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  itemChange() async {
    if (this.isCheckAll()) {
      this.isCheckedAll = true;
    }
    else {
      this.isCheckedAll = false;
    }
    computerAllPrice();
    await Storage.setString("cartList", json.encode(this.carList));
    notifyListeners();
  }

  computerAllPrice() {
    double tempAllPrice = 0;
    for (var i = 0; i < this.carList.length; i++) {
      if (this.carList[i]["checked"] == true) {
        tempAllPrice += this.carList[i]["price"] * this.carList[i]["count"];
      }
    }
    this.allPrice = tempAllPrice;
    notifyListeners();
  }

  deleteData() async {
    List tempList = [];
    for (var i = 0; i < this.carList.length; i++) {
      if (this.carList[i]["checked"] == false) {
        tempList.add(carList[i]);
      }
    }
    this.carList = tempList;
    this.computerAllPrice();
    await Storage.setString("cartList", json.encode(this.carList));
    notifyListeners();
  }

}