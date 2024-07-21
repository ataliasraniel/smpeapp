import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smpeapp/core/constants/style_constants.dart';
import 'package:smpeapp/core/managers/api_manager.dart';

import '../../../../../components/buttons/primary_button.dart';

class AddNewPhotoScreen extends StatefulWidget {
  const AddNewPhotoScreen({super.key, required this.cameraId});
  final String cameraId;
  @override
  State<AddNewPhotoScreen> createState() => _AddNewPhotoScreenState();
}

class _AddNewPhotoScreenState extends State<AddNewPhotoScreen> {
  final storageRef = FirebaseStorage.instance.ref();
  final ApiManager _apiManager = ApiManager();
  bool _isLoading = false;
  XFile? _imageFile;
  _getImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = image;
    });
  }

  _selectPhotoFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }

  void setIsLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  _sendImageIntoServer() async {
    try {
      setIsLoading(true);
      String filePath = 'images/${widget.cameraId}/${DateTime.now().millisecondsSinceEpoch}.png';
      String imageRef = storageRef.child(filePath).fullPath;
      print(filePath);
      await storageRef.child(filePath).putFile(File(_imageFile!.path));
      final String downloadUrl = await storageRef.child(filePath).getDownloadURL();
      print(downloadUrl);
      await _apiManager.postData('/data/images/${widget.cameraId}', data: {
        'imageUrl': downloadUrl,
      });
      Get.back();
      Get.snackbar('Sucesso!', 'Foto adicionada com sucesso', backgroundColor: Colors.green);
      setIsLoading(false);
    } catch (e) {
      print(e);
      setIsLoading(false);
      Get.snackbar('Erro!', 'Erro ao adicionar foto', backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Adicionar foto'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              if (_imageFile != null)
                Column(children: [
                  Image.file(File(_imageFile!.path)),
                  SizedBox(height: 20),
                  PrimaryButton(
                    isFullWidth: true,
                    onPressed: () async {
                      _sendImageIntoServer();
                    },
                    isLoading: _isLoading,
                    text: 'Usar esta foto',
                  ),
                ]),

              if (_imageFile == null)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Tire uma foto', style: kBody1),
                      TextButton.icon(
                          onPressed: () {
                            _getImageFromCamera();
                          },
                          label: Text('Tirar Foto'),
                          icon: Icon(Icons.camera_alt)),
                      TextButton.icon(
                          onPressed: () {
                            _selectPhotoFromGallery();
                          },
                          label: Text('Selecionar da galeria'),
                          icon: Icon(Icons.photo)),
                    ],
                  ),
                ),

              //form to add a new photo
            ],
          ),
        ));
  }
}
