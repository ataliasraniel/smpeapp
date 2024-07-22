import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smpeapp/components/buttons/primary_button.dart';
import 'package:smpeapp/components/form/custom_text_form_field.dart';
import 'package:smpeapp/core/managers/api_manager.dart';
import 'package:smpeapp/core/models/camera_model.dart';
import 'package:smpeapp/core/models/level_sensor.dart';
import 'package:smpeapp/core/utils/date_format_utils.dart';

class ViewSensorPage extends StatefulWidget {
  const ViewSensorPage({super.key, required this.sensor});
  final LevelSensorModel sensor;

  @override
  State<ViewSensorPage> createState() => _ViewSensorPageState();
}

class _ViewSensorPageState extends State<ViewSensorPage> {
  final TextEditingController levelController = TextEditingController();
  List<LevelDataModel> levelsData = [];
  final ApiManager _apiManager = ApiManager();
  Future addNewLevel() async {
    double? level = double.tryParse(levelController.text);
    final response = await _apiManager.postData('/data/levels',
        data: {
          'level': level,
          'sensorId': widget.sensor.id,
        },
        showResponseData: true);
    print(response);
    if (response['data'] != null) {
      setState(() {
        levelsData.add(LevelDataModel.fromJson(response['data']));
      });
    }
  }

  @override
  initState() {
    super.initState();
    levelsData = widget.sensor.levelsData!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.sensor.name!),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                // _controller.getCameras();
              },
            ),
            //insert a photo into the camera
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Get.bottomSheet(
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Text('Adicionar medição'),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                          CustomTextFormField(
                            label: 'Nível',
                            hintText: 'Digite o nível',
                            controller: levelController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                              //maxLength(5),
                            ],
                            maxLength: 2,
                          ),
                          Spacer(),
                          PrimaryButton(
                              text: 'Adicionar Medição',
                              isFullWidth: true,
                              onPressed: () {
                                if (levelController.text.isEmpty) {
                                  Get.snackbar('Erro', 'Digite o nível', backgroundColor: Colors.red);
                                  return;
                                }
                                Get.back();
                                addNewLevel();
                                levelController.clear();
                              })
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Text('Status: ' + widget.camera.status.name!),
              const Divider(),
              const Text('Últimas medições'),
              levelsData.isEmpty
                  ? const Center(child: Text('Nenhum dado encontrado'))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: widget.sensor.levelsData!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final level = widget.sensor.levelsData![index];
                          return ListTile(
                            title: Text('Nível: ${level.level}'),
                            subtitle: Text(DateFormatUtils.formatStringDateTimeToBrDateHourAndMinute(level.createdAt.toString())),
                          );
                        },
                      ),
                    )
            ],
          ),
        ));
  }
}
