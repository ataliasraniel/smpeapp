import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smpeapp/components/buttons/primary_button.dart';
import 'package:smpeapp/core/constants/app_number_constants.dart';
import 'package:smpeapp/core/constants/style_constants.dart';
import 'package:smpeapp/screens/admin/screens/home/new_report_screen.dart';

import '../cameras/cameras_screen.dart';
import '../sensors/sensors_page.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(currentIndex: currentIndex, onTap: changeIndex, items: const [
          BottomNavigationBarItem(
            label: 'Inicio',
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Configuracoes',
            icon: Icon(Icons.settings),
          ),
        ]),
        body: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Bem vindo ao Admin',
                style: kBody2,
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: [
                    Column(
                      children: <Widget>[
                        ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CamerasScreen()),
                              );
                            },
                            title: Text(
                              'Cameras',
                            ),
                            subtitle: Text('Todas as câmeras em operação'),
                            leading: Icon(Icons.videocam),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CamerasScreen()),
                                );
                              },
                            )),
                        //Sensores
                        ListTile(
                            leading: Icon(Icons.sensors),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SensorsScreen()),
                              );
                            },
                            title: Text(
                              'Sensores',
                            ),
                            subtitle: Text('Todos os sensores em operação'),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              ),
                              onPressed: () {},
                            )),
                        //Usuarios
                        Divider(),
                        Text('Gerar Novo Relatório Manual'),
                        SizedBox(
                          height: kSmallSize,
                        ),
                        PrimaryButton(
                            text: 'Iniciar Relatório Manual',
                            onPressed: () {
                              Get.to(() => NewReportScreen());
                            })
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Configurações', style: kBody2),
                        ListTile(
                          title: Text('Sair'),
                          leading: Icon(Icons.logout),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
