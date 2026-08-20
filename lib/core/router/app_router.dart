import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/signup_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/location/pick_location_screen.dart';
import '../../presentation/screens/onboarding/onboarding_screen.dart';
import '../../presentation/screens/property/add_property_screen.dart';
import '../../presentation/screens/property/select_property_screen.dart';

part 'app_router.g.dart';

// ── Route name constants ──────────────────────────────────────────────────────
abstract final class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String pickLocation = '/pick-location';
  static const String selectProperty = '/select-property';
  static const String addProperty = '/add-property';
  static const String booking = '/booking';
  static const String profile = '/profile';
  static const String settings = '/settings';
}

// ── Provider ──────────────────────────────────────────────────────────────────
@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.onboarding,
    redirect: (context, state) async {
      // Onboarding guard: skip if already seen
      if (state.matchedLocation == AppRoutes.onboarding) {
        final prefs = await SharedPreferences.getInstance();
        final seen = prefs.getBool('has_seen_onboarding') ?? false;
        if (seen) return AppRoutes.login;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.pickLocation,
        builder: (context, state) => const PickLocationScreen(),
      ),
      GoRoute(
        path: AppRoutes.selectProperty,
        builder: (context, state) => const SelectPropertyScreen(),
      ),
      GoRoute(
        path: AppRoutes.addProperty,
        builder: (context, state) => const AddPropertyScreen(),
      ),
      // TODO Phase 3: home route
      // TODO Phase 4–7: remaining routes
    ],
  );
}
