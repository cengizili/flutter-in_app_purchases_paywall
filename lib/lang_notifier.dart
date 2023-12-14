import 'dart:async';

import 'package:auto_localization/auto_localization.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';


class LangNotifier extends ChangeNotifier {
  LangNotifier({this.isDefault=true});

  bool isDefault;
  String? locale;

  final _languageChangeController = StreamController<void>.broadcast();

  Stream<void> get onLanguageChange => _languageChangeController.stream;
  
  String get lowerLocale => locale?.split("-").firstOrNull ?? "en";
  String get upperLocale => locale?.split("-").lastOrNull ?? "US";

  Future<void> init() async {
    locale = await Devicelocale.currentLocale;
    await AutoLocalization.init(
      appLanguage: 'en',
      userLanguage: 'tr'
      );
    notifyListeners();
  }
  
  void changeDefault() {
    isDefault = !isDefault;
    _languageChangeController.add(null);
    notifyListeners();
  }

}