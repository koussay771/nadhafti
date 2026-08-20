import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/router/app_router.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/nadhafti_button.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/social_login_row.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final emailCtrl = useTextEditingController();
    final passCtrl = useTextEditingController();
    final showPass = useState(false);
    final formKey = useMemoized(GlobalKey<FormState>.new);

    final authState = ref.watch(authProvider);

    // Navigate on success
    ref.listen(authProvider, (_, next) {
      if (next.status == AuthStatus.success) {
        context.go(AppRoutes.home);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.containerMargin,
            vertical: AppSpacing.xl,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.xxl),

                // ── Header ──────────────────────────────────────────────────
                Text(l10n.auth_welcome, style: AppTextStyles.headlineLg),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  l10n.auth_welcomeSubtitle,
                  style: AppTextStyles.bodyMd.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: AppSpacing.xxl),

                // ── Email field ─────────────────────────────────────────────
                AuthTextField(
                  controller: emailCtrl,
                  label: l10n.auth_email,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                  validator: (v) => (v == null || !v.contains('@'))
                      ? 'أدخل بريدًا إلكترونيًا صحيحًا'
                      : null,
                ),

                const SizedBox(height: AppSpacing.md),

                // ── Password field ──────────────────────────────────────────
                AuthTextField(
                  controller: passCtrl,
                  label: l10n.auth_password,
                  obscureText: !showPass.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPass.value
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      color: AppColors.onSurfaceVariant,
                    ),
                    onPressed: () => showPass.value = !showPass.value,
                  ),
                  validator: (v) => (v == null || v.length < 6)
                      ? 'كلمة المرور أقل من 6 أحرف'
                      : null,
                ),

                const SizedBox(height: AppSpacing.sm),

                // ── Forgot password ─────────────────────────────────────────
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => _showForgotPasswordSheet(context, ref, l10n),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      textStyle: AppTextStyles.labelMd,
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(l10n.auth_forgotPassword),
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                // ── Error banner ────────────────────────────────────────────
                if (authState.hasError) ...[
                  _ErrorBanner(message: authState.errorMessage ?? ''),
                  const SizedBox(height: AppSpacing.md),
                ],

                // ── Login button ────────────────────────────────────────────
                NadhaftiButton(
                  label: l10n.auth_login,
                  isLoading: authState.isLoading,
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      ref.read(authProvider.notifier).signIn(
                            email: emailCtrl.text.trim(),
                            password: passCtrl.text,
                          );
                    }
                  },
                ),

                const SizedBox(height: AppSpacing.xl),

                // ── Divider + Social ────────────────────────────────────────
                const SocialLoginRow(),

                const SizedBox(height: AppSpacing.xl),

                // ── Sign up link ────────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.auth_noAccount, style: AppTextStyles.bodyMd),
                    GestureDetector(
                      onTap: () => context.push(AppRoutes.signup),
                      child: Text(
                        l10n.auth_signupLink,
                        style: AppTextStyles.labelLg.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showForgotPasswordSheet(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    final emailCtrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadii.xxl)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.containerMargin,
          right: AppSpacing.containerMargin,
          top: AppSpacing.lg,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.outlineVariant,
                  borderRadius: BorderRadius.circular(AppRadii.full),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(l10n.auth_forgotPassword, style: AppTextStyles.headlineSm),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'أدخل بريدك الإلكتروني وسنرسل لك رابط إعادة تعيين كلمة المرور.',
              style: AppTextStyles.bodyMd.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            AuthTextField(
              controller: emailCtrl,
              label: l10n.auth_email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: AppSpacing.lg),
            NadhaftiButton(
              label: 'إرسال',
              onPressed: () async {
                await ref
                    .read(authProvider.notifier)
                    .sendPasswordReset(emailCtrl.text.trim());
                if (context.mounted) Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ── Error banner ──────────────────────────────────────────────────────────────
class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.errorContainer,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline_rounded,
              color: AppColors.onErrorContainer, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodyMd.copyWith(
                color: AppColors.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
