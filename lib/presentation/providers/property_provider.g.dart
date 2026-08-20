// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedProperty)
final selectedPropertyProvider = SelectedPropertyProvider._();

final class SelectedPropertyProvider
    extends $NotifierProvider<SelectedProperty, Property?> {
  SelectedPropertyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedPropertyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedPropertyHash();

  @$internal
  @override
  SelectedProperty create() => SelectedProperty();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Property? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Property?>(value),
    );
  }
}

String _$selectedPropertyHash() => r'3da073999657d337127e103d6fc06b749b1319d2';

abstract class _$SelectedProperty extends $Notifier<Property?> {
  Property? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Property?, Property?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Property?, Property?>,
              Property?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(UserPropertiesNotifier)
final userPropertiesProvider = UserPropertiesNotifierProvider._();

final class UserPropertiesNotifierProvider
    extends $AsyncNotifierProvider<UserPropertiesNotifier, List<Property>> {
  UserPropertiesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userPropertiesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userPropertiesNotifierHash();

  @$internal
  @override
  UserPropertiesNotifier create() => UserPropertiesNotifier();
}

String _$userPropertiesNotifierHash() =>
    r'8f84116128e042b3dfdffd0c1bce4e03a22608ae';

abstract class _$UserPropertiesNotifier extends $AsyncNotifier<List<Property>> {
  FutureOr<List<Property>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Property>>, List<Property>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Property>>, List<Property>>,
              AsyncValue<List<Property>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
