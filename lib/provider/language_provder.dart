import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = Locale('en', 'ar'); // Default language

  Locale get locale => _locale;

  void changeLanguage(BuildContext context, Locale newLocale) {
    if (_locale != newLocale) {
      _locale = newLocale;
      context.setLocale(newLocale); // EasyLocalization updates the locale
      notifyListeners(); // Notify the UI
    }
  }
}