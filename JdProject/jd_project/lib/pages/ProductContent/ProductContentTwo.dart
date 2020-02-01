import 'package:flutter/material.dart';
import 'package:jd_project/tools/ProductContentModel.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
class ProductContentTwo extends StatefulWidget {
  List _productContentList;
  ProductContentTwo(this._productContentList);
  @override
  _ProductContentTwoState createState() => _ProductContentTwoState(this._productContentList);
}

class _ProductContentTwoState extends State<ProductContentTwo> with AutomaticKeepAliveClientMixin{
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  List _productContentList;
  var id;
  _ProductContentTwoState(this._productContentList);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.id=this._productContentList[0].sId;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: InAppWebView(
              initialUrl: "http://jd.itying.com/pcontent?id=$id",
            )
          )
        ],
      ),
    );
  }
}
