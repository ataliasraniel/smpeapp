import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smpeapp/core/constants/style_constants.dart';
import 'package:smpeapp/screens/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: kDefaultFontFamily),
      home: Home(),
      title: 'SMPE - Sistema de Monitoramento e Prevenção de Enchentes',
    );
  }
}
