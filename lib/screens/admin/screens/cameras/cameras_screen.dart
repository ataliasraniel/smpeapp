import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smpeapp/core/constants/style_constants.dart';
import 'package:smpeapp/core/utils/utils.dart';
import 'package:smpeapp/screens/home/home_screen_controller.dart';

import 'view/camera_view_screen.dart';

class CamerasScreen extends StatefulWidget {
  const CamerasScreen({super.key});

  @override
  State<CamerasScreen> createState() => _CamerasScreenState();
}

class _CamerasScreenState extends State<CamerasScreen> {
  final HomeScreenController _controller = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: kDetailColor,
          onPressed: () {
            // _controller.registerCamera();
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
              Expanded(
                child: ListView.builder(
                  itemCount: _controller.cameras.length,
                  itemBuilder: (BuildContext context, int index) {
                    final camera = _controller.cameras[index];
                    return ListTile(
                      onTap: () {
                        Get.to(() => CameraViewScreen(camera: camera), transition: Transition.rightToLeftWithFade);
                      },
                      title: Text(camera.name),
                      subtitle: Text(camera.address),
                      leading: Icon(Icons.videocam),
                      trailing: Text(
                        camera.status.name,
                        style: kCaption1.copyWith(color: Utils.getStatusColor(camera.status)),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
