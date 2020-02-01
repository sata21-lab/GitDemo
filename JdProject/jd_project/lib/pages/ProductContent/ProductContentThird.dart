import 'package:flutter/material.dart';
import 'package:jd_project/tools/ProductContentModel.dart';
class ProductContentThird extends StatefulWidget {
  List _productContentList;
  ProductContentThird(this._productContentList);
  @override
  _ProductContentThirdState createState() => _ProductContentThirdState();
}

class _ProductContentThirdState extends State<ProductContentThird> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("评价"),
    );
  }
}
