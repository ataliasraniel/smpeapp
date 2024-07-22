import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smpeapp/components/buttons/primary_button.dart';
import 'package:smpeapp/components/form/custom_text_form_field.dart';
import 'package:smpeapp/core/constants/app_enums.dart';
import 'package:smpeapp/core/managers/api_manager.dart';
import 'package:smpeapp/core/managers/app_snack_bar_manager.dart';

class NewSensorScreen extends StatefulWidget {
  const NewSensorScreen({super.key});

  @override
  State<NewSensorScreen> createState() => _NewSensorScreenState();
}

class _NewSensorScreenState extends State<NewSensorScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final ApiManager _apiManager = ApiManager();

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Adicionar Câmera'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                CustomTextFormField(
                  label: 'Nome do Sensor',
                  hintText: 'Digite o nome do sensor',
                  controller: _nameController,
                ),
                CustomTextFormField(
                  label: 'Localização',
                  hintText: 'Digite a localização do sensor',
                  controller: _addressController,
                ),
                Spacer(),
                PrimaryButton(
                    isFullWidth: true,
                    text: 'Salvar',
                    isLoading: _isLoading,
                    onPressed: () async {
                      final cameraData = {
                        'name': _nameController.text,
                        'address': _addressController.text,
                        'lat': -8.6632781,
                        'long': -36.0262994,
                      };
                      try {
                        setState(() {
                          _isLoading = true;
                        });
                        final data = await _apiManager.postData('/sensors/level', data: cameraData, showResponseData: true);
                        print(data);
                        Navigator.pop(context);

                        Get.snackbar('Sucessso', 'Câmera salva com sucesso', backgroundColor: Colors.green);
                      } catch (e) {
                        setState(() {
                          _isLoading = false;
                        });
                        Get.snackbar('Falha!', 'Erro ao salvar câmera', backgroundColor: Colors.red);
                      }
                    })
              ],
            )));
  }
}
