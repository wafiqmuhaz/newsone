import 'package:flutter/material.dart';

class Utils {
  static String localeToCountryName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'id':
        return 'Indonesia';
      case 'es':
        return 'Espanol';
      default:
        return 'English';
    }
  }
}
