import 'package:flutter/material.dart';

// import '../core/preferences_manager.dart';
import 'app_enums.dart';
import 'style_constants.dart';

class AppTheme with ChangeNotifier {
  CurrentAppTheme _currentAppTheme = CurrentAppTheme.dark;
  CurrentAppTheme get currentAppTheme => _currentAppTheme;
  ThemeData getCurrentTheme(BuildContext context) {
    return _currentAppTheme == CurrentAppTheme.light ? getLightTheme(context) : getDarkTheme(context);

    // PreferencesManager.getTheme().then((value) {
    //   if (value) {00
    //     _currentAppTheme = CurrentAppTheme.dark;
    //     notifyListeners();
    //   } else {
    //     _currentAppTheme = CurrentAppTheme.light;
    //   }
    // }).catchError((e) {
    //   _currentAppTheme = CurrentAppTheme.light;
    // });
    // if (_currentAppTheme == CurrentAppTheme.light) {
    //   return getLightTheme(context);
    // } else {
    //   return getDarkTheme(context);
    // }
  }

  void toggleAppTheme() {
    if (_currentAppTheme == CurrentAppTheme.light) {
      _currentAppTheme = CurrentAppTheme.dark;
      notifyListeners();
    } else {
      _currentAppTheme = CurrentAppTheme.light;
      notifyListeners();
    }
    // PreferencesManager.saveTheme(_currentAppTheme == CurrentAppTheme.dark ? true : false);
  }

  void setAppTheme(String savedTheme) {
    if (savedTheme == 'dark') {
      _currentAppTheme = CurrentAppTheme.dark;
      notifyListeners();
    } else {
      _currentAppTheme = CurrentAppTheme.light;
      notifyListeners();
    }
  }

  static ThemeData getLightTheme(BuildContext context) {
    return ThemeData(
      // scaffoldBackgroundColor: kBackgroundColor,
      useMaterial3: true,
      fontFamily: kDefaultFontFamily,
      appBarTheme: const AppBarTheme(
        backgroundColor: kPrimaryColor,
      ),
      // textTheme: TextTheme(titleMedium: kTitle2.copyWith(color: kTextColor)),
    );
  }

  static ThemeData getDarkTheme(BuildContext context) {
    return ThemeData.dark(
      useMaterial3: true,

      // scaffoldBackgroundColor: kPrimaryDarkColor,
      // // cardColor: kSecondaryDarkColor,
      // appBarTheme: const AppBarTheme(
      //     backgroundColor: Colors.transparent,
      //     titleTextStyle: kBody1,
      //     surfaceTintColor: Colors.white,
      //     iconTheme: IconThemeData(color: Colors.white)),
      // inputDecorationTheme: const InputDecorationTheme(hintStyle: kCaption2),
      // textTheme: TextTheme(
      //   titleMedium: kBody3.copyWith(color: kDarkTextColor),
      //   titleLarge: kBody3.copyWith(color: kDarkTextColor),
      //   bodySmall: kBody2.copyWith(color: kDarkTextColor),
      //   bodyLarge: kBody3.copyWith(color: kDarkTextColor),
      //   bodyMedium: kBody3.copyWith(color: kDarkTextColor),
      //   headlineSmall: kBody3.copyWith(color: kDarkTextColor),
      //   headlineMedium: kBody3.copyWith(color: kDarkTextColor),
      //   headlineLarge: kBody3.copyWith(color: kDarkTextColor),
      // ),
    );
  }
}
