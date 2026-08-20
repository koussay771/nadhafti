import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/property.dart';
import 'auth_provider.dart';

part 'property_provider.g.dart';

@riverpod
class SelectedProperty extends _$SelectedProperty {
  @override
  Property? build() => Property.sampleDefault;

  void select(Property property) => state = property;
  void clear() => state = null;
}

@riverpod
class UserPropertiesNotifier extends _$UserPropertiesNotifier {
  @override
  Future<List<Property>> build() async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return [Property.sampleDefault];

    final client = ref.watch(supabaseProvider);
    try {
      final response = await client
          .from('properties')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      final list = (response as List<dynamic>)
          .map((e) => Property.fromJson(e as Map<String, dynamic>))
          .toList();

      if (list.isEmpty) {
        return [Property.sampleDefault];
      }
      return list;
    } catch (_) {
      return [Property.sampleDefault];
    }
  }

  Future<void> addProperty({
    required String name,
    required PropertyType type,
    required int bedrooms,
    required int bathrooms,
    required double areaSqm,
    bool hasPets = false,
    String? specialNotes,
  }) async {
    final user = ref.read(currentUserProvider);
    final client = ref.read(supabaseProvider);

    final newProp = Property(
      id: 'prop_${DateTime.now().millisecondsSinceEpoch}',
      userId: user?.id ?? '',
      name: name,
      type: type,
      bedrooms: bedrooms,
      bathrooms: bathrooms,
      areaSqm: areaSqm,
      hasPets: hasPets,
      specialNotes: specialNotes,
    );

    if (user != null) {
      try {
        await client.from('properties').insert(newProp.toJson());
      } catch (_) {
        // Continue locally
      }
    }

    final currentList = state.value ?? [];
    state = AsyncValue.data([newProp, ...currentList]);
    ref.read(selectedPropertyProvider.notifier).select(newProp);
  }
}
