import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smpeapp/components/buttons/primary_button.dart';
import 'package:smpeapp/components/form/custom_dropdown_button.dart';
import 'package:smpeapp/components/form/custom_text_form_field.dart';
import 'package:smpeapp/core/constants/app_number_constants.dart';
import 'package:smpeapp/core/constants/style_constants.dart';
import 'package:smpeapp/core/managers/api_manager.dart';
import 'package:smpeapp/screens/home.dart';

class NewReportScreen extends StatefulWidget {
  const NewReportScreen({super.key});

  @override
  State<NewReportScreen> createState() => _NewReportScreenState();
}

class _NewReportScreenState extends State<NewReportScreen> {
  final ApiManager _apiManager = ApiManager();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController photosToUse = TextEditingController();
  final TextEditingController preciptationlevel = TextEditingController();
  final TextEditingController temperature = TextEditingController();
  final TextEditingController humidity = TextEditingController();
  final TextEditingController windSpeed = TextEditingController();
  final TextEditingController airPressure = TextEditingController();
  final TextEditingController riverLevel = TextEditingController();
  final TextEditingController mainStreetOverflowLevel = TextEditingController();
  //volume de chuva
  bool useRainVolume = false;
  final windDirection = ['Norte', 'Nordeste', 'Leste', 'Sudeste', 'Sul', 'Sudoeste', 'Oeste', 'Noroeste'];
  final choices = ['Normal', 'Mínimo', 'Médio', 'Máximo', 'Dados Recentes', 'Customizado'];
  String selectedChoice = 'Normal';
  String selectedWindDirection = 'Norte';
  bool _isLoading = false;
  bool _useForecast = false;
  Icon getIcon(String value) {
    switch (value) {
      case 'Normal':
        return const Icon(Icons.sunny);
      case 'Mínimo':
        return const Icon(Icons.cloud);
      case 'Médio':
        return const Icon(Icons.cloud_queue);
      case 'Máximo':
        return const Icon(Icons.cloud_circle);
      case 'Dados Recentes':
        return const Icon(Icons.cloud_done);
      case 'Customizado':
        return const Icon(Icons.cloud_done);
      default:
        return const Icon(Icons.cloud);
    }
  }

  void setIsLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  void setUseForecast(bool value) {
    setState(() {
      _useForecast = value;
    });
  }

  void startNewReport() async {
    if (_formKey.currentState != null) {
      if (!_formKey.currentState!.validate() && selectedChoice == 'Customizado') {
        return;
      }
    }
    setIsLoading(true);
    final report = {
      'photosToUse': photosToUse.text,
      'preciptationlevel': preciptationlevel.text,
      'temperature': temperature.text,
      'humidity': humidity.text,
      'windSpeed': windSpeed.text,
      'airPressure': airPressure.text,
      'riverLevel': riverLevel.text,
      'mainStreetOverflowLevel': mainStreetOverflowLevel.text,
      'windDirection': selectedWindDirection,
      'choice': selectedChoice,
    };
    print(report);
    try {
      final response = await _apiManager.postData('/report', data: report);
      print(response['data']);
      Get.back();
      Get.back();
      Get.to(() => HomeScreen());
    } catch (e) {
      setIsLoading(false);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: const Text('Novo Relatório'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
                'Você pode selecionar uma opção predefinida para criar um relatório com base no nível de alerta, ou criar um relatório personalizado com base em suas próprias entradas.',
                style: kBody3),
            const SizedBox(height: kMediumSize),
            Wrap(
              children: List.generate(
                  choices.length,
                  (index) => Container(
                        margin: const EdgeInsets.only(right: kSmallSize, bottom: kSmallSize),
                        child: ChoiceChip(
                            avatar: getIcon(choices[index]),
                            label: Text(choices[index]),
                            selectedColor: Colors.orange,
                            selected: selectedChoice == choices[index],
                            onSelected: (selected) {
                              setState(() {
                                selectedChoice = choices[index];
                              });
                            }),
                      )),
            ),
            if (selectedChoice == 'Customizado')
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'Novo Relatório Manual',
                          style: kBody2,
                        ),
                        const Text(
                            'Você pode requisitar um novo relatório que será gerado e aparecerá na parte de relatórios do usuário comum. Use esta tela para simular sensores'),
                        const SizedBox(height: kMediumSize),
                        CustomTextFormField(
                          label: 'Quantidade de fotos usadas',
                          hintText: 'Digite a quantidade de fotos usadas',
                          controller: photosToUse,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Digite a quantidade de fotos usadas';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          label: 'Nível de Precipitação',
                          hintText: 'Digite o nível de precipitação',
                          controller: preciptationlevel,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo Obrigatório';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          label: 'Temperatura',
                          hintText: 'Digite a temperatura',
                          controller: temperature,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo Obrigatório';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          label: 'Umidade',
                          hintText: 'Digite a umidade',
                          controller: humidity,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo Obrigatório';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          label: 'Velocidade do Vento',
                          hintText: 'Digite a velocidade do vento',
                          controller: windSpeed,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo Obrigatório';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          label: 'Pressão do Ar',
                          hintText: 'Digite a pressão do ar',
                          controller: airPressure,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo Obrigatório';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          label: 'Nível do Rio',
                          hintText: 'Digite o nível do rio',
                          controller: riverLevel,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo Obrigatório';
                            }
                            return null;
                          },
                        ),
                        //dropdown
                        CustomTextFormField(
                          label: 'Nível de Transbordamento da Rua Principal',
                          hintText: 'Digite o nível de transbordamento da rua principal',
                          controller: mainStreetOverflowLevel,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo Obrigatório';
                            }
                            return null;
                          },
                        ),
                        CustomDropdownButton(
                          value: selectedWindDirection,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo Obrigatório';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              selectedWindDirection = value;
                            });
                          },
                          items: windDirection.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            const SizedBox(height: kMediumSize),
            //Usar previsão do tempo para o local
            SwitchListTile(
                title: Text('Usar previsão do tempo para o local'),
                subtitle: Text('Use a previsão do tempo para o local para gerar um relatório'),
                value: _useForecast,
                onChanged: (value) {
                  setUseForecast(value);
                }),
            PrimaryButton(text: 'Iniciar', isFullWidth: true, isLoading: _isLoading, onPressed: startNewReport)
          ],
        ),
      ),
    );
  }
}
