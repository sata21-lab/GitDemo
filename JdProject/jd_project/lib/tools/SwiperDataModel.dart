class SwiperModel {
  List<SwiperModelDataItemModel> result;

  SwiperModel({this.result});

  SwiperModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<SwiperModelDataItemModel>();
      json['result'].forEach((v) {
        result.add(new SwiperModelDataItemModel.fromJson(v));
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

class SwiperModelDataItemModel {
  String sId;
  String title;
  String status;
  String pic;
  String url;

  SwiperModelDataItemModel({this.sId, this.title, this.status, this.pic, this.url});

  SwiperModelDataItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    status = json['status'];
    pic = json['pic'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['status'] = this.status;
    data['pic'] = this.pic;
    data['url'] = this.url;
    return data;
  }
}