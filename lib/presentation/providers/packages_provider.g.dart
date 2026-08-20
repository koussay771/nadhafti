// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packages_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cleaningPackages)
final cleaningPackagesProvider = CleaningPackagesProvider._();

final class CleaningPackagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CleaningPackage>>,
          List<CleaningPackage>,
          FutureOr<List<CleaningPackage>>
        >
    with
        $FutureModifier<List<CleaningPackage>>,
        $FutureProvider<List<CleaningPackage>> {
  CleaningPackagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cleaningPackagesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cleaningPackagesHash();

  @$internal
  @override
  $FutureProviderElement<List<CleaningPackage>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CleaningPackage>> create(Ref ref) {
    return cleaningPackages(ref);
  }
}

String _$cleaningPackagesHash() => r'4f3d4c1696f85f5baaa87f15d0ea0d7c223034d8';

@ProviderFor(SelectedPackage)
final selectedPackageProvider = SelectedPackageProvider._();

final class SelectedPackageProvider
    extends $NotifierProvider<SelectedPackage, CleaningPackage?> {
  SelectedPackageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedPackageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedPackageHash();

  @$internal
  @override
  SelectedPackage create() => SelectedPackage();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CleaningPackage? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CleaningPackage?>(value),
    );
  }
}

String _$selectedPackageHash() => r'1df6c7288aaa6e2bfa7fca9bab84f1f95df69e75';

abstract class _$SelectedPackage extends $Notifier<CleaningPackage?> {
  CleaningPackage? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CleaningPackage?, CleaningPackage?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CleaningPackage?, CleaningPackage?>,
              CleaningPackage?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
