class ReportModel {
  String? id;
  String? alertLevel;
  String? observationText;
  String? createdAt;
  String? updatedAt;
  List<String>? imgs;
  List<dynamic>? levelDatas;
  List<dynamic>? precipitationDatas;

  ReportModel(
      {this.id, this.alertLevel, this.observationText, this.createdAt, this.updatedAt, this.imgs, this.levelDatas, this.precipitationDatas});

  ReportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    alertLevel = json['alertLevel'];
    observationText = json['observationText'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    imgs = json['imgs'].cast<String>();
    if (json['levelDatas'] != null) {
      levelDatas = <Null>[];
      json['levelDatas'].forEach((v) {
        levelDatas!.add([]);
      });
    }
    if (json['precipitationDatas'] != null) {
      precipitationDatas = <Null>[];
      json['precipitationDatas'].forEach((v) {
        precipitationDatas!.add([]);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['alertLevel'] = this.alertLevel;
    data['observationText'] = this.observationText;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['imgs'] = this.imgs;
    if (this.levelDatas != null) {
      data['levelDatas'] = this.levelDatas!.map((v) => v.toJson()).toList();
    }
    if (this.precipitationDatas != null) {
      data['precipitationDatas'] = this.precipitationDatas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
