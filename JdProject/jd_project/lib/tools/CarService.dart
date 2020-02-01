import 'package:jd_project/config/config.dart';

import 'Storage.dart';
import 'dart:convert';

class CartServices{


  static addCart(item)async{
    //把对象转换成Map类型的数据
    item=CartServices.formatCartData(item);
    print(item);
    try {
      List carListData = json.decode(await Storage.getString("cartList"));
      bool hasData=carListData.any((value){
        if(value["_id"]==item["_id"]&&value["selectedAttr"]==item["selectedAttr"]){
          return true;
        }
        return false;
      });
      if(hasData){
        for(var i=0;i<carListData.length;i++){
          if(carListData[i]['_id']==item['_id']&&carListData[i]['selectedAttr']==item['selectedAttr']){
            carListData[i]["count"]=carListData[i]["count"]+1;
          }
        }
        await Storage.setString('cartList', json.encode(carListData));
      }else{
        carListData.add(item);
        await Storage.setString('cartList', json.encode(carListData));
      }
    }
    catch(e){
      List tempList=[];
      tempList.add(item);
      await Storage.setString("cartList", json.encode(tempList));
    }
  }

  //过滤数据
  static formatCartData(item){
    String pic=item.pic;
    pic=Config.domain+pic.replaceAll('\\', '/');
    final Map data = new Map<String, dynamic>();
    data['_id'] = item.sId;
    data['title'] = item.title;
    if(item.price is int||item.price is double){
      data['price'] = item.price;
    }
    else{
      data['price'] = double.parse(item.price);
    }
    data['selectedAttr'] = item.selectedAttr;
    data['count'] = item.count;
    data['pic'] = pic;
    //是否选中
    data['checked'] = true;
    return data;
  }
  //获取购物车选中的数据
  static getCheckOutData() async {
    List cartListData = [];
    List tempCheckOutData = [];
    try {
      cartListData = json.decode(await Storage.getString('cartList'));
    } catch (e) {
      cartListData = [];
    }
    for (var i = 0; i < cartListData.length; i++) {
      if (cartListData[i]["checked"] == true) {
        tempCheckOutData.add(cartListData[i]);
      }
    }

    return tempCheckOutData;
  }

}