import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smpeapp/core/models/camera_model.dart';
import 'package:smpeapp/core/utils/date_format_utils.dart';

import 'add_new_photo_screen.dart';

class CameraViewScreen extends StatefulWidget {
  const CameraViewScreen({super.key, required this.camera});
  final CameraModel camera;

  @override
  State<CameraViewScreen> createState() => _CameraViewScreenState();
}

class _CameraViewScreenState extends State<CameraViewScreen> {
  final List<Map<String, dynamic>> imagesUrls = [];

  @override
  void initState() {
    super.initState();
    widget.camera.imgsData!.forEach((element) {
      imagesUrls.add(
        {
          'id': element.id,
          'imageUrl': element.imageUrl,
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.camera.name!),
          actions: [
            //insert a photo into the camera
            IconButton(
              icon: const Icon(Icons.add_a_photo),
              onPressed: () async {
                final routeResponse = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNewPhotoScreen(
                      cameraId: widget.camera.id!,
                      camera: widget.camera,
                    ),
                  ),
                );
                if (routeResponse != null) {
                  setState(() {
                    imagesUrls.add(
                      {
                        'id': routeResponse['id'],
                        'imageUrl': routeResponse['imageUrl'],
                      },
                    );
                  });
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Endereço: ${widget.camera.address!}'),
              // Text('Status: ' + widget.camera.status.name!),
              const Divider(),
              const Text('Últimas fotos'),
              widget.camera.imgsData!.isEmpty
                  ? const Center(child: Text('Nenhuma foto encontrada'))
                  : Expanded(
                      child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: widget.camera.imgsData!.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (context, index) {
                            final photo = widget.camera.imgsData![index];
                            return Container(
                              margin: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Image.network(
                                    photo.imageUrl!,
                                    height: 140,
                                    width: double.maxFinite,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    DateFormatUtils.formatStringDateTimeToBrDateHourAndMinute(photo.createdAt!),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            );
                          }))
            ],
          ),
        ));
  }
}
