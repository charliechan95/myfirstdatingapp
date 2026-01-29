import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'language_model.dart';

class LanguageProvider with ChangeNotifier {
  Locale? _currentLocale;
  final SharedPreferences _prefs;
  static const String _languageKey = 'selected_language';

  LanguageProvider(this._prefs) {
    _initLocale();
  }

  void _initLocale() {
    final savedLanguageCode = _prefs.getString(_languageKey);
    if (savedLanguageCode != null) {
      final language = supportedLanguages.firstWhere(
        (lang) => lang.code == savedLanguageCode,
        orElse: () => supportedLanguages.first,
      );
      _currentLocale = language.locale;
    } else {
      _currentLocale = supportedLanguages.first.locale;
    }
  }

  Locale get currentLocale => _currentLocale ?? supportedLanguages.first.locale;

  Language get currentLanguage => supportedLanguages.firstWhere(
        (lang) => lang.locale == _currentLocale,
        orElse: () => supportedLanguages.first,
      );

  Future<void> setLanguage(Language language) async {
    _currentLocale = language.locale;
    await _prefs.setString(_languageKey, language.code);
    notifyListeners();
  }

  List<Language> get supportedLanguagesList => supportedLanguages;
}

Future<LanguageProvider> createLanguageProvider() async {
  final prefs = await SharedPreferences.getInstance();
  return LanguageProvider(prefs);
}

class LanguageScope extends StatelessWidget {
  final LanguageProvider languageProvider;
  final Widget child;

  const LanguageScope({
    super.key,
    required this.languageProvider,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageProvider>.value(
      value: languageProvider,
      child: child,
    );
  }
}
