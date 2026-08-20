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

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final firstNameCtrl = useTextEditingController();
    final lastNameCtrl = useTextEditingController();
    final phoneCtrl = useTextEditingController();
    final emailCtrl = useTextEditingController();
    final passCtrl = useTextEditingController();
    final confirmPassCtrl = useTextEditingController();
    final showPass = useState(false);
    final showConfirm = useState(false);
    final termsAccepted = useState(false);
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
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.onSurface),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.containerMargin,
            vertical: AppSpacing.md,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──────────────────────────────────────────────────
                Text(l10n.auth_signup, style: AppTextStyles.headlineLg),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  l10n.auth_welcomeSubtitle,
                  style: AppTextStyles.bodyMd.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                // ── Name row ────────────────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: AuthTextField(
                        controller: firstNameCtrl,
                        label: l10n.auth_firstName,
                        textInputAction: TextInputAction.next,
                        validator: (v) =>
                            (v == null || v.isEmpty) ? 'مطلوب' : null,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: AuthTextField(
                        controller: lastNameCtrl,
                        label: l10n.auth_lastName,
                        textInputAction: TextInputAction.next,
                        validator: (v) =>
                            (v == null || v.isEmpty) ? 'مطلوب' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                // ── Phone ────────────────────────────────────────────────────
                AuthTextField(
                  controller: phoneCtrl,
                  label: l10n.auth_phone,
                  keyboardType: TextInputType.phone,
                  prefixText: '+216 ',
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (v) =>
                      (v == null || v.length < 8) ? 'رقم الهاتف غير صحيح' : null,
                ),
                const SizedBox(height: AppSpacing.md),

                // ── Email ────────────────────────────────────────────────────
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

                // ── Password ─────────────────────────────────────────────────
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
                      ? 'كلمة المرور يجب أن تكون 6 أحرف على الأقل'
                      : null,
                ),
                const SizedBox(height: AppSpacing.md),

                // ── Confirm Password ─────────────────────────────────────────
                AuthTextField(
                  controller: confirmPassCtrl,
                  label: l10n.auth_confirmPassword,
                  obscureText: !showConfirm.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      showConfirm.value
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      color: AppColors.onSurfaceVariant,
                    ),
                    onPressed: () => showConfirm.value = !showConfirm.value,
                  ),
                  validator: (v) => v != passCtrl.text
                      ? 'كلمتا المرور غير متطابقتين'
                      : null,
                ),
                const SizedBox(height: AppSpacing.lg),

                // ── Terms checkbox ───────────────────────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: termsAccepted.value,
                        activeColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadii.sm),
                        ),
                        onChanged: (v) => termsAccepted.value = v ?? false,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        l10n.auth_termsAccept,
                        style: AppTextStyles.bodyMd.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),

                // ── Error banner ─────────────────────────────────────────────
                if (authState.hasError) ...[
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.errorContainer,
                      borderRadius: BorderRadius.circular(AppRadii.lg),
                    ),
                    child: Text(
                      authState.errorMessage ?? '',
                      style: AppTextStyles.bodyMd.copyWith(
                        color: AppColors.onErrorContainer,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],

                // ── Sign Up button ───────────────────────────────────────────
                NadhaftiButton(
                  label: l10n.auth_signup,
                  isLoading: authState.isLoading,
                  onPressed: () {
                    if (!termsAccepted.value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('يرجى قبول الشروط والأحكام أولاً'),
                        ),
                      );
                      return;
                    }
                    if (formKey.currentState?.validate() ?? false) {
                      ref.read(authProvider.notifier).signUp(
                            email: emailCtrl.text.trim(),
                            password: passCtrl.text,
                            firstName: firstNameCtrl.text.trim(),
                            lastName: lastNameCtrl.text.trim(),
                            phone: '+216${phoneCtrl.text.trim()}',
                          );
                    }
                  },
                ),

                const SizedBox(height: AppSpacing.xl),

                // ── Social row ───────────────────────────────────────────────
                const SocialLoginRow(),

                const SizedBox(height: AppSpacing.xl),

                // ── Login link ───────────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.auth_hasAccount, style: AppTextStyles.bodyMd),
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Text(
                        l10n.auth_loginLink,
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
}
