import 'package:flutter/material.dart';

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
              Text(
                'Sensores',
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "cameras",
                style: TextStyle(fontSize: 24),
              ),
              ListTile(
                title: Text("camera1"),
              ),
              ListTile(
                title: Text(
                  "camera2",
                ),
                subtitle: Text("olaaaa"),
                trailing: Text("status: ATIVO"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
