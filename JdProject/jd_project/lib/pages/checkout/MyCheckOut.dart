import 'package:flutter/material.dart';
import 'package:jd_project/provider/checkoutProider.dart';
import 'package:provider/provider.dart';

class MyCheckOut extends StatefulWidget {
  @override
  _MyCheckOutState createState() => _MyCheckOutState();
}

class _MyCheckOutState extends State<MyCheckOut> {
  var CheckOutProvider;
  @override
  Widget build(BuildContext context) {
    CheckOutProvider=Provider.of<ChecksOutProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("我的订单"),
      ),
      body: ListView.builder(
        itemCount: CheckOutProvider.CheckList.length,
        itemBuilder: (context,index){
          return Card(
            elevation: 5,//阴影
            shape: const RoundedRectangleBorder(//形状
              //修改圆角
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            color: Colors.white, //颜色
            margin: EdgeInsets.all(10), //margin
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("订单编号${this.CheckOutProvider.CheckList[index]["Checkid"]}",textAlign: TextAlign.left,),
                ),
                ListTile(
                    leading: Image.network(this.CheckOutProvider.getMyCheckOutDetailImage(index)),
                    title: Text("${this.CheckOutProvider.getMyCheckOutDetailData(index)}等"),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("合计:${this.CheckOutProvider.CheckList[index]["allPrice"]}"),
                      InkWell(
                        onTap: ()async{
                          this.CheckOutProvider.Checkid=this.CheckOutProvider.CheckList[index]["Checkid"];
                          await this.CheckOutProvider.getAllCheckOutDetail(this.CheckOutProvider.Checkid);
                          Navigator.pushNamed(context, '/checkoutdetail');
                          //print(this.CheckOutProvider.CheckList[index]["Checkid"]);
                        },
                        child: Text("查看详情"),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      )
    );
  }
}
