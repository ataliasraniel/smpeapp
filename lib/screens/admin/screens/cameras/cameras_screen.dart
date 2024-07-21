import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smpeapp/core/constants/style_constants.dart';
import 'package:smpeapp/core/models/camera_model.dart';
import 'package:smpeapp/core/utils/utils.dart';
import 'package:smpeapp/screens/home/home_screen_controller.dart';

import 'new_camera_screen.dart';
import 'view/camera_view_screen.dart';

class CamerasScreen extends StatefulWidget {
  const CamerasScreen({super.key});

  @override
  State<CamerasScreen> createState() => _CamerasScreenState();
}

class _CamerasScreenState extends State<CamerasScreen> {
  final HomeScreenController _controller = Get.put(HomeScreenController());
  @override
  void initState() {
    _controller.getCameras();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (controller) {
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor: kDetailColor,
                onPressed: () {
                  Get.to(() => NewCameraScreen(), transition: Transition.rightToLeftWithFade);
                },
                child: Icon(Icons.add),
              ),
              appBar: AppBar(
                title: Text('Câmeras'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      // _controller.getCameras();
                    },
                  ),
                  //register a new camera
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    controller.isLoadingCameras == true
                        ? Center(child: CircularProgressIndicator())
                        : Expanded(
                            child: ListView.builder(
                              itemCount: controller.cameras!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final CameraModel camera = controller.cameras![index];
                                return ListTile(
                                  onTap: () {
                                    Get.to(() => CameraViewScreen(camera: camera), transition: Transition.rightToLeftWithFade);
                                  },
                                  title: Text(camera.name!),
                                  subtitle: Text(camera.address!),
                                  leading: Icon(Icons.videocam),
                                  trailing: Text(
                                    camera.status!,
                                    style: kCaption1.copyWith(color: Utils.getStatusColor(camera.status!)),
                                  ),
                                );
                              },
                            ),
                          )
                  ],
                ),
              ));
        });
  }
}
