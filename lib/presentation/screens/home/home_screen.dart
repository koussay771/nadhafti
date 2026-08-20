import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/router/app_router.dart';
import '../../../domain/models/cleaning_package.dart';
import '../../providers/auth_provider.dart';
import '../../providers/packages_provider.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final user = ref.watch(currentUserProvider);
    final packagesAsync = ref.watch(cleaningPackagesProvider);

    final userName = user?.userMetadata?['first_name'] as String? ?? (locale == 'ar' ? 'صديقنا' : 'Client');

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: _HomeBottomNav(
        currentIndex: 0,
        l10n: l10n,
        onTap: (index) {
          if (index == 1) {
            context.push(AppRoutes.booking);
          } else if (index == 2) {
            context.push(AppRoutes.pickLocation);
          } else if (index == 3) {
            context.push(AppRoutes.settings);
          }
        },
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(cleaningPackagesProvider);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.containerMargin,
              vertical: AppSpacing.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Top Bar: Location Badge & Profile ────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Location selector badge
                    GestureDetector(
                      onTap: () => context.push(AppRoutes.pickLocation),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(AppRadii.full),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              size: 16,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              l10n.home_locationBadge,
                              style: AppTextStyles.labelMd.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 16,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // User Profile Avatar
                    GestureDetector(
                      onTap: () => context.push(AppRoutes.settings),
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.secondaryContainer,
                        child: Icon(
                          Icons.person_rounded,
                          color: AppColors.secondary,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.lg),

                // ── Greeting ────────────────────────────────────────────────
                Text(
                  l10n.home_greeting(userName),
                  style: AppTextStyles.headlineMd.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.home_subtitle,
                  style: AppTextStyles.bodyMd.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                // ── Hero Promo Banner ───────────────────────────────────────
                _HeroPromoBanner(
                  l10n: l10n,
                  onBookNow: () {
                    packagesAsync.whenData((packages) {
                      if (packages.isNotEmpty) {
                        ref
                            .read(selectedPackageProvider.notifier)
                            .select(packages.first);
                      }
                    });
                    context.push(AppRoutes.pickLocation);
                  },
                ),

                const SizedBox(height: AppSpacing.xxl),

                // ── Services Section Header ─────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.home_services_title,
                      style: AppTextStyles.headlineSm.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      l10n.home_services_subtitle,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.md),

                // ── Services Package List ───────────────────────────────────
                packagesAsync.when(
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacing.xxl),
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  error: (_, __) => _FallbackPackagesList(
                    locale: locale,
                    l10n: l10n,
                    onSelect: (pkg) {
                      ref.read(selectedPackageProvider.notifier).select(pkg);
                      context.push(AppRoutes.pickLocation);
                    },
                  ),
                  data: (packages) => ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: packages.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final package = packages[index];
                      return _PackageCard(
                        package: package,
                        locale: locale,
                        l10n: l10n,
                        onTap: () {
                          ref
                              .read(selectedPackageProvider.notifier)
                              .select(package);
                          context.push(AppRoutes.pickLocation);
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: AppSpacing.xxl),

                // ── Trust & Quality Guarantees ──────────────────────────────
                _TrustGuaranteesSection(l10n: l10n),

                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Hero Promo Banner Widget ──────────────────────────────────────────────────
class _HeroPromoBanner extends StatelessWidget {
  const _HeroPromoBanner({required this.onBookNow, required this.l10n});
  final VoidCallback onBookNow;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadii.xl),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppRadii.full),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      l10n.home_top_service,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.home_hero_headline,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.home_instant_booking,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ElevatedButton(
            onPressed: onBookNow,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadii.full),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.sm,
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.home_cta,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.arrow_forward_rounded, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Package Card Widget ───────────────────────────────────────────────────────
class _PackageCard extends StatelessWidget {
  const _PackageCard({
    required this.package,
    required this.locale,
    required this.l10n,
    required this.onTap,
  });

  final CleaningPackage package;
  final String locale;
  final AppLocalizations l10n;
  final VoidCallback onTap;

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'sparkles':
        return Icons.auto_awesome_rounded;
      case 'health_and_safety':
        return Icons.sanitizer_rounded;
      case 'home_work':
        return Icons.home_work_rounded;
      case 'business':
        return Icons.apartment_rounded;
      default:
        return Icons.cleaning_services_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currency = locale == 'ar' ? 'دت' : 'DT';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadii.lg),
            border: Border.all(
              color: package.isPopular
                  ? AppColors.primary
                  : AppColors.outlineVariant,
              width: package.isPopular ? 1.5 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row (Icon, Title, Popular badge)
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(AppRadii.md),
                    ),
                    child: Icon(
                      _getIcon(package.iconName),
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                package.localizedName(locale),
                                style: AppTextStyles.labelLg.copyWith(
                                   fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            if (package.isPopular) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary,
                                  borderRadius:
                                      BorderRadius.circular(AppRadii.full),
                                ),
                                child: Text(
                                  l10n.home_popular_badge,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(
                              Icons.schedule_rounded,
                              size: 14,
                              color: AppColors.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              l10n.home_hours_duration(package.durationHours),
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Price tag in Tunisian Dinar
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(AppRadii.full),
                    ),
                    child: Text(
                      '${package.basePrice.toStringAsFixed(0)} $currency',
                      style: AppTextStyles.labelLg.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.md),

              // Description
              Text(
                package.localizedDescription(locale),
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Fallback Package List Widget ──────────────────────────────────────────────
class _FallbackPackagesList extends StatelessWidget {
  const _FallbackPackagesList({
    required this.locale,
    required this.l10n,
    required this.onSelect,
  });

  final String locale;
  final AppLocalizations l10n;
  final void Function(CleaningPackage) onSelect;

  @override
  Widget build(BuildContext context) {
    final list = CleaningPackage.fallbackPackages;
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final package = list[index];
        return _PackageCard(
          package: package,
          locale: locale,
          l10n: l10n,
          onTap: () => onSelect(package),
        );
      },
    );
  }
}

// ── Trust & Quality Guarantees ────────────────────────────────────────────────
class _TrustGuaranteesSection extends StatelessWidget {
  const _TrustGuaranteesSection({required this.l10n});
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.home_trust_title,
            style: AppTextStyles.labelLg.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _TrustItem(
            icon: Icons.verified_user_rounded,
            title: l10n.home_trust_1_title,
            subtitle: l10n.home_trust_1_sub,
          ),
          const SizedBox(height: AppSpacing.sm),
          _TrustItem(
            icon: Icons.price_check_rounded,
            title: l10n.home_trust_2_title,
            subtitle: l10n.home_trust_2_sub,
          ),
          const SizedBox(height: AppSpacing.sm),
          _TrustItem(
            icon: Icons.thumb_up_rounded,
            title: l10n.home_trust_3_title,
            subtitle: l10n.home_trust_3_sub,
          ),
        ],
      ),
    );
  }
}

class _TrustItem extends StatelessWidget {
  const _TrustItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.labelMd.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              Text(
                subtitle,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Bottom Navigation Bar ─────────────────────────────────────────────────────
class _HomeBottomNav extends StatelessWidget {
  const _HomeBottomNav({
    required this.currentIndex,
    required this.l10n,
    required this.onTap,
  });

  final int currentIndex;
  final AppLocalizations l10n;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.outlineVariant, width: 0.8),
        ),
      ),
      child: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onTap,
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primaryContainer,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home_rounded, color: AppColors.primary),
            label: l10n.nav_home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.calendar_month_outlined),
            selectedIcon:
                const Icon(Icons.calendar_month_rounded, color: AppColors.primary),
            label: l10n.nav_bookings,
          ),
          NavigationDestination(
            icon: const Icon(Icons.map_outlined),
            selectedIcon: const Icon(Icons.map_rounded, color: AppColors.primary),
            label: l10n.nav_map,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon:
                const Icon(Icons.settings_rounded, color: AppColors.primary),
            label: l10n.nav_settings,
          ),
        ],
      ),
    );
  }
}
