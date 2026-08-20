// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Tracks the current onboarding page index (0-based).

@ProviderFor(OnboardingPageIndex)
final onboardingPageIndexProvider = OnboardingPageIndexProvider._();

/// Tracks the current onboarding page index (0-based).
final class OnboardingPageIndexProvider
    extends $NotifierProvider<OnboardingPageIndex, int> {
  /// Tracks the current onboarding page index (0-based).
  OnboardingPageIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingPageIndexProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingPageIndexHash();

  @$internal
  @override
  OnboardingPageIndex create() => OnboardingPageIndex();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$onboardingPageIndexHash() =>
    r'a8a19ab248f7c4db82909b8790e3c600f7c0f881';

/// Tracks the current onboarding page index (0-based).

abstract class _$OnboardingPageIndex extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Marks onboarding as completed and persists the flag.

@ProviderFor(completeOnboarding)
final completeOnboardingProvider = CompleteOnboardingProvider._();

/// Marks onboarding as completed and persists the flag.

final class CompleteOnboardingProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  /// Marks onboarding as completed and persists the flag.
  CompleteOnboardingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'completeOnboardingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$completeOnboardingHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return completeOnboarding(ref);
  }
}

String _$completeOnboardingHash() =>
    r'4fe32ab6ae657b82d3285cb1edb5d55417b0a8fa';

/// Checks whether the user has already seen onboarding.

@ProviderFor(hasSeenOnboarding)
final hasSeenOnboardingProvider = HasSeenOnboardingProvider._();

/// Checks whether the user has already seen onboarding.

final class HasSeenOnboardingProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Checks whether the user has already seen onboarding.
  HasSeenOnboardingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hasSeenOnboardingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hasSeenOnboardingHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return hasSeenOnboarding(ref);
  }
}

String _$hasSeenOnboardingHash() => r'a1c0f34b4df1ac0fd5065481c6c662c8357cd9cd';
