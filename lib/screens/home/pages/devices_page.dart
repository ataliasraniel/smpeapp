import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smpeapp/core/constants/app_number_constants.dart';
import 'package:smpeapp/core/constants/style_constants.dart';
import 'package:smpeapp/screens/home/home_screen_controller.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  final HomeScreenController _homeScreenController = Get.find<HomeScreenController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kMediumSize),
      child: DefaultTabController(
        length: _homeScreenController.filterOptions.length,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Todos os dispositivos',
              style: kBody2,
            ),
            // Wrap(
            //   children: List.generate(_homeScreenController.filterOptions.length, (index) {
            //     final filter = _homeScreenController.filterOptions[index];
            //     return Container(
            //       margin: const EdgeInsets.only(right: kSmallSize),
            //       child: ChoiceChip(
            //           label: Text(filter['name']),
            //           selected: _homeScreenController.selectedIndex == index,
            //           onSelected: (selected) {
            //             if (selected) {
            //               // _homeScreenController.changePageByFilter(filter['id']);
            //             }
            //           }),
            //     );
            //   }),
            // )
            TabBar(
              indicatorColor: Colors.transparent,
              labelColor: kDetailColor,
              unselectedLabelColor: kTextColor,
              tabs: List.generate(_homeScreenController.filterOptions.length, (index) {
                final filter = _homeScreenController.filterOptions[index];
                return Tab(
                  icon: Icon(filter['icon']),
                  text: filter['name'],
                );
              }),
            ),
            Expanded(
              child: TabBarView(children: [
                Column(
                  children: <Widget>[
                    Text('Câmeras', style: kBody3),
                    const SizedBox(height: kSmallSize),
                    if (_homeScreenController.cameras == null)
                      Center(child: CircularProgressIndicator())
                    else
                      Expanded(
                          child: Column(
                        children: <Widget>[
                          Expanded(
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: kSmallSize,
                                mainAxisSpacing: kSmallSize,
                                childAspectRatio: 0.6,
                              ),
                              itemCount: _homeScreenController.cameras!.length,
                              itemBuilder: (context, index) {
                                final camera = _homeScreenController.cameras![index];
                                return SlideInUp(
                                  duration: Duration(milliseconds: 200 * index),
                                  child: Container(
                                    padding: const EdgeInsets.all(kSmallSize),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(kSmallSize),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10,
                                          offset: Offset(0, 5),
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: Stack(
                                            children: [
                                              Container(
                                                color: Colors.grey,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('Última foto Hoje, às 12:40', style: kCaption1),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: kSmallSize),
                                        Expanded(
                                            child: SizedBox(
                                          width: double.maxFinite,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('${camera.name} - ${camera.address}', style: kBody3),
                                              const SizedBox(height: kSmallSize),
                                              // Text('Status: ${camera.status.name}', style: kCaption2),
                                              Text(
                                                'Observação: ${camera.observation}',
                                                style: kCaption2,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ))
                  ],
                ),
                Column(
                  children: <Widget>[
                    const Text('Sensores de nível', style: kBody3),
                    const SizedBox(height: kSmallSize),
                    Expanded(
                        child: Column(
                      children: <Widget>[
                        Expanded(
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: kSmallSize,
                              mainAxisSpacing: kSmallSize,
                              childAspectRatio: 1.6,
                            ),
                            itemCount: _homeScreenController.levelSensors.length,
                            itemBuilder: (context, index) {
                              final levelSensor = _homeScreenController.levelSensors[index];
                              return SlideInUp(
                                duration: Duration(milliseconds: 200 * index),
                                child: Container(
                                  padding: const EdgeInsets.all(kSmallSize),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(kSmallSize),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      const SizedBox(height: kSmallSize),
                                      Expanded(
                                          child: SizedBox(
                                        width: double.maxFinite,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(levelSensor.name, style: kBody3.copyWith(fontWeight: FontWeight.bold)),
                                            const SizedBox(height: kSmallSize),
                                            //ultimo registro
                                            Text('Última medição: ${levelSensor.levelsData.first.level}', style: kCaption2),
                                            Text('Status: ${levelSensor.status.name}', style: kCaption2),
                                            Text(
                                              'Observação: ',
                                              style: kCaption2,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
                Column(
                  children: <Widget>[
                    //SENSORES DE CHUVA
                    const Text('Sensores de chuva', style: kBody3),
                    const SizedBox(height: kSmallSize),
                    Expanded(
                        child: Column(
                      children: <Widget>[
                        Expanded(
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: kSmallSize,
                              mainAxisSpacing: kSmallSize,
                              childAspectRatio: 1.6,
                            ),
                            itemCount: _homeScreenController.precipitations.length,
                            itemBuilder: (context, index) {
                              final rainSensor = _homeScreenController.precipitations[index];
                              return SlideInUp(
                                duration: Duration(milliseconds: 200 * index),
                                child: Container(
                                  padding: const EdgeInsets.all(kSmallSize),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(kSmallSize),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      const SizedBox(height: kSmallSize),
                                      Expanded(
                                          child: SizedBox(
                                        width: double.maxFinite,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(rainSensor.name, style: kBody3.copyWith(fontWeight: FontWeight.bold)),
                                            const SizedBox(height: kSmallSize),
                                            //ultimo registro
                                            Text('Última medição: ${rainSensor.precipitationsData.first.precipitation}', style: kCaption2),
                                            Text('Status: ${rainSensor.status.name}', style: kCaption2),
                                            Text(
                                              'Observação: ',
                                              style: kCaption2,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
