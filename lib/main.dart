import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smpeapp/core/constants/style_constants.dart';
import 'package:smpeapp/screens/home.dart';
import 'package:smpeapp/screens/start/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: kDefaultFontFamily),
      home: StartScreen(),
      debugShowCheckedModeBanner: false,
      title: 'SMPE - Sistema de Monitoramento e Prevenção de Enchentes',
    );
  }
}
