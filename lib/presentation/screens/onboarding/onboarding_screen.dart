import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/router/app_router.dart';
import '../../providers/onboarding_provider.dart';
import '../../widgets/dot_indicator.dart';
import '../../widgets/nadhafti_button.dart';

// ── Data model for each onboarding slide ─────────────────────────────────────
class _OnboardingSlide {
  const _OnboardingSlide({
    required this.illustrationPath,
    required this.titleKey,
    required this.subtitleKey,
  });
  final String illustrationPath;
  final String titleKey;
  final String subtitleKey;
}

// ── Screen ────────────────────────────────────────────────────────────────────
class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  static const _slides = [
    _OnboardingSlide(
      illustrationPath: 'assets/illustrations/onboarding_1.jpg',
      titleKey: 'onboarding1_title',
      subtitleKey: 'onboarding1_subtitle',
    ),
    _OnboardingSlide(
      illustrationPath: 'assets/illustrations/onboarding_2.jpg',
      titleKey: 'onboarding2_title',
      subtitleKey: 'onboarding2_subtitle',
    ),
    _OnboardingSlide(
      illustrationPath: 'assets/illustrations/onboarding_3.jpg',
      titleKey: 'onboarding3_title',
      subtitleKey: 'onboarding3_subtitle',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final pageController = usePageController();
    final currentPage = ref.watch(onboardingPageIndexProvider);
    final isLastPage = currentPage == _slides.length - 1;

    Future<void> completeAndNavigate() async {
      await ref.read(completeOnboardingProvider.future);
      if (context.mounted) context.go(AppRoutes.login);
    }

    Future<void> handleNext() async {
      if (isLastPage) {
        await completeAndNavigate();
      } else {
        ref.read(onboardingPageIndexProvider.notifier).next(_slides.length);
        await pageController.animateToPage(
          currentPage + 1,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      }
    }

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // ── Skip button ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.containerMargin,
                AppSpacing.lg,
                AppSpacing.containerMargin,
                0,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: AnimatedOpacity(
                  opacity: isLastPage ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: TextButton(
                    onPressed: isLastPage ? null : completeAndNavigate,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      textStyle: AppTextStyles.labelLg,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadii.full),
                      ),
                    ),
                    child: Text(l10n.onboarding_skip),
                  ),
                ),
              ),
            ),

            // ── PageView (illustration fills top ~55% of screen) ───────────
            Expanded(
              child: PageView.builder(
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                itemCount: _slides.length,
                onPageChanged: (i) =>
                    ref.read(onboardingPageIndexProvider.notifier).goTo(i),
                itemBuilder: (context, index) =>
                    _OnboardingPage(slide: _slides[index]),
              ),
            ),

            // ── Bottom controls ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.containerMargin,
                AppSpacing.xl,
                AppSpacing.containerMargin,
                AppSpacing.xl,
              ),
              child: Column(
                children: [
                  // Dot pagination
                  DotIndicator(
                    count: _slides.length,
                    currentIndex: currentPage,
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Primary action button
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: NadhaftiButton(
                      key: ValueKey(isLastPage),
                      label: isLastPage
                          ? l10n.onboarding_getStarted
                          : l10n.onboarding_next,
                      onPressed: handleNext,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Individual slide page ─────────────────────────────────────────────────────
class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.slide});
  final _OnboardingSlide slide;

  String _getTitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (slide.titleKey) {
      case 'onboarding1_title':
        return l10n.onboarding1_title;
      case 'onboarding2_title':
        return l10n.onboarding2_title;
      case 'onboarding3_title':
        return l10n.onboarding3_title;
      default:
        return '';
    }
  }

  String _getSubtitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (slide.subtitleKey) {
      case 'onboarding1_subtitle':
        return l10n.onboarding1_subtitle;
      case 'onboarding2_subtitle':
        return l10n.onboarding2_subtitle;
      case 'onboarding3_subtitle':
        return l10n.onboarding3_subtitle;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.containerMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ── Illustration (320×320 aspect square with float animation) ────
          _FloatingIllustration(imagePath: slide.illustrationPath),

          const SizedBox(height: AppSpacing.xl),

          // ── Title ────────────────────────────────────────────────────────
          Text(
            _getTitle(context),
            style: AppTextStyles.headlineLgMobile.copyWith(
              color: AppColors.onSurface,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppSpacing.md),

          // ── Subtitle ─────────────────────────────────────────────────────
          Text(
            _getSubtitle(context),
            style: AppTextStyles.bodyLg.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

// ── Floating illustration with subtle up-down animation ──────────────────────
class _FloatingIllustration extends HookWidget {
  const _FloatingIllustration({required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 3500),
    )..repeat(reverse: true);

    final floatAnimation = Tween<double>(begin: 0, end: -10).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    return AnimatedBuilder(
      animation: floatAnimation,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, floatAnimation.value),
        child: child,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 300,
          maxHeight: 300,
        ),
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => _PlaceholderIllustration(),
          ),
        ),
      ),
    );
  }
}

// ── Fallback if asset is missing ──────────────────────────────────────────────
class _PlaceholderIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.xxl),
      ),
      child: const Icon(
        Icons.cleaning_services_rounded,
        size: 80,
        color: AppColors.primaryFixedDim,
      ),
    );
  }
}
