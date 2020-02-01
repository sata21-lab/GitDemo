

import 'package:flutter/material.dart';
import 'package:jd_project/provider/checkoutProider.dart';
import 'package:jd_project/tools/ScreenAdapter.dart';
import 'package:provider/provider.dart';

class CheckOutDetail extends StatefulWidget {
  @override
  _CheckOutDetailState createState() => _CheckOutDetailState();
}

class _CheckOutDetailState extends State<CheckOutDetail> {
   /*List<Widget> getDetailWidget(){
    List<Widget> list=[];
    for(int i=0;i<5;i++){
      list.add(Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            width: ScreenUtilAdapter.setWidth(120),
            child: Image.network(
                "https://www.itying.com/images/flutter/list2.jpg",
                fit: BoxFit.cover),
          ),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("四季沐歌 (MICOE) 洗衣机水龙头 洗衣机水嘴 单冷快开铜材质龙头",
                        maxLines: 2,
                        style: TextStyle(color: Colors.black54)),
                    Text("水龙头 洗衣机",
                        maxLines: 2,
                        style: TextStyle(color: Colors.black54)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("￥100",
                            style: TextStyle(color: Colors.red)),
                        Text("x2")
                      ],
                    )
                  ],
                ),
              ))
        ],
      ));
    }
    return list;
  }*/
   getDetailWidget(index){
     return Row(
       children: <Widget>[
         Container(
           margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
           width: ScreenUtilAdapter.setWidth(120),
           child: Image.network(this.CheckOutProvider.AllCheckDetailList[index]["pic"],
               fit: BoxFit.cover),
         ),
         Expanded(
             flex: 1,
             child: Container(
               padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Text("${this.CheckOutProvider.AllCheckDetailList[index]["title"]}",
                       maxLines: 2,
                       style: TextStyle(color: Colors.black54)),
                   Text("${this.CheckOutProvider.AllCheckDetailList[index]["selectedAttr"]}",
                       maxLines: 2,
                       style: TextStyle(color: Colors.black54)),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       Text("￥${this.CheckOutProvider.AllCheckDetailList[index]["price"]}",
                           style: TextStyle(color: Colors.red)),
                       Text("x${this.CheckOutProvider.AllCheckDetailList[index]["count"]}")
                     ],
                   )
                 ],
               ),
             ))
       ],
     );
   }
   var CheckOutProvider;
  @override
  Widget build(BuildContext context) {
    CheckOutProvider=Provider.of<ChecksOutProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("订单详情")),
      body: Container(
        child: ListView(
          children: <Widget>[
            //收货地址
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.add_location),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("${this.CheckOutProvider.AllCheckList[0]["shouhuoname"]}  ${this.CheckOutProvider.AllCheckList[0]["shouhuophone"]}"),
                        SizedBox(height: 10),
                        Text("${this.CheckOutProvider.AllCheckList[0]["shouhuoAddress"]}"),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 16),
            //列表
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: CheckOutProvider.CheckDetailList.length,
                itemBuilder: (context,index){
                  return getDetailWidget(index);
                },
              ),
            ),
            /*Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Column(
                  children: getDetailWidget()
              ),
            ),*/
            //详情信息
            Container(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                children: <Widget>[

                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Text("订单编号:",style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("${this.CheckOutProvider.Checkid}")
                      ],
                    ),
                  ),

                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Text("下单日期:",style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("2019-12-09")
                      ],
                    ),
                  ),

                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Text("支付方式:",style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("微信支付")
                      ],
                    ),
                  ),

                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Text("配送方式:",style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("顺丰")
                      ],
                    ),
                  )

                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                children: <Widget>[
                  ListTile(
                      title: Row(
                        children: <Widget>[
                          Text("总金额:",style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("￥${this.CheckOutProvider.AllCheckList[0]["allPrice"]}",style: TextStyle(
                              color: Colors.red
                          ))
                        ],
                      )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
