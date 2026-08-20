import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_provider.g.dart';

@riverpod
class AppLocaleNotifier extends _$AppLocaleNotifier {
  @override
  Locale build() {
    // Default language is Arabic (RTL)
    _loadSavedLocale();
    return const Locale('ar');
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCode = prefs.getString('app_locale');
    if (savedCode != null) {
      state = Locale(savedCode);
    }
  }

  Future<void> setLocale(Locale newLocale) async {
    state = newLocale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_locale', newLocale.languageCode);
  }

  void toggleLocale() {
    if (state.languageCode == 'ar') {
      setLocale(const Locale('fr'));
    } else {
      setLocale(const Locale('ar'));
    }
  }
}
