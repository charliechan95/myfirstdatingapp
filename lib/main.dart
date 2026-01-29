import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'services/notification_service.dart';
import 'services/payment_service.dart';
import 'services/firebase_service.dart';
import 'nav.dart';
import 'l10n/language_provider.dart';
import 'l10n/app_localizations_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService().initialize().catchError((error) {
    print('Firebase initialization failed: $error');
  });
  NotificationCenter.init().catchError((error) {
    print('Notification initialization failed: $error');
  });
  PaymentService.initialize().catchError((error) {
    print('Payment initialization failed: $error');
  });

  final languageProvider = await createLanguageProvider();
  
  runApp(LanguageScope(
    languageProvider: languageProvider,
    child: MyApp(languageProvider: languageProvider),
  ));
}

class MyApp extends StatelessWidget {
  final LanguageProvider languageProvider;

  const MyApp({
    super.key,
    required this.languageProvider,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageProvider>.value(
      value: languageProvider,
      child: Consumer<LanguageProvider>(
        builder: (context, provider, child) {
          return MaterialApp.router(
            title: 'SoulMatch',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            routerConfig: router,
            locale: provider.currentLocale,
            supportedLocales: [
              const Locale('en', 'US'),
              const Locale('zh', 'CN'),
              const Locale('zh', 'TW'),
              const Locale('ja', 'JP'),
              const Locale('ko', 'KR'),
              const Locale('fr', 'FR'),
              const Locale('de', 'DE'),
              const Locale('es', 'ES'),
            ],
            localizationsDelegates: [
              AppLocalizationsDelegate(
                overriddenLocale: provider.currentLocale,
              ),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}
