import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smpeapp/core/constants/app_enums.dart';
import 'package:smpeapp/core/models/camera_model.dart';

import '../../core/models/level_sensor.dart';
import '../../core/models/preciptation_model.dart';

class HomeScreenController extends GetxController {
  final PageController pageController = PageController();

  final _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;

  //todos os dispositivos
  final List<CameraModel> _cameras = List<CameraModel>.empty().obs;
  List<CameraModel> get cameras => _cameras;

  final List<LevelSensorModel> _levelSensors = List<LevelSensorModel>.empty().obs;
  List<LevelSensorModel> get levelSensors => _levelSensors;

  final List<PrecipitationSensorModel> _preciptations = List<PrecipitationSensorModel>.empty().obs;
  List<PrecipitationSensorModel> get precipitations => _preciptations;
  final List<Map<String, dynamic>> _filterOptions = [
    {'name': 'Câmeras', 'icon': Icons.videocam, 'id': 'CAMERAS'},
    {'name': 'Sensores', 'icon': Icons.wb_sunny, 'id': 'SENSORS'},
    {'name': 'Chuva', 'icon': Icons.cloud, 'id': 'RAIN'},
  ];

//on initiate
  @override
  void onInit() {
    super.onInit();
    _cameras.add(CameraModel(
      id: '1',
      name: 'Câmera 1',
      lat: -23.550520,
      long: -46.633308,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      address: 'Rua 1, 123',
      status: Status.NORMAL,
      observation: 'Observação',
      imgsData: [],
    ));
    _cameras.add(CameraModel(
      id: '2',
      name: 'Câmera 2',
      lat: -23.550520,
      address: 'Rua 1, 123',
      long: -46.633308,
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      status: Status.NORMAL,
      observation: 'Observação',
      imgsData: [],
    ));
    _cameras.add(CameraModel(
      id: '3',
      name: 'Câmera 3',
      lat: -23.550520,
      long: -46.633308,
      address: 'Rua 1, 123',
      active: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      status: Status.NORMAL,
      observation:
          //gere uma descrição com no máximo 120 caracteres
          'Há 3 horas atrás, a câmera 3 registrou um aumento de 10% no nível do rio',
      imgsData: [],
    ));

    _levelSensors.add(LevelSensorModel(
      id: '1',
      name: 'Sensor 1',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      levelsData: [
        LevelDataModel(
          id: '1',
          createdAt: DateTime.now(),
          sensorId: '1',
          observation: 'Observação',
          sensor: LevelSensorModel(
            id: '1',
            name: 'Sensor 1',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            levelsData: [],
            active: true,
            status: Status.NORMAL,
            lat: -23.550520,
            long: -46.633308,
          ),
          level: 0.5,
        ),
      ],
      active: true,
      status: Status.NORMAL,
      lat: -23.550520,
      long: -46.633308,
    ));
    _levelSensors.add(LevelSensorModel(
      id: '2',
      name: 'Sensor 2',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      levelsData: [
        LevelDataModel(
          id: '2',
          createdAt: DateTime.now(),
          sensorId: '2',
          observation: 'Observação',
          sensor: LevelSensorModel(
            id: '2',
            name: 'Sensor 2',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            levelsData: [],
            active: true,
            status: Status.NORMAL,
            lat: -23.550520,
            long: -46.633308,
          ),
          level: 0.5,
        ),
      ],
      active: true,
      status: Status.NORMAL,
      lat: -23.550520,
      long: -46.633308,
    ));
    _levelSensors.add(LevelSensorModel(
      id: '3',
      name: 'Sensor 3',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      levelsData: [
        LevelDataModel(
          id: '3',
          createdAt: DateTime.now(),
          sensorId: '3',
          observation: 'Observação',
          sensor: LevelSensorModel(
            id: '3',
            name: 'Sensor 3',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            levelsData: [],
            active: true,
            status: Status.NORMAL,
            lat: -23.550520,
            long: -46.633308,
          ),
          level: 0.5,
        ),
      ],
      active: true,
      status: Status.NORMAL,
      lat: -23.550520,
      long: -46.633308,
    ));

    _preciptations.add(PrecipitationSensorModel(
      id: '1',
      name: 'Sensor 1',
      active: true,
      observation: 'Observação',
      status: Status.NORMAL,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      precipitationsData: [
        PrecipitationDataModel(
          id: '1',
          precipitation: 10,
          createdAt: DateTime.now(),
          sensorId: '1',
          observation: 'Observação',
          sensor: PrecipitationSensorModel(
            id: '1',
            name: 'Sensor 1',
            active: true,
            observation: 'Observação',
            status: Status.NORMAL,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            precipitationsData: [],
            lat: -23.550520,
            long: -46.633308,
          ),
        ),
      ],
      lat: -23.550520,
      long: -46.633308,
    ));
    _preciptations.add(PrecipitationSensorModel(
      id: '2',
      name: 'Sensor 2',
      active: true,
      observation: 'Observação',
      status: Status.NORMAL,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      precipitationsData: [
        PrecipitationDataModel(
          id: '2',
          precipitation: 10,
          createdAt: DateTime.now(),
          sensorId: '2',
          observation: 'Observação',
          sensor: PrecipitationSensorModel(
            id: '2',
            name: 'Sensor 2',
            active: true,
            observation: 'Observação',
            status: Status.NORMAL,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            precipitationsData: [],
            lat: -23.550520,
            long: -46.633308,
          ),
        ),
      ],
      lat: -23.550520,
      long: -46.633308,
    ));
    _preciptations.add(PrecipitationSensorModel(
      id: '3',
      name: 'Sensor 3',
      active: true,
      observation: 'Observação',
      status: Status.NORMAL,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      precipitationsData: [
        PrecipitationDataModel(
          id: '3',
          precipitation: 10,
          createdAt: DateTime.now(),
          sensorId: '3',
          observation: 'Observação',
          sensor: PrecipitationSensorModel(
            id: '3',
            name: 'Sensor 3',
            active: true,
            observation: 'Observação',
            status: Status.NORMAL,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            precipitationsData: [],
            lat: -23.550520,
            long: -46.633308,
          ),
        ),
      ],
      lat: -23.550520,
      long: -46.633308,
    ));
  }

  List<Map<String, dynamic>> get filterOptions => _filterOptions;
  void changeSelectedIndex(int index) {
    _selectedIndex.value = index;
    update();
  }

  void changePage(int index) {
    pageController.jumpToPage(index);
    changeSelectedIndex(index);
  }
}
