import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_provider.g.dart';

/// Tracks the current onboarding page index (0-based).
@riverpod
class OnboardingPageIndex extends _$OnboardingPageIndex {
  @override
  int build() => 0;

  void goTo(int index) => state = index;

  void next(int totalPages) {
    if (state < totalPages - 1) state = state + 1;
  }
}

/// Marks onboarding as completed and persists the flag.
@riverpod
Future<void> completeOnboarding(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('has_seen_onboarding', true);
}

/// Checks whether the user has already seen onboarding.
@riverpod
Future<bool> hasSeenOnboarding(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('has_seen_onboarding') ?? false;
}
