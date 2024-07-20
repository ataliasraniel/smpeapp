// enum Status{
//   DESATIVATED
//   NORMAL
//   DAMAGED
// }
// ////

// model Camera {
//   id String @id @default(uuid())
//   name String
//   lat Float
//   long Float
//   active Boolean @default(true)
//   createdAt DateTime @default(now())
//   updatedAt DateTime @updatedAt
//   status Status @default(NORMAL)
//   observation String?
//   imgsData CameraImage[]
// }

import 'package:smpeapp/core/constants/app_enums.dart';

class CameraModel {
  final String id;
  final String name;
  final double lat;
  final String address;
  final double long;
  final bool active;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Status status;
  final String? observation;
  final List<CameraImageModel> imgsData;

  CameraModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.long,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    this.observation,
    required this.imgsData,
    required this.address,
  });

  CameraModel fromJson(Map<String, dynamic> json) {
    return CameraModel(
      id: json['id'],
      name: json['name'],
      lat: json['lat'],
      long: json['long'],
      active: json['active'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      status: json['status'],
      observation: json['observation'],
      imgsData: json['imgsData'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lat': lat,
      'long': long,
      'active': active,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'status': status,
      'observation': observation,
      'imgsData': imgsData,
    };
  }
}

class CameraImageModel {
  final String id;
  final String cameraId;
  final String imgPath;
  final DateTime createdAt;
  final DateTime updatedAt;

  CameraImageModel({
    required this.id,
    required this.cameraId,
    required this.imgPath,
    required this.createdAt,
    required this.updatedAt,
  });

  CameraImageModel fromJson(Map<String, dynamic> json) {
    return CameraImageModel(
      id: json['id'],
      cameraId: json['cameraId'],
      imgPath: json['imgPath'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cameraId': cameraId,
      'imgPath': imgPath,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
