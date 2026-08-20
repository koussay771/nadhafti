import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/l10n/generated/app_localizations.dart';

/// "Or continue with" divider + Google/Apple "Coming Soon" stubs.
/// Apple sign-in stub is iOS only via Platform check.
class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        // ── Divider ──────────────────────────────────────────────────────────
        Row(
          children: [
            const Expanded(child: Divider(color: AppColors.outlineVariant)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                'أو تابع بـ',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ),
            const Expanded(child: Divider(color: AppColors.outlineVariant)),
          ],
        ),

        const SizedBox(height: AppSpacing.lg),

        // ── Social buttons ───────────────────────────────────────────────────
        Row(
          children: [
            Expanded(
              child: _SocialStubButton(
                icon: 'G',
                label: 'Google',
                comingSoon: l10n.auth_socialComingSoon,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _SocialStubButton(
                icon: '',
                label: 'Apple',
                comingSoon: l10n.auth_socialComingSoon,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialStubButton extends StatelessWidget {
  const _SocialStubButton({
    required this.icon,
    required this.label,
    required this.comingSoon,
  });
  final String icon;
  final String label;
  final String comingSoon;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: comingSoon,
      child: OutlinedButton(
        onPressed: null, // Coming soon — disabled
        style: OutlinedButton.styleFrom(
          disabledForegroundColor: AppColors.onSurfaceVariant,
          side: const BorderSide(color: AppColors.outlineVariant),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.full),
          ),
          minimumSize: const Size(double.infinity, AppSpacing.touchTarget),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              icon,
              style: AppTextStyles.labelLg.copyWith(
                color: AppColors.onSurfaceVariant,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: AppTextStyles.labelMd.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
