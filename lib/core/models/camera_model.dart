class CameraModel {
  String? id;
  String? name;
  double? lat;
  double? long;
  bool? active;
  String? createdAt;
  String? updatedAt;
  String? status;
  String? observation;
  String? address;
  List<ImgsData>? imgsData;

  CameraModel(
      {this.id,
      this.name,
      this.lat,
      this.long,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.observation,
      this.address,
      this.imgsData});

  CameraModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lat = json['lat'];
    long = json['long'];
    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    status = json['status'];
    observation = json['observation'];
    address = json['address'];
    if (json['imgsData'] != null) {
      imgsData = <ImgsData>[];
      json['imgsData'].forEach((v) {
        imgsData!.add(new ImgsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['status'] = this.status;
    data['observation'] = this.observation;
    data['address'] = this.address;
    if (this.imgsData != null) {
      data['imgsData'] = this.imgsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImgsData {
  String? id;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;
  String? cameraId;

  ImgsData({this.id, this.imageUrl, this.createdAt, this.updatedAt, this.cameraId});

  ImgsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    cameraId = json['cameraId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['cameraId'] = this.cameraId;
    return data;
  }
}
