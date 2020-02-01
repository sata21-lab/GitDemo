import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jd_project/provider/UserProvider.dart';
import 'package:jd_project/tools/ScreenAdapter.dart';
import 'package:provider/provider.dart';

class AddressList extends StatefulWidget {
  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  var UserInfoProvider;
  @override
  Widget build(BuildContext context) {
    this.UserInfoProvider=Provider.of<UsersProvider>(context);
    setState(() {
      this.UserInfoProvider.wantToGetAddress(this.UserInfoProvider.username);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("收货地址"),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: ListView.builder(
              itemCount: this.UserInfoProvider.userAddress.length,
              itemBuilder: (context,index){
                return ListTile(
                  leading: Icon(
                    Icons.map,
                    color: Colors.grey,
                  ),
                  title: InkWell(
                    onTap: (){//选择收货地址
                      this.UserInfoProvider.getTempAddress(index);
                      Navigator.pop(context);
                    },
                    onLongPress: (){//长按删除地址
                      this.UserInfoProvider.initDatabase();
                      this.UserInfoProvider.wantToDeleteAddress(index);
                      Fluttertoast.showToast(
                          msg: "删除成功！",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("${this.UserInfoProvider.userAddress[index]["shouhuoname"]}    ${this.UserInfoProvider.userAddress[index]["shouhuophone"]}"),
                        SizedBox(
                          height: ScreenUtilAdapter.setHeight(30),
                        ),
                        Text("${this.UserInfoProvider.userAddress[index]["useraddress"]}")
                      ],
                    ),
                  )
                );
              },
            )
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
                  color: Colors.red,
                  border: Border(
                      top: BorderSide(width: 1, color: Colors.black26))),
              child: InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add, color: Colors.white),
                    Text("增加收货地址", style: TextStyle(color: Colors.white))
                  ],
                ),
                onTap: (){
                  //print(this.UserInfoProvider.userAddress.length);
                  Navigator.pushNamed(context,'/addressadd');
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
