import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_enums.dart';
import '../managers/app_snack_bar_manager.dart';

class Utils {
  static double calculateRecipeAverageScore(List<dynamic>? data) {
    if (data == null || data.isEmpty) {
      return 5;
    }
    if (data.length >= 2) {
      double finalRate = 0;
      for (var i = 0; i < data.length; i++) {
        finalRate += data[i].toDouble();
      }
      return double.parse((finalRate / data.length).toStringAsFixed(1));
    } else if (data.length == 1) {
      return data.first.toDouble();
    }
    return 0;
  }

  static String formatPixKey(String key) {
    if (key.length == 11) {
      return key.replaceAllMapped(RegExp(r"(\d{3})(\d{3})(\d{3})(\d{2})"), (match) => "${match[1]}.${match[2]}.${match[3]}-${match[4]}");
    } else if (key.length == 14) {
      return key.replaceAllMapped(
          RegExp(r"(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})"), (match) => "${match[1]}.${match[2]}.${match[3]}/${match[4]}-${match[5]}");
    }
    return key;
  }

  static void saveDataToClipboard(String url) {
    Clipboard.setData(ClipboardData(text: url));
    AppSnackbarManager.showSimpleNotification(NotificationType.success, 'Copiado para a área de transferência!');
  }

  static Uint8List base64ToImage(String imageString) {
    final newImageString = imageString.replaceAll(RegExp(r'data:image\/\w+;base64,'), '');
    return base64Decode(newImageString);
  }

  static String calculatePersonAgeByBirthDate(String value) {
    DateTime dataAtual = DateTime.now();
    //date comes in format 1997-07-01
    List<String> date = value.split('-');
    int ano = int.parse(date[0]);
    int mes = int.parse(date[1]);
    int dia = int.parse(date[2]);
    int idade = dataAtual.year - ano;
    if (dataAtual.month < mes) {
      idade--;
    } else if (dataAtual.month == mes) {
      if (dataAtual.day < dia) {
        idade--;
      }
    }
    return idade.toString();
  }

  static Color getStatusColor(String status) {
    switch (status) {
      case 'DESATIVATED':
        return Colors.red;
      case 'DAMAGED':
        return Colors.yellow;
      case 'NORMAL':
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}
