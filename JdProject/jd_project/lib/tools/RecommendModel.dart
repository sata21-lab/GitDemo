class RecommendModel {
  List<RecommendItemModel> result;

  RecommendModel({this.result});

  RecommendModel.fromJson(Map<String, dynamic> json) {

    if (json['result'] != null) {
      result = new List<RecommendItemModel>();
      json['result'].forEach((v) {
        result.add(new RecommendItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecommendItemModel {
  String sId;
  String title;
  String cid;
  Object price;
  String oldPrice;
  String pic;
  String sPic;

  RecommendItemModel(
      {this.sId,
        this.title,
        this.cid,
        this.price,
        this.oldPrice,
        this.pic,
        this.sPic});

  RecommendItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    cid = json['cid'];
    price = json['price'];
    oldPrice = json['old_price'];
    pic = json['pic'];
    sPic = json['s_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['cid'] = this.cid;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['pic'] = this.pic;
    data['s_pic'] = this.sPic;
    return data;
  }
}