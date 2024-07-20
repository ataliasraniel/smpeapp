import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../constants/app_enums.dart';
import '../constants/style_constants.dart';

class AppSnackbarManager {
  static void showSimpleNotification(NotificationType type, [String? title, String? subtitle]) {
    Color typeColor;
    String notificationTitle;

    switch (type) {
      case NotificationType.success:
        typeColor = kSuccessColor;
        notificationTitle = 'Sucesso!';
        break;
      case NotificationType.error:
        typeColor = kErrorColor;
        notificationTitle = 'Puxa, alguma coisa deu errado...';

        break;
      case NotificationType.alert:
        typeColor = kAlertColor;
        notificationTitle = 'Ei, isso não está certo';

        break;
      default:
        typeColor = kSuccessColor;
        notificationTitle = 'Sucesso!';
    }
    BotToast.showSimpleNotification(
        titleStyle: kCaption1.copyWith(color: Colors.white),
        title: title ?? notificationTitle,
        backgroundColor: typeColor,
        subTitle: subtitle,
        subTitleStyle: kCaption2.copyWith(color: Colors.white),
        align: Alignment.topCenter,
        closeIcon: const Icon(Icons.close_rounded, color: Colors.white),
        duration: const Duration(seconds: 5));
  }
}
