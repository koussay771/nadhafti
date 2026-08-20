import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';

/// Primary pill button — full-width, 56px, Primary Teal with a teal glow shadow.
/// Matches Stitch spec: pill-shaped, h-14, bg-primary, label-lg, shadow-[0px_8px_20px_rgba(0,105,80,0.15)].
class NadhaftiButton extends StatelessWidget {
  const NadhaftiButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.variant = NadhaftiButtonVariant.primary,
    this.icon,
    this.width,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final NadhaftiButtonVariant variant;
  final Widget? icon;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final isPrimary = variant == NadhaftiButtonVariant.primary;
    final isSecondary = variant == NadhaftiButtonVariant.secondary;

    return AnimatedScale(
      scale: onPressed == null ? 1.0 : 1.0,
      duration: const Duration(milliseconds: 100),
      child: Container(
        width: width ?? double.infinity,
        height: AppSpacing.touchTarget,
        decoration: isPrimary
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadii.full),
                boxShadow: AppElevation.button,
              )
            : null,
        child: _buildButton(isPrimary, isSecondary),
      ),
    );
  }

  Widget _buildButton(bool isPrimary, bool isSecondary) {
    final child = isLoading
        ? const SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation(AppColors.onPrimary),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: AppSpacing.xs)],
              Text(label, style: AppTextStyles.labelLg),
            ],
          );

    if (isPrimary) {
      return ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          disabledBackgroundColor: AppColors.surfaceContainerHigh,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.full),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          minimumSize: const Size(double.infinity, AppSpacing.touchTarget),
          textStyle: AppTextStyles.labelLg,
        ),
        child: child,
      );
    }

    if (isSecondary) {
      return OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.full),
          ),
          minimumSize: const Size(double.infinity, AppSpacing.touchTarget),
          textStyle: AppTextStyles.labelLg,
        ),
        child: child,
      );
    }

    // Ghost / tertiary
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.full),
        ),
        minimumSize: const Size(double.infinity, AppSpacing.touchTarget),
        textStyle: AppTextStyles.labelLg,
      ),
      child: child,
    );
  }
}

enum NadhaftiButtonVariant { primary, secondary, ghost }
