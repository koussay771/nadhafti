import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/router/app_router.dart';
import '../../providers/auth_provider.dart';
import '../../providers/locale_provider.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(appLocaleProvider);
    final user = ref.watch(currentUserProvider);

    final firstName = user?.userMetadata?['first_name'] as String? ?? 'المستخدم';
    final lastName = user?.userMetadata?['last_name'] as String? ?? '';
    final phone = user?.userMetadata?['phone'] as String? ?? '+216 -- --- ---';
    final email = user?.email ?? 'user@nadhafti.tn';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.settings_title),
        elevation: 0,
        backgroundColor: AppColors.surface,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.containerMargin,
            vertical: AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── User Profile Card ─────────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadii.xl),
                  border: Border.all(color: AppColors.outlineVariant),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.primaryContainer,
                      child: Text(
                        firstName.isNotEmpty ? firstName[0] : 'ن',
                        style: AppTextStyles.headlineSm.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$firstName $lastName',
                            style: AppTextStyles.labelLg.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            phone,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            email,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // ── Language Toggle Section ───────────────────────────────────
              _SectionHeader(title: l10n.settings_language),
              const SizedBox(height: AppSpacing.xs),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                  border: Border.all(color: AppColors.outlineVariant),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Text('🇹🇳', style: TextStyle(fontSize: 22)),
                      title: Text(
                        l10n.settings_language_ar,
                        style: AppTextStyles.bodyMd.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: currentLocale.languageCode == 'ar'
                          ? const Icon(Icons.check_circle_rounded,
                              color: AppColors.primary)
                          : null,
                      onTap: () => ref
                          .read(appLocaleProvider.notifier)
                          .setLocale(const Locale('ar')),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Text('🇫🇷', style: TextStyle(fontSize: 22)),
                      title: Text(
                        l10n.settings_language_fr,
                        style: AppTextStyles.bodyMd.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: currentLocale.languageCode == 'fr'
                          ? const Icon(Icons.check_circle_rounded,
                              color: AppColors.primary)
                          : null,
                      onTap: () => ref
                          .read(appLocaleProvider.notifier)
                          .setLocale(const Locale('fr')),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // ── Shortcuts Section ─────────────────────────────────────────
              const _SectionHeader(title: 'إدارة الحساب'),
              const SizedBox(height: AppSpacing.xs),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                  border: Border.all(color: AppColors.outlineVariant),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.home_work_rounded,
                          color: AppColors.primary),
                      title: Text(l10n.settings_myProperties,
                          style: AppTextStyles.bodyMd),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded,
                          size: 16),
                      onTap: () => context.push(AppRoutes.selectProperty),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.location_on_rounded,
                          color: AppColors.primary),
                      title: Text(l10n.settings_myLocations,
                          style: AppTextStyles.bodyMd),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded,
                          size: 16),
                      onTap: () => context.push(AppRoutes.pickLocation),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // ── Switch to Cleaner Mode Banner ────────────────────────────
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.secondary,
                      AppColors.secondaryContainer,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.work_outline_rounded,
                        color: Colors.white, size: 28),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.settings_switchToCleaner,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'انضم لفريق عاملات النظافة في المنستير',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppRadii.full),
                      ),
                      child: const Text(
                        'قريبًا',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w800,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // ── Support & Legal ───────────────────────────────────────────
              const _SectionHeader(title: 'الدعم والمعلومات القانونية'),
              const SizedBox(height: AppSpacing.xs),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                  border: Border.all(color: AppColors.outlineVariant),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.support_agent_rounded,
                          color: AppColors.primary),
                      title: Text(l10n.settings_contact,
                          style: AppTextStyles.bodyMd),
                      subtitle: const Text('فريق الدعم المباشر بالمنستير'),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded,
                          size: 16),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'الدعم الفني متاح عبر الهاتف والواتساب: +216 73 000 000',
                            ),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.description_outlined,
                          color: AppColors.onSurfaceVariant),
                      title: Text(l10n.settings_terms,
                          style: AppTextStyles.bodyMd),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded,
                          size: 16),
                      onTap: () => _showTermsDialog(context, l10n.settings_terms),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.privacy_tip_outlined,
                          color: AppColors.onSurfaceVariant),
                      title: Text(l10n.settings_privacy,
                          style: AppTextStyles.bodyMd),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded,
                          size: 16),
                      onTap: () => _showTermsDialog(context, l10n.settings_privacy),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // ── Logout Button ─────────────────────────────────────────────
              OutlinedButton.icon(
                onPressed: () => _showLogoutConfirm(context, ref, l10n),
                icon: const Icon(Icons.logout_rounded, color: AppColors.error),
                label: Text(
                  l10n.settings_logout,
                  style: AppTextStyles.labelLg.copyWith(color: AppColors.error),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, AppSpacing.touchTarget),
                  side: const BorderSide(color: AppColors.error, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadii.full),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // App Version
              Center(
                child: Text(
                  'نظافتي Nadhafti v1.0.0 (Monastir Release)',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.outline,
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  void _showTermsDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title, style: AppTextStyles.headlineSm),
        content: SingleChildScrollView(
          child: Text(
            'تطبيق نظافتي يقدم خدمات تنظيف المنازل والشقق والمكاتب في ولاية المنستير وضواحيها. جميع العاملات تم التحقق من هوياتهن وخبراتهن. يتم الدفع بعد إتمام الخدمة بالدينار التونسي (DT). نلتزم بالحفاظ على خصوصية بياناتكم وأمان منازلكم.',
            style: AppTextStyles.bodyMd,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirm(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.settings_logout, style: AppTextStyles.headlineSm),
        content: const Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.common_cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await ref.read(authProvider.notifier).signOut();
              if (context.mounted) {
                context.go(AppRoutes.login);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.settings_logout),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.labelMd.copyWith(
        color: AppColors.onSurfaceVariant,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
