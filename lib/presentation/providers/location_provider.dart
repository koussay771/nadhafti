import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/user_address.dart';
import 'auth_provider.dart';

part 'location_provider.g.dart';

@riverpod
class SelectedAddress extends _$SelectedAddress {
  @override
  UserAddress? build() {
    // Default initial location: Monastir Center
    return const UserAddress(
      id: 'default_monastir',
      userId: '',
      title: 'المنستير، تونس',
      fullAddress: 'وسط مدينة المنستير، المنستير 5000',
      latitude: 35.7643,
      longitude: 10.8113,
      city: 'المنستير',
      isDefault: true,
    );
  }

  void setAddress(UserAddress address) => state = address;

  void updateCoordinates(double lat, double lng, String addressName) {
    state = UserAddress(
      id: state?.id ?? 'custom_loc',
      userId: state?.userId ?? '',
      title: addressName,
      fullAddress: addressName,
      latitude: lat,
      longitude: lng,
      city: 'المنستير',
    );
  }
}

@riverpod
Future<List<UserAddress>> userAddresses(Ref ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return [];

  final client = ref.watch(supabaseProvider);
  try {
    final response = await client
        .from('addresses')
        .select()
        .eq('user_id', user.id)
        .order('is_default', ascending: false);

    return (response as List<dynamic>)
        .map((e) => UserAddress.fromJson(e as Map<String, dynamic>))
        .toList();
  } catch (_) {
    return [];
  }
}
