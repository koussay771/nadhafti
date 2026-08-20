import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/cleaning_package.dart';
import 'auth_provider.dart';

part 'packages_provider.g.dart';

@riverpod
Future<List<CleaningPackage>> cleaningPackages(Ref ref) async {
  final client = ref.watch(supabaseProvider);
  try {
    final response = await client
        .from('packages')
        .select()
        .order('base_price', ascending: true);

    final list = (response as List<dynamic>)
        .map((e) => CleaningPackage.fromJson(e as Map<String, dynamic>))
        .toList();

    if (list.isEmpty) {
      return CleaningPackage.fallbackPackages;
    }
    return list;
  } catch (_) {
    // Graceful fallback to seeded packages if table is pending or offline
    return CleaningPackage.fallbackPackages;
  }
}

@riverpod
class SelectedPackage extends _$SelectedPackage {
  @override
  CleaningPackage? build() => null;

  void select(CleaningPackage package) => state = package;
  void clear() => state = null;
}
