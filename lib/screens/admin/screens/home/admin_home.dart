import 'package:flutter/material.dart';
import 'package:smpeapp/components/buttons/primary_button.dart';
import 'package:smpeapp/core/constants/app_number_constants.dart';

import '../cameras/cameras_screen.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(items: const [
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text('Bem vindo ao Admin'),
              Text('Sensores'),
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
                  onTap: () {},
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
              PrimaryButton(text: 'Iniciar Relatório Manual', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
