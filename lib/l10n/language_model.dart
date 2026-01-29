import 'package:flutter/material.dart';

class Language {
  final String code;
  final String name;
  final String flag;
  final Locale locale;

  const Language({
    required this.code,
    required this.name,
    required this.flag,
    required this.locale,
  });
}

const supportedLanguages = [
  Language(
    code: 'en',
    name: 'English',
    flag: '🇺🇸',
    locale: Locale('en', 'US'),
  ),
  Language(
    code: 'zh_CN',
    name: '简体中文',
    flag: '🇨🇳',
    locale: Locale('zh', 'CN'),
  ),
  Language(
    code: 'zh_TW',
    name: '繁體中文',
    flag: '🇹🇼',
    locale: Locale('zh', 'TW'),
  ),
  Language(
    code: 'ja',
    name: '日本語',
    flag: '🇯🇵',
    locale: Locale('ja', 'JP'),
  ),
  Language(
    code: 'ko',
    name: '한국어',
    flag: '🇰🇷',
    locale: Locale('ko', 'KR'),
  ),
  Language(
    code: 'fr',
    name: 'Français',
    flag: '🇫🇷',
    locale: Locale('fr', 'FR'),
  ),
  Language(
    code: 'de',
    name: 'Deutsch',
    flag: '🇩🇪',
    locale: Locale('de', 'DE'),
  ),
  Language(
    code: 'es',
    name: 'Español',
    flag: '🇪🇸',
    locale: Locale('es', 'ES'),
  ),
];
