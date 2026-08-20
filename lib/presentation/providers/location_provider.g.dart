// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedAddress)
final selectedAddressProvider = SelectedAddressProvider._();

final class SelectedAddressProvider
    extends $NotifierProvider<SelectedAddress, UserAddress?> {
  SelectedAddressProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedAddressProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedAddressHash();

  @$internal
  @override
  SelectedAddress create() => SelectedAddress();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserAddress? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserAddress?>(value),
    );
  }
}

String _$selectedAddressHash() => r'46df23dce1e60fea9611e7f3073b2a7461e9010c';

abstract class _$SelectedAddress extends $Notifier<UserAddress?> {
  UserAddress? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<UserAddress?, UserAddress?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserAddress?, UserAddress?>,
              UserAddress?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(userAddresses)
final userAddressesProvider = UserAddressesProvider._();

final class UserAddressesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UserAddress>>,
          List<UserAddress>,
          FutureOr<List<UserAddress>>
        >
    with
        $FutureModifier<List<UserAddress>>,
        $FutureProvider<List<UserAddress>> {
  UserAddressesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userAddressesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userAddressesHash();

  @$internal
  @override
  $FutureProviderElement<List<UserAddress>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UserAddress>> create(Ref ref) {
    return userAddresses(ref);
  }
}

String _$userAddressesHash() => r'c0dd891dc26f3a221b7db7bb3aef1765bf0bcc42';
