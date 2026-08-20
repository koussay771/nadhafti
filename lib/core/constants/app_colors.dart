import 'package:flutter/material.dart';

/// Nadhafti Design Token — Colors
/// Source of truth: Stitch project "Nadhafti Cleaning Service App UI"
/// All values extracted verbatim from the design system.
abstract final class AppColors {
  // ── Primary ────────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF006950);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF008466);
  static const Color onPrimaryContainer = Color(0xFFF5FFF8);
  static const Color inversePrimary = Color(0xFF60DBB4);
  static const Color primaryFixed = Color(0xFF7FF8CF);
  static const Color primaryFixedDim = Color(0xFF60DBB4);
  static const Color onPrimaryFixed = Color(0xFF002117);
  static const Color onPrimaryFixedVariant = Color(0xFF00513D);
  static const Color surfaceTint = Color(0xFF006C52);

  // ── Secondary ──────────────────────────────────────────────────────────────
  static const Color secondary = Color(0xFF775A00);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFFDC73A);
  static const Color onSecondaryContainer = Color(0xFF6F5400);
  static const Color secondaryFixed = Color(0xFFFFDF9A);
  static const Color secondaryFixedDim = Color(0xFFF4BF32);
  static const Color onSecondaryFixed = Color(0xFF251A00);
  static const Color onSecondaryFixedVariant = Color(0xFF5A4300);

  // ── Tertiary ───────────────────────────────────────────────────────────────
  static const Color tertiary = Color(0xFF006952);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF1E836A);
  static const Color onTertiaryContainer = Color(0xFFF5FFF9);
  static const Color tertiaryFixed = Color(0xFF98F4D5);
  static const Color tertiaryFixedDim = Color(0xFF7CD8BA);
  static const Color onTertiaryFixed = Color(0xFF002118);
  static const Color onTertiaryFixedVariant = Color(0xFF00513F);

  // ── Error ──────────────────────────────────────────────────────────────────
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  // ── Surface / Background ───────────────────────────────────────────────────
  static const Color background = Color(0xFFF8F9FF);
  static const Color onBackground = Color(0xFF191C20);
  static const Color surface = Color(0xFFF8F9FF);
  static const Color onSurface = Color(0xFF191C20);
  static const Color surfaceDim = Color(0xFFD8DAE0);
  static const Color surfaceBright = Color(0xFFF8F9FF);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF2F3FA);
  static const Color surfaceContainer = Color(0xFFECEEF4);
  static const Color surfaceContainerHigh = Color(0xFFE6E8EE);
  static const Color surfaceContainerHighest = Color(0xFFE1E2E9);
  static const Color onSurfaceVariant = Color(0xFF3D4A44);
  static const Color surfaceVariant = Color(0xFFE1E2E9);
  static const Color inverseSurface = Color(0xFF2E3136);
  static const Color inverseOnSurface = Color(0xFFEFF0F7);

  // ── Outline ────────────────────────────────────────────────────────────────
  static const Color outline = Color(0xFF6D7A73);
  static const Color outlineVariant = Color(0xFFBCCAC2);

  // ── Semantic helpers (not in Stitch but needed in code) ───────────────────
  static const Color success = Color(0xFF006950);
  static const Color warning = Color(0xFFFDC73A);
  static const Color warningContainer = Color(0xFFFFF3CD);

  // ── Elevation overlay (tonal) ──────────────────────────────────────────────
  static const Color cardShadow = Color(0x0D2B2E33); // 5% opacity
  static const Color primaryShadow = Color(0x260FA37F); // 15% opacity
}
