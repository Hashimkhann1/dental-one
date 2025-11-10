import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;

class LanguageNotifier extends StateNotifier<Locale> {
  LanguageNotifier() : super(const Locale('ar')) {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCode = prefs.getString('language_code');

    if (savedCode != null) {
      // Use saved preference
      state = Locale(savedCode);
    } else {
      // Detect language for first-time users
      String systemLang;

      if (kIsWeb) {
        // ✅ For web — detect browser language correctly
        systemLang = html.window.navigator.language.toLowerCase();
      } else {
        // ✅ For mobile/desktop
        systemLang = ui.window.locale.languageCode.toLowerCase();
      }

      if (systemLang.startsWith('en')) {
        state = const Locale('en');
      } else {
        state = const Locale('ar');
      }
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', languageCode);
    state = Locale(languageCode);
  }
}

final languageProvider = StateNotifierProvider<LanguageNotifier, Locale>((ref) {
  return LanguageNotifier();
});
