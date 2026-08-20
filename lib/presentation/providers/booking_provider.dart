import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/booking.dart';
import 'auth_provider.dart';

part 'booking_provider.g.dart';

@riverpod
class UserBookingsNotifier extends _$UserBookingsNotifier {
  @override
  Future<List<Booking>> build() async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return [];

    final client = ref.watch(supabaseProvider);
    try {
      final response = await client
          .from('bookings')
          .select()
          .eq('user_id', user.id)
          .order('scheduled_date', ascending: false);

      return (response as List<dynamic>)
          .map((e) => Booking.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<Booking> createBooking({
    required String packageId,
    required String packageName,
    required String propertyId,
    required String propertyName,
    required String addressText,
    required DateTime scheduledDate,
    required String timeSlot,
    required double basePrice,
    required List<String> addOns,
    required double totalPrice,
    String? specialNotes,
  }) async {
    final user = ref.read(currentUserProvider);
    final client = ref.read(supabaseProvider);

    final newBooking = Booking(
      id: 'bk_${DateTime.now().millisecondsSinceEpoch}',
      userId: user?.id ?? '',
      packageId: packageId,
      packageName: packageName,
      propertyId: propertyId,
      propertyName: propertyName,
      addressText: addressText,
      scheduledDate: scheduledDate,
      timeSlot: timeSlot,
      basePrice: basePrice,
      addOns: addOns,
      totalPrice: totalPrice,
      status: BookingStatus.confirmed,
      specialNotes: specialNotes,
      createdAt: DateTime.now(),
    );

    if (user != null) {
      try {
        await client.from('bookings').insert(newBooking.toJson());
      } catch (_) {
        // Fallback locally
      }
    }

    final currentList = state.value ?? [];
    state = AsyncValue.data([newBooking, ...currentList]);
    return newBooking;
  }
}
