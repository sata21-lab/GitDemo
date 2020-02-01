import 'package:fluttertoast/fluttertoast.dart';
import 'package:jd_project/provider/UserProvider.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:jd_project/Widget/BigText.dart';
import 'package:jd_project/Widget/JdButton.dart';
import 'package:jd_project/Widget/JdText.dart';
import 'package:jd_project/tools/ScreenAdapter.dart';
import 'package:provider/provider.dart';

class AddressAdd extends StatefulWidget {
  @override
  _AddressAddState createState() => _AddressAddState();
}

class _AddressAddState extends State<AddressAdd> {
  String area="";
  String UserName="";
  String UserPhone="";
  List AddressList=[];
  Map temp={};
  var UserInfoProvider;
  String detailAddress="";
  @override
  Widget build(BuildContext context) {
    this.UserInfoProvider=Provider.of<UsersProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("增加收货地址"),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20),
              JdText(
                onChanged: (value){
                  this.UserName=value;
                },
                text: "收货人姓名",
              ),
              SizedBox(height: 10),
              JdText(
                onChanged: (value){
                  this.UserPhone=value;
                },
                text: "收货人电话",
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(left: 5),
                height: ScreenUtilAdapter.setHeight(100),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colors.black12))),
                child: InkWell(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.add_location),
                      this.area.length>0?Text('${this.area}', style: TextStyle(color: Colors.black54)):Text('省/市/区', style: TextStyle(color: Colors.black54))
                    ],
                  ),
                  onTap: () async{
                    Result result = await CityPickers.showCityPicker(
                        context: context,
                        cancelWidget:
                        Text("取消", style: TextStyle(color: Colors.blue)),
                        confirmWidget:
                        Text("确定", style: TextStyle(color: Colors.blue))
                    );
                    setState(() {
                      this.area= "${result.provinceName}/${result.cityName}/${result.areaName}";
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              BigText(
                text: "详细地址",
                maxLength: 150,
                height: 200,
                onChanged: (value){
                  this.detailAddress=value;
                },
              ),
              SizedBox(height: 10),
              SizedBox(height: 40),
              JdButton(text: "增加", color: Colors.red,cb: ()async{
                //temp={"姓名":this.UserName,"电话":this.UserPhone,"地址":this.area};
                await this.UserInfoProvider.wantToSetAddress(this.UserInfoProvider.username,this.UserName,this.UserPhone,this.area+this.detailAddress);
                Fluttertoast.showToast(
                    msg: "添加成功！",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                Navigator.pop(context);
              },)
            ],
          ),
        ));
  }
}
