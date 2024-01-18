import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class CommonUtils {
  static void changeTheme(BuildContext context) {
    if (AdaptiveTheme.of(context).mode.isDark) {
      AdaptiveTheme.of(context).setLight();
    } else {
      AdaptiveTheme.of(context).setDark();
    }
  }
}
