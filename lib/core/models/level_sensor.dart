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
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<LevelDataModel> levelsData;
  final bool active;
  final Status status;
  final double lat;
  final double long;

  LevelSensorModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.levelsData,
    required this.active,
    required this.status,
    required this.lat,
    required this.long,
  });

  LevelSensorModel fromJson(Map<String, dynamic> json) {
    return LevelSensorModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      levelsData: json['levelsData'],
      active: json['active'],
      status: json['status'],
      lat: json['lat'],
      long: json['long'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'levelsData': levelsData,
      'active': active,
      'status': status,
      'lat': lat,
      'long': long,
    };
  }
}

class LevelDataModel {
  final String id;
  final DateTime createdAt;
  final String sensorId;
  final String? observation;
  final LevelSensorModel sensor;
  final double level;

  LevelDataModel({
    required this.id,
    required this.createdAt,
    required this.sensorId,
    this.observation,
    required this.sensor,
    required this.level,
  });

  LevelDataModel fromJson(Map<String, dynamic> json) {
    return LevelDataModel(
      id: json['id'],
      createdAt: json['createdAt'],
      sensorId: json['sensorId'],
      observation: json['observation'],
      level: json['level'],
      sensor: json['sensor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'sensorId': sensorId,
      'observation': observation,
      'sensor': sensor,
    };
  }
}
