// model LevelSensor{
//   id String @id @default(uuid())
//   name String
//   createdAt DateTime @default(now())
//   updatedAt DateTime @updatedAt
//   levelsData LevelData[]
//   active Boolean @default(true)
//   status Status @default(NORMAL)
//   lat Float
//   long Float
// }

// model LevelData{
//   id String @id @default(uuid())
//   createdAt DateTime @default(now())
//   sensorId String
//   observation String?
//   sensor LevelSensor @relation(fields: [sensorId],references: [id])
// }

import 'package:smpeapp/core/constants/app_enums.dart';

class LevelSensorModel {
  String? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<LevelDataModel>? levelsData;
  bool? active;
  String? status;
  double? lat;
  double? long;

  LevelSensorModel({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.levelsData,
    this.active,
    this.status,
    this.lat,
    this.long,
  });

  LevelSensorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
    if (json['levelsData'] != null) {
      levelsData = <LevelDataModel>[];
      json['levelsData'].forEach((v) {
        levelsData!.add(LevelDataModel.fromJson(v));
      });
    }
    active = json['active'];
    status = json['status'];
    lat = json['lat'];
    long = json['long'];
  }
}

class LevelDataModel {
  String? id;
  DateTime? createdAt;
  String? sensorId;
  String? observation;
  LevelSensorModel? sensor;
  double? level;

  LevelDataModel({
    this.id,
    this.createdAt,
    this.sensorId,
    this.observation,
    this.sensor,
    this.level,
  });

  LevelDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = DateTime.parse(json['createdAt']);
    sensorId = json['sensorId'];
    observation = json['observation'];
    sensor = json['sensor'];
    level = json['level'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt!.toIso8601String();
    data['sensorId'] = sensorId;
    data['observation'] = observation;
    data['sensor'] = sensor;
    data['level'] = level;
    return data;
  }
}
