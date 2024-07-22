import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smpeapp/core/constants/app_number_constants.dart';
import 'package:smpeapp/core/constants/style_constants.dart';
import 'package:smpeapp/core/managers/api_manager.dart';
import 'package:smpeapp/core/models/report_model.dart';
import 'package:smpeapp/core/utils/date_format_utils.dart';
import 'package:smpeapp/screens/home/home_screen_controller.dart';
import 'package:smpeapp/screens/home/pages/devices_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeScreenController(),
        builder: (controller) {
          return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: kDetailColor,
                unselectedItemColor: kTextColor,
                currentIndex: controller.selectedIndex,
                onTap: (index) {
                  controller.changePage(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Início',
                  ),
                  BottomNavigationBarItem(
                    label: 'Dispositivos',
                    icon: Icon(Icons.devices),
                  ),
                ],
              ),
              appBar: AppBar(
                title: const Text('SMPE'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: PageView(
                  controller: controller.pageController,
                  children: [const HomePage(), const DevicesPage()],
                ),
              ));
        });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiManager _apiManager = ApiManager();

  Future<List<ReportModel>> _getReports() async {
    final List<ReportModel> reports = [];
    try {
      final response = await _apiManager.getData('/report');
      for (final report in response['data']) {
        reports.add(ReportModel.fromJson(report));
      }
      return reports;
    } catch (e) {
      return Future.error(e);
    }
  }

  Color _getColorByAlertLevel(String alertLevel) {
    //   MINIMUM
    // MEDIUM
    // HIGH
    // EXTREME
    switch (alertLevel) {
      case 'MINIMUM':
        return Colors.green;
      case 'MEDIUM':
        return Colors.orange;
      case 'HIGH':
        return Colors.red;
      case 'EXTREME':
        return Colors.deepOrange;
      default:
        return Colors.grey;
    }
  }

  String _getLevelTranslated(String alertLevel) {
    switch (alertLevel) {
      case 'MINIMUM':
        return 'Mínimo';
      case 'MEDIUM':
        return 'Médio';
      case 'HIGH':
        return 'Alto';
      case 'EXTREME':
        return 'Extremo';
      default:
        return 'Desconhecido';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Olá, bom dia. Hoje é ${DateFormatUtils.getTodayDate()}',
          style: kBody2,
        ),
        const SizedBox(
          height: kMediumSize,
        ),
        const Text('Veja os últimos relatórios gerados pelo nosso Guardião'),
        const SizedBox(
          height: kMediumSize,
        ),
        //crie uma lista com os dados acima com um icone para cada status
        Expanded(
          child: FutureBuilder(
              future: _getReports(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: Column(
                    children: <Widget>[
                      Skeletonizer(
                          enabled: true,
                          child: Column(
                              children: List.generate(
                                  6,
                                  (index) => Container(
                                        color: Colors.red,
                                        width: double.maxFinite,
                                        margin: const EdgeInsets.only(bottom: 10),
                                        height: 100,
                                      ))))
                    ],
                  ));
                }
                //if has error
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro ao carregar os dados${snapshot.error}'),
                  );
                } else if (snapshot.data == null) {
                  return const Center(
                    child: Text('Nenhum dado encontrado'),
                  );
                } else {
                  final data = snapshot.data as List<ReportModel>;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return FadeInUp(
                        duration: Duration(milliseconds: 200 * index),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: kMediumSize),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              left: BorderSide(
                                color: _getColorByAlertLevel(data[index].alertLevel!),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Relatório ${data[index].id}'.toUpperCase().substring(0, 16),
                                    style: kBody2.copyWith(
                                      color: _getColorByAlertLevel(data[index].alertLevel!),
                                    ),
                                  ),
                                  // Text(
                                  //   DateFormatUtils.getTodayDate(data[index].createdAt!),
                                  //   style: kBody2,
                                  // ),
                                ],
                              ),
                              //ALER LEVEL
                              Container(
                                decoration: BoxDecoration(
                                  color: _getColorByAlertLevel(data[index].alertLevel!),
                                  borderRadius: BorderRadius.circular(kSmallSize),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: kMediumSize,
                                  vertical: kSmallSize,
                                ),
                                margin: const EdgeInsets.only(top: kSmallSize),
                                child: Text(
                                  'ALERTA:${_getLevelTranslated(data[index].alertLevel!).toUpperCase()}',
                                  style: kBody3.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: kSmallSize,
                              ),
                              Text(
                                data[index].observationText!,
                                style: kCaption2,
                              ),
                              const SizedBox(
                                height: kSmallSize,
                              ),
                              // Row(
                              //   children: <Widget>[
                              //     for (final img in data[index].imgs!)
                              //       Padding(
                              //         padding: const EdgeInsets.only(right: kSmallSize),
                              //         child: Image.network(
                              //           img,
                              //           width: 100,
                              //         ),
                              //       ),
                              //   ],
                              // ),
                              // SizedBox(
                              //     height: 200,
                              //     child: ListView.builder(
                              //       scrollDirection: Axis.horizontal,
                              //       itemCount: data[index].imgs!.length - 1,
                              //       itemBuilder: (context, index) {
                              //         return Padding(
                              //           padding: const EdgeInsets.only(right: kSmallSize),
                              //           child: Image.network(
                              //             data[index].imgs![index],
                              //             width: 100,
                              //           ),
                              //         );
                              //       },
                              //     ))
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
        ),
      ],
    );
  }
}
