import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/language_provider.dart';
import '../l10n/translations.dart';
import '../theme.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.currentLanguage;
    final supportedLanguages = languageProvider.supportedLanguagesList;
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.languageSettings),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: AppColors.surface,
        child: ListView.builder(
          itemCount: supportedLanguages.length,
          itemBuilder: (context, index) {
            final language = supportedLanguages[index];
            final isSelected = language.code == currentLanguage.code;

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  width: 2,
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                leading: Text(
                  language.flag,
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(
                  language.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: isSelected
                    ? Icon(
                        Icons.check_circle,
                        color: AppColors.primary,
                        size: 24,
                      )
                    : null,
                onTap: () {
                  languageProvider.setLanguage(language);
                  Navigator.pop(context);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
