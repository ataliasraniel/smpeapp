import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smpeapp/core/managers/api_manager.dart';
import 'package:smpeapp/core/models/camera_model.dart';

import '../../core/models/level_sensor.dart';
import '../../core/models/preciptation_model.dart';

class HomeScreenController extends GetxController {
  final ApiManager _apiManager = ApiManager();
  final PageController pageController = PageController();

  final _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;

  //todos os dispositivos
  List<CameraModel> _cameras = List<CameraModel>.empty().obs;
  List<CameraModel> get cameras => _cameras;

  final List<LevelSensorModel> _levelSensors = List<LevelSensorModel>.empty().obs;
  List<LevelSensorModel> get levelSensors => _levelSensors;

  RxBool _isLoadingCameras = true.obs;
  bool get isLoadingCameras => _isLoadingCameras.value;

  final List<PrecipitationSensorModel> _preciptations = List<PrecipitationSensorModel>.empty().obs;
  List<PrecipitationSensorModel> get precipitations => _preciptations;
  final List<Map<String, dynamic>> _filterOptions = [
    {'name': 'Câmeras', 'icon': Icons.videocam, 'id': 'CAMERAS'},
    {'name': 'Sensores', 'icon': Icons.wb_sunny, 'id': 'SENSORS'},
    {'name': 'Chuva', 'icon': Icons.cloud, 'id': 'RAIN'},
  ];

  getCameras() async {
    if (_cameras.isNotEmpty) {
      _cameras = [];
      update();
    }
    _isLoadingCameras.value = true;
    update();
    final response = await _apiManager.getData('/sensors/camera');
    if (response != null) {
      _cameras = [];
      response['data'].forEach((camera) {
        _cameras.add(CameraModel.fromJson(camera));
      });
    }
    _isLoadingCameras.value = false;
    update();
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
