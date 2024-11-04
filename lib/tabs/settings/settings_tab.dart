import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/auth/login_screen.dart';
import 'package:todo_app/auth/user_provider.dart';
import 'package:todo_app/tabs/settings/language.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  SettingsProvider? settingsProvider;
  ThemeMode currentTheme = ThemeMode.light;

   List<Language> languages = [
    Language(name: 'English', code: 'en'),
    Language(name: 'العربية', code: 'ar'),
  ];


  List<String> themeModeNames = [
    'Light Mode',
    'Dark Mode',
  ];

  String themeModeToString(ThemeMode mode) {
    return mode == ThemeMode.light ? 'Light Mode' : 'Dark Mode';
  }

  ThemeMode stringToThemeMode(String mode) {
    return mode == 'Light Mode' ? ThemeMode.light : ThemeMode.dark;
  }

  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of<SettingsProvider>(context);
    currentTheme = settingsProvider!.themeMode;

    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.20,
          width: double.infinity,
          color: AppTheme.primary,
        ),
        PositionedDirectional(
          top: MediaQuery.of(context).size.height * 0.09,
          start: 30,
          child: Text(
            AppLocalizations.of(context)!.settings,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: 25, fontWeight: FontWeight.w600),
          ),
        ),
        PositionedDirectional(
            top: MediaQuery.of(context).size.height * 0.09,
            end: 30,
            child: IconButton(
                onPressed: () {
                  Provider.of<UserProvider>(context, listen: false)
                      .updateUser(null);
                  Provider.of<TasksProvider>(context, listen: false).tasks = [];
                  Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                },
                icon: Icon(
                  Icons.logout,
                  color: settingsProvider!.themeMode == ThemeMode.light
                      ? AppTheme.white
                      : AppTheme.black,
                ))),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.sizeOf(context).height * 0.5, right: 9, left: 9),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.dark_mode,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: AppTheme.primary),
                  ),
                  DropdownButton<String>(
                    value: themeModeToString(currentTheme),
                    items: themeModeNames.map((String mode) {
                      return DropdownMenuItem<String>(
                        value: mode,
                        child: Text(
                          mode,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppTheme.primary),
                        ),
                      );
                    }).toList(),
                    onChanged: (selectedMode) {
                      if (selectedMode != null) {
                        ThemeMode newTheme = stringToThemeMode(selectedMode);
                        settingsProvider?.changeThemeMode(newTheme);
                      }
                    },
                    borderRadius: BorderRadius.circular(20),
                    dropdownColor: settingsProvider!.themeMode == ThemeMode.light
                        ? AppTheme.white
                        : AppTheme.black,
                  ),
                ],
              ),
               Padding(
          padding: EdgeInsets.symmetric(horizontal: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.language,
                style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: AppTheme.primary),
              ),
              DropdownButton<Language>(
                  value: languages.firstWhere((language) => language.code == settingsProvider!.languageCode),
                  items: languages
                      .map((language) => DropdownMenuItem<Language>(
                          value: language, child: Text(
                            language.name,
                            style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: AppTheme.primary),
                            )))
                      .toList(),
                  onChanged: (selectedLanguage) {
                    if (selectedLanguage != null) {
                      settingsProvider!.changeLanguage(selectedLanguage.code);
                    }
                  },
                  borderRadius: BorderRadius.circular(20),
                  dropdownColor: settingsProvider!.themeMode == ThemeMode.light
                        ? AppTheme.white
                        : AppTheme.black,
                  )
            ],
          ),
        
          )],
          ),
        ),
      ],
    );
  }
}
