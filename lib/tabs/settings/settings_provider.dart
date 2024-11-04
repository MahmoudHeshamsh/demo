import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String languageCode = 'en';

  SettingsProvider() {
    getTheme();
    getLanguage();
  }

  void changeThemeMode(ThemeMode selectedThemeMode) {
    themeMode = selectedThemeMode;
    saveTheme(selectedThemeMode);
    notifyListeners();
  }

  void changeLanguage(String selectedLanguage) {
    languageCode = selectedLanguage;
    saveLanguage(languageCode);
    notifyListeners();
  }

  void saveLanguage(String language) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (language == 'ar') {
      prefs.setString("language", 'ar');
    } else {
      prefs.setString("language", 'en');
    }
  }

  void getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String lang = prefs.getString('language') ?? 'en';

    if (lang == 'ar') {
      languageCode = 'ar';
    } else {
      languageCode = 'en';
    }
    notifyListeners();
  }

  void saveTheme(ThemeMode theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (theme == ThemeMode.light) {
      prefs.setString("theme", "light");
    } else {
      prefs.setString("theme", "dark");
    }
  }

  void getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String cashedTheme = prefs.getString("theme") ?? "light";
    if (cashedTheme == 'light') {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }
}
