// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserBookingsNotifier)
final userBookingsProvider = UserBookingsNotifierProvider._();

final class UserBookingsNotifierProvider
    extends $AsyncNotifierProvider<UserBookingsNotifier, List<Booking>> {
  UserBookingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userBookingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userBookingsNotifierHash();

  @$internal
  @override
  UserBookingsNotifier create() => UserBookingsNotifier();
}

String _$userBookingsNotifierHash() =>
    r'dd81e9a5f8a7f80fa404802499efe3c72c330cc6';

abstract class _$UserBookingsNotifier extends $AsyncNotifier<List<Booking>> {
  FutureOr<List<Booking>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Booking>>, List<Booking>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Booking>>, List<Booking>>,
              AsyncValue<List<Booking>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
