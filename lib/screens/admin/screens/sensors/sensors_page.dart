import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smpeapp/core/constants/style_constants.dart';
import 'package:smpeapp/core/models/level_sensor.dart';
import 'package:smpeapp/screens/admin/screens/sensors/view_sensor_page.dart';
import 'package:smpeapp/screens/home/home_screen_controller.dart';

import 'new_sensor_screen.dart';

class SensorsScreen extends StatefulWidget {
  const SensorsScreen({super.key});

  @override
  State<SensorsScreen> createState() => _SensorsScreenState();
}

class _SensorsScreenState extends State<SensorsScreen> {
  final HomeScreenController _controller = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (controller) {
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor: kDetailColor,
                onPressed: () {
                  Get.to(() => const NewSensorScreen(), transition: Transition.rightToLeftWithFade)?.then(
                    (value) => setState(() {}),
                  );
                },
                child: const Icon(Icons.add),
              ),
              appBar: AppBar(
                title: const Text('Sensores'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                  //register a new camera
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    FutureBuilder(
                        future: _controller.fetchLevelSensors(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Skeletonizer(
                              enabled: true,
                              child: Column(
                                children: List.generate(10, (index) {
                                  return const ListTile(
                                    title: Text('carregando'),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  );
                                }),
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('Erro ao carregar os sensores'),
                            );
                          }
                          if (snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text('Nenhum sensor encontrado'),
                            );
                          }
                          return Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final LevelSensorModel levelSensor = snapshot.data![index];
                                return ListTile(
                                  leading: const Icon(Icons.sensors),
                                  onTap: () {
                                    Get.to(() => ViewSensorPage(sensor: levelSensor), transition: Transition.rightToLeftWithFade);
                                  },
                                  title: Text(levelSensor.name!),
                                  subtitle: Text('Status: ${levelSensor.status!}'),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                );
                              },
                            ),
                          );
                        })
                  ],
                ),
              ));
        });
  }
}
