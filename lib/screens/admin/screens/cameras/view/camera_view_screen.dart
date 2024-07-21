import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smpeapp/core/models/camera_model.dart';

import 'add_new_photo_screen.dart';

class CameraViewScreen extends StatefulWidget {
  const CameraViewScreen({super.key, required this.camera});
  final CameraModel camera;

  @override
  State<CameraViewScreen> createState() => _CameraViewScreenState();
}

class _CameraViewScreenState extends State<CameraViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.camera.name!),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                // _controller.getCameras();
              },
            ),
            //insert a photo into the camera
            IconButton(
              icon: Icon(Icons.add_a_photo),
              onPressed: () {
                Get.to(
                    () => AddNewPhotoScreen(
                          cameraId: widget.camera.id!,
                        ),
                    transition: Transition.rightToLeftWithFade);
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Endereço: ' + widget.camera.address!),
              // Text('Status: ' + widget.camera.status.name!),
              Divider(),
              Text('Últimas fotos'),
              widget.camera.imgsData!.isEmpty
                  ? Center(child: Text('Nenhuma foto encontrada'))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: widget.camera.imgsData!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final photo = widget.camera.imgsData![index];
                          return ListTile(
                            title: Text(photo.id!),
                            subtitle: Text(photo.createdAt.toString()),
                            leading: Image.network(photo.imageUrl!),
                          );
                        },
                      ),
                    )
            ],
          ),
        ));
  }
}
