import 'package:flutter/material.dart';
import 'translations.dart';
import 'en_translations.dart';
import 'zh_cn_translations.dart';
import 'zh_tw_translations.dart';
import 'fr_translations.dart';
import 'ja_translations.dart';
import 'ko_translations.dart';
import 'es_translations.dart';
import 'de_translations.dart';
import 'language_model.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Translations> {
  final Locale overriddenLocale;

  const AppLocalizationsDelegate({this.overriddenLocale = const Locale('en', 'US')});

  @override
  bool isSupported(Locale locale) {
    return supportedLanguages.any((language) => language.locale.languageCode == locale.languageCode);
  }

  @override
  Future<Translations> load(Locale locale) {
    final actualLocale = overriddenLocale.languageCode.isNotEmpty ? overriddenLocale : locale;
    print('Loading translations for locale: ${actualLocale.languageCode}_${actualLocale.countryCode}');

    switch (actualLocale.languageCode) {
      case 'zh':
        if (actualLocale.countryCode == 'TW') {
          return Future.value(ZhTwTranslations());
        }
        return Future.value(ZhCnTranslations());
      case 'en':
        return Future.value(EnTranslations());
      case 'fr':
        return Future.value(FrTranslations());
      case 'ja':
        return Future.value(JaTranslations());
      case 'ko':
        return Future.value(KoTranslations());
      case 'de':
        return Future.value(DeTranslations());
      case 'es':
        return Future.value(EsTranslations());
      default:
        return Future.value(EnTranslations());
    }
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) {
    return old.overriddenLocale != overriddenLocale;
  }

  static AppLocalizationsDelegate of(BuildContext context) {
    return Localizations.of<AppLocalizationsDelegate>(context, AppLocalizationsDelegate)!;
  }
}
