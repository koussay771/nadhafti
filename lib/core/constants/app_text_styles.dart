import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Nadhafti Design Token — Text Styles
/// Font: Nunito Sans (loaded via pubspec fonts section)
/// Scale extracted verbatim from Stitch design system.
abstract final class AppTextStyles {

  /// 32px / ExtraBold 800 / lh 40px / ls -0.02em
  static TextStyle get headlineLg => GoogleFonts.nunitoSans(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        height: 40 / 32,
        letterSpacing: -0.02 * 32,
        color: AppColors.onBackground,
      );

  /// 26px / ExtraBold 800 / lh 32px / ls -0.02em  — used on mobile headlines
  static TextStyle get headlineLgMobile => GoogleFonts.nunitoSans(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        height: 32 / 26,
        letterSpacing: -0.02 * 26,
        color: AppColors.onBackground,
      );

  /// 24px / Bold 700 / lh 32px
  static TextStyle get headlineMd => GoogleFonts.nunitoSans(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 32 / 24,
        color: AppColors.onBackground,
      );

  /// 20px / Bold 700 / lh 28px
  static TextStyle get headlineSm => GoogleFonts.nunitoSans(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 28 / 20,
        color: AppColors.onBackground,
      );

  // ── Body ───────────────────────────────────────────────────────────────────

  /// 18px / Regular 400 / lh 28px
  static TextStyle get bodyLg => GoogleFonts.nunitoSans(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 28 / 18,
        color: AppColors.onSurface,
      );

  /// 16px / Regular 400 / lh 24px
  static TextStyle get bodyMd => GoogleFonts.nunitoSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
        color: AppColors.onSurface,
      );

  // ── Label ──────────────────────────────────────────────────────────────────

  /// 16px / Bold 700 / lh 20px  — buttons, active states
  static TextStyle get labelLg => GoogleFonts.nunitoSans(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 20 / 16,
        color: AppColors.onSurface,
      );

  /// 14px / SemiBold 600 / lh 18px  — chips, secondary labels
  static TextStyle get labelMd => GoogleFonts.nunitoSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 18 / 14,
        color: AppColors.onSurface,
      );

  // ── Caption ────────────────────────────────────────────────────────────────

  /// 12px / Regular 400 / lh 16px
  static TextStyle get caption => GoogleFonts.nunitoSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 16 / 12,
        color: AppColors.onSurfaceVariant,
      );

  // ── Convenience helpers ───────────────────────────────────────────────────

  /// Quick color override helper.
  static TextStyle withColor(TextStyle style, Color color) =>
      style.copyWith(color: color);
}

/// Elevation / shadow tokens from Stitch design system.
abstract final class AppElevation {
  /// Level 0 — no shadow (background surfaces)
  static const List<BoxShadow> none = [];

  /// Level 1 — cards and standard surfaces
  static const List<BoxShadow> card = [
    BoxShadow(
      color: AppColors.cardShadow,
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  /// Level 2 — buttons and floating elements (primary teal glow)
  static const List<BoxShadow> button = [
    BoxShadow(
      color: AppColors.primaryShadow,
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];
}
