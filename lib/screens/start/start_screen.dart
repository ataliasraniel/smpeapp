import 'package:flutter/material.dart';
import 'package:smpeapp/components/buttons/primary_button.dart';
import 'package:smpeapp/core/constants/app_number_constants.dart';
import 'package:smpeapp/core/constants/style_constants.dart';
import 'package:smpeapp/screens/admin/screens/home/admin_home.dart';
import 'package:smpeapp/screens/home.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Bem vindo ao SMPE', style: kBody2),
            Text('Escolha uma opção'),
            SizedBox(height: kMediumSize),
            PrimaryButton(
                text: 'Admin',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminHome()),
                  );
                },
                icon: Icons.admin_panel_settings),
            SizedBox(height: kSmallSize),
            Text('Cadastre e gerencie usuários, sensores e alertas'),
            SizedBox(height: kMediumSize),
            Divider(),
            PrimaryButton(
                text: 'Usuário',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                icon: Icons.person),
            SizedBox(height: kSmallSize),
            Text('Visualize alertas e monitore sensores'),
            //version
            SizedBox(height: kMediumSize),
            Text('Versão: 1.0.0', style: kCaption2),
          ],
        ),
      ),
    );
  }
}
