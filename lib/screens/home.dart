import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smpeapp/core/constants/app_number_constants.dart';
import 'package:smpeapp/core/constants/style_constants.dart';
import 'package:smpeapp/core/utils/date_format_utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, dynamic>> _reports = [
    {
      'title': 'Relatório Guardião',
      'dateTime': DateFormatUtils.formatStringDateTimeToBrDateHourAndMinute('2022-01-01 12:00:00'),
      'updated': DateFormatUtils.formatStringDateTimeToBrDateHourAndMinute('2022-01-01 12:00:00'),
      'status': 'Concluído',
      'statusColor': kSuccessColor,
      'riskStatus': 'Baixo',
      'observations':
          //gere uma observação com 240 caracteres levando em consideraçao a previsã do tempo, risco e status
          'O dia está ensolarado, sem previsão de chuva, com temperatura de 25°C e umidade relativa do ar de 50%. O vento está fraco, com velocidade de 10km/h e índice UV de 5. A pressão atmosférica está em 1013hPa. O risco de enchente é baixo e o status do relatório é concluído.',
      'forecast': {
        'rain': 0.0,
        'temperature': 25.0,
        'humidity': 50.0,
        'wind': 10.0,
        'uv': 5.0,
        'pressure': 1013.0,
      }
    },
    //crie mais reports com dados aleatórios
    {
      'title': 'Relatório Guardião',
      'dateTime': DateFormatUtils.formatStringDateTimeToBrDateHourAndMinute('2022-01-01 14:00:00'),
      'updated': DateFormatUtils.formatStringDateTimeToBrDateHourAndMinute('2022-01-01 16:00:00'),
      'status': 'Concluído',
      'statusColor': kSuccessColor,
      'riskStatus': 'Alto',
      'observations':
          //gere uma observação com 240 caracteres levando em consideraçao a previsã do tempo, risco e status
          'O dia está ensolarado, sem previsão de chuva, com temperatura de 25°C e umidade relativa do ar de 50%. O vento está fraco, com velocidade de 10km/h e índice UV de 5. A pressão atmosférica está em 1013hPa. O risco de enchente é alto e o status do relatório é concluído.',
      'forecast': {
        'rain': 0.0,
        'temperature': 25.0,
        'humidity': 50.0,
        'wind': 10.0,
        'uv': 5.0,
        'pressure': 1013.0,
      }
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: kDetailColor,
          unselectedItemColor: kTextColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Pesquisar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Adicionar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configurações',
            ),
          ],
        ),
        appBar: AppBar(
          title: Text('SMPE'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Olá, bom dia. Hoje é ${DateFormatUtils.getTodayDate()}',
                style: kBody2,
              ),
              SizedBox(
                height: kMediumSize,
              ),
              Text('Veja os últimos relatórios gerados pelo nosso Guardião'),
              SizedBox(
                height: kMediumSize,
              ),
              //crie uma lista com os dados acima com um icone para cada status
              Expanded(
                child: ListView.builder(
                  itemCount: _reports.length,
                  itemBuilder: (context, index) {
                    return FadeInUp(
                      duration: Duration(milliseconds: 200 * index),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: kMediumSize),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            left: BorderSide(
                              color: _reports[index]['statusColor'],
                              width: 5,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(kSmallSize),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(kMediumSize),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _reports[index]['title'],
                                  style: kTitle2,
                                ),
                                Text(
                                  _reports[index]['dateTime'],
                                  style: kCaption1,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: kSmallSize,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Atualizado em: ${_reports[index]['updated']}',
                                  style: kCaption1,
                                ),
                                Text(
                                  'Status: ${_reports[index]['status']}',
                                  style: kCaption1.copyWith(color: _reports[index]['statusColor']),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: kSmallSize,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Risco: ${_reports[index]['riskStatus']}',
                                  style: kCaption1,
                                ),
                                Text(
                                  'Previsão:',
                                  style: kCaption1,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: kSmallSize,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Chuva: ${_reports[index]['forecast']['rain']}mm',
                                      style: kCaption1,
                                    ),
                                    Text(
                                      'Temperatura: ${_reports[index]['forecast']['temperature']}°C',
                                      style: kCaption1,
                                    ),
                                    Text(
                                      'Umidade: ${_reports[index]['forecast']['humidity']}%',
                                      style: kCaption1,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Vento: ${_reports[index]['forecast']['wind']}km/h',
                                      style: kCaption1,
                                    ),
                                    Text(
                                      'UV: ${_reports[index]['forecast']['uv']}',
                                      style: kCaption1,
                                    ),
                                    Text(
                                      'Pressão: ${_reports[index]['forecast']['pressure']}hPa',
                                      style: kCaption1,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: kSmallSize,
                            ),
                            Text(
                              _reports[index]['observations'],
                              style: kCaption2,
                            ),
                          ],
                        ),
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
