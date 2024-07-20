// model PrecipitationSensor{
//   id String @id @default(uuid())
//   name String
//   active Boolean @default(true)
//   observation String?
//   status Status @default(NORMAL)
//   createdAt DateTime @default(now())
//   updatedAt DateTime @updatedAt
//   precipitationsData PrecipitationData[]
//   lat Float
//   long Float
// }

// model PrecipitationData{
//   id String @id @default(uuid())
//   precipitation Int
//   createdAt DateTime @default(now())
//   sensorId String
//   observation String?
//   sensor PrecipitationSensor @relation(fields: [sensorId],references: [id])
// }
import '../constants/app_enums.dart';

class PrecipitationSensorModel {
  final String id;
  final String name;
  final bool active;
  final String? observation;
  final Status status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<PrecipitationDataModel> precipitationsData;
  final double lat;
  final double long;

  PrecipitationSensorModel({
    required this.id,
    required this.name,
    required this.active,
    required this.observation,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.precipitationsData,
    required this.lat,
    required this.long,
  });

  PrecipitationSensorModel fromJson(Map<String, dynamic> json) {
    return PrecipitationSensorModel(
      id: json['id'],
      name: json['name'],
      active: json['active'],
      observation: json['observation'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      precipitationsData: json['precipitationsData'],
      lat: json['lat'],
      long: json['long'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'active': active,
      'observation': observation,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'precipitationsData': precipitationsData,
      'lat': lat,
      'long': long,
    };
  }
}

class PrecipitationDataModel {
  final String id;
  final int precipitation;
  final DateTime createdAt;
  final String sensorId;
  final String? observation;
  final PrecipitationSensorModel sensor;

  PrecipitationDataModel({
    required this.id,
    required this.precipitation,
    required this.createdAt,
    required this.sensorId,
    required this.observation,
    required this.sensor,
  });
}
