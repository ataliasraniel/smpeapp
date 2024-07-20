import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormatUtils {
  static get weekDays => ['Domingo', 'Segunda-feira', 'Terça-feira', 'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'Sábado'];
  final enDays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

  static String formatStringDateTimeToBrDateHourAndMinute(String dateTime,
      [bool onlyTime = false, bool onlyDate = false, bool includeYear = false]) {
    if (dateTime.isEmpty) return '';
    late String value;
    final date = DateTime.parse(dateTime);
    final pureDate = DateFormat('dd/MM${includeYear ? '/yyyy' : ''}').format(date);
    final pureHour = DateFormat('HH:mm').format(date);

    if (onlyTime) {
      value = pureHour;
    } else if (onlyDate) {
      value = pureDate;
    } else {
      if (pureDate == DateFormat('dd/MM').format(DateTime.now())) {
        value = 'Hoje às $pureHour';
      } else if (pureDate == DateFormat('dd/MM').format(DateTime.now().subtract(const Duration(days: 1)))) {
        value = 'Ontem às $pureHour';
      } else {
        value = '$pureDate às $pureHour';
      }
    }

    return value;
  }

  static String countDaysFoward(dynamic value) {
    if (value.runtimeType == String) {
      final date = DateTime.parse(value);
      final now = DateTime.now();
      final difference = date.difference(now).inDays;
      if (difference == 0) {
        return 'Hoje';
      } else if (difference == 1) {
        return 'Amanhã';
      } else if (difference == 2) {
        return 'Depois de Amanhã';
      } else {
        return 'Em $difference dias';
      }
    } else if (value.runtimeType == DateTime) {
      final now = DateTime.now();
      final difference = value.difference(now).inDays;
      if (difference == 0) {
        return 'Hoje';
      } else if (difference == 1) {
        return 'Amanhã';
      } else if (difference == 2) {
        return 'Depois de Amanhã';
      } else {
        return 'Em $difference dias';
      }
    }
    return '';
  }

  static String formatTimeOfDayTo24Hours(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static String formatDateTimeToBrDateHourAndMinute(DateTime dateTime, [bool? includeDayName]) {
    late String value;
    final pureDate = DateFormat('dd/MM').format(dateTime);
    final pureHour = DateFormat('HH:mm').format(dateTime);
    if (pureDate == DateFormat('dd/MM').format(DateTime.now())) {
      value = 'Hoje às $pureHour';
    } else if (pureDate == DateFormat('dd/MM').format(DateTime.now().subtract(const Duration(days: 1)))) {
      value = 'Ontem às $pureHour';
    } else {
      value = '$pureDate às $pureHour';
    }
    if (includeDayName != null && includeDayName) {
      final dayName = DateFormat('EEEE', 'pt_BR').format(dateTime);
      value = '$dayName, $value';
    }
    return value;
  }

  static String formatDateTimeToBrDate(DateTime dateTime, {bool fullyear = false}) {
    if (fullyear) {
      return DateFormat('dd/MM/yyyy').format(dateTime);
    }
    return DateFormat('dd/MM/yy').format(dateTime);
  }

  static String convertBrWeekDayToEnWeekDay(List<String> brWeekDays) {
    if (brWeekDays.isEmpty) return '';
    final weekConversor = <String, String>{
      'Domingo': 'Sunday',
      'Segunda-feira': 'Monday',
      'Terça-feira': 'Tuesday',
      'Quarta-feira': 'Wednesday',
      'Quinta-feira': 'Thursday',
      'Sexta-feira': 'Friday',
      'Sábado': 'Saturday',
    };
    final enWeekDays = <String>[];
    for (final brWeekDay in brWeekDays) {
      enWeekDays.add(weekConversor[brWeekDay] == null ? '' : weekConversor[brWeekDay]!.toLowerCase());
    }
    return enWeekDays.join(',');
  }

  static List<String> convertEnWeekDayToBrWeekDay(List<String> enWeekDays) {
    if (enWeekDays.isEmpty) return [];
    final weekConversor = <String, String>{
      'Sunday'.toLowerCase(): 'Domingo',
      'Monday'.toLowerCase(): 'Segunda-feira',
      'Tuesday'.toLowerCase(): 'Terça-feira',
      'Wednesday'.toLowerCase(): 'Quarta-feira',
      'Thursday'.toLowerCase(): 'Quinta-feira',
      'Friday'.toLowerCase(): 'Sexta-feira',
      'Saturday'.toLowerCase(): 'Sábado',
    };
    final brWeekDays = <String>[];
    for (final enWeekDay in enWeekDays) {
      brWeekDays.add(weekConversor[enWeekDay] ?? '');
    }
    return brWeekDays;
  }

  static formatDateTimeToAmericanDate(DateTime parse, {required bool fullyear}) {
    if (fullyear) {
      return DateFormat('yyyy-MM-dd').format(parse);
    }
    return DateFormat('yy-MM-dd').format(parse);
  }

  static String parseBrDateToDateTime(String text) {
    if (text.isEmpty) return '';
    return DateTime.parse(text.split('/').reversed.join('-')).toString();
  }

  static String formatDateIntoBackendAcceptable(String value) {
    final List<String> date = value.split('/');
    return '${date[2]}-${date[1]}-${date[0]}';
  }

  static String parseYYYYMMDDToBrDate(String text) {
    if (text.isEmpty) return '';
    //it must returns 01/01/2021
    return text.split('-').reversed.join('/');
  }

  static String getTodayDate() {
    return DateFormat('dd/MM/yyyy').format(DateTime.now());
  }
}
