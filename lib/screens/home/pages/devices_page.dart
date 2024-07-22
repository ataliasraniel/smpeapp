import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smpeapp/core/constants/app_number_constants.dart';
import 'package:smpeapp/core/constants/style_constants.dart';
import 'package:smpeapp/core/models/camera_model.dart';
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
                    const SizedBox(height: kSmallSize),
                    Expanded(
                        child: Column(
                      children: <Widget>[
                        Expanded(
                          child: FutureBuilder(
                              future: _homeScreenController.fetchCameras(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(
                                      child: Column(
                                    children: <Widget>[
                                      Skeletonizer(
                                          enabled: true,
                                          child: GridView.count(
                                              shrinkWrap: true,
                                              crossAxisCount: 2,
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
                                if (snapshot.hasError) {
                                  return Center(child: Text('Erro ao carregar as câmeras' + snapshot.error.toString()));
                                }
                                if (snapshot.hasData) {
                                  final cameras = snapshot.data as List<CameraModel>;
                                  return GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: kSmallSize,
                                      mainAxisSpacing: kSmallSize,
                                      childAspectRatio: 0.6,
                                    ),
                                    itemCount: cameras.length,
                                    itemBuilder: (context, index) {
                                      final camera = cameras[index];
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
                                              camera.imgsData!.isEmpty
                                                  ? const SizedBox()
                                                  : Expanded(
                                                      flex: 3,
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                              decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(kSmallSize),
                                                            image: camera.imgsData!.isEmpty
                                                                ? null
                                                                : DecorationImage(
                                                                    image: NetworkImage(camera.imgsData!.first.imageUrl!),
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                          )),
                                                          Padding(
                                                            padding: EdgeInsets.all(8.0),
                                                            child: Container(
                                                                padding: EdgeInsets.all(4.0),
                                                                decoration: BoxDecoration(
                                                                  color: Colors.black.withOpacity(0.5),
                                                                  borderRadius: BorderRadius.circular(4.0),
                                                                ),
                                                                child: Text('Última foto Hoje, às 12:40',
                                                                    style: kCaption1.copyWith(color: Colors.white))),
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
                                                    Text('${camera.name} ${camera.address}', style: kBody3),
                                                    const SizedBox(height: kSmallSize),
                                                    // Text('Status: ${camera.status.name}', style: kCaption2),
                                                    camera.observation == null
                                                        ? const SizedBox()
                                                        : Text(
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
                                  );
                                }
                                return Container();
                              }),
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
                                            Text(levelSensor.name!, style: kBody3.copyWith(fontWeight: FontWeight.bold)),
                                            const SizedBox(height: kSmallSize),
                                            //ultimo registro
                                            Text('Última medição: ${levelSensor.levelsData?.first.level}', style: kCaption2),
                                            Text('Status: ${levelSensor.status!}', style: kCaption2),
                                            const Text(
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
                                            const Text(
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
