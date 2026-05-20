import 'package:flutter/material.dart';
import 'user_model.dart';

// ── Paleta ──────────────────────────────────────────────────────────
const kBgColor       = Color(0xFF0F0F1A);
const kSurfaceColor  = Color(0xFF1C1C2E);
const kCardColor     = Color(0xFF252538);
const kAccentColor   = Color(0xFF7C6FFF);
const kTextPrimary   = Color(0xFFEEEEFF);
const kTextSecondary = Color(0xFF8888AA);

// Ligas
const kBronze   = Color(0xFFCD7F32);
const kPrata    = Color(0xFFB0BEC5);
const kOuro     = Color(0xFFFFD700);
const kDiamante = Color(0xFF64B5F6);

Color ligaColor(Liga l) {
  switch (l) {
    case Liga.bronze:   return kBronze;
    case Liga.prata:    return kPrata;
    case Liga.ouro:     return kOuro;
    case Liga.diamante: return kDiamante;
  }
}

String ligaLabel(Liga l) {
  switch (l) {
    case Liga.bronze:   return 'Bronze';
    case Liga.prata:    return 'Prata';
    case Liga.ouro:     return 'Ouro';
    case Liga.diamante: return 'Diamante';
  }
}

String ligaEmoji(Liga l) {
  switch (l) {
    case Liga.bronze:   return '🥉';
    case Liga.prata:    return '🥈';
    case Liga.ouro:     return '🥇';
    case Liga.diamante: return '💎';
  }
}

ThemeData buildTheme() => ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: kBgColor,
  colorScheme: const ColorScheme.dark(
    primary: kAccentColor,
    surface: kSurfaceColor,
  ),
  fontFamily: 'Roboto',
  appBarTheme: const AppBarTheme(
    backgroundColor: kSurfaceColor,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: kTextPrimary,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
    ),
    iconTheme: IconThemeData(color: kTextPrimary),
  ),
  tabBarTheme: const TabBarThemeData(
    labelColor: kAccentColor,
    unselectedLabelColor: kTextSecondary,
    indicatorColor: kAccentColor,
  ),
);
