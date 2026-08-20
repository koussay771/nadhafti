import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_provider.g.dart';

// ── Supabase client singleton ─────────────────────────────────────────────────
@riverpod
SupabaseClient supabase(Ref ref) => Supabase.instance.client;

// ── Auth state stream ─────────────────────────────────────────────────────────

/// Watches the current Supabase auth session.
/// Returns `null` when the user is signed out.
@riverpod
Stream<AuthState> authStateStream(Ref ref) {
  final client = ref.watch(supabaseProvider);
  return client.auth.onAuthStateChange;
}

/// Synchronous current user — null when signed out.
@riverpod
User? currentUser(Ref ref) {
  return Supabase.instance.client.auth.currentUser;
}

// ── Auth notifier ─────────────────────────────────────────────────────────────

enum AuthStatus { idle, loading, success, error }

class AuthState2 {
  const AuthState2({this.status = AuthStatus.idle, this.errorMessage});

  final AuthStatus status;
  final String? errorMessage;

  bool get isLoading => status == AuthStatus.loading;
  bool get hasError => status == AuthStatus.error;

  AuthState2 copyWith({AuthStatus? status, String? errorMessage}) {
    return AuthState2(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState2 build() => const AuthState2();

  SupabaseClient get _client => ref.read(supabaseProvider);

  // ── Sign Up ───────────────────────────────────────────────────────────────
  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      final res = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'phone': phone,
          'role': 'customer',
        },
      );
      if (res.user == null) {
        throw Exception('Sign-up failed — no user returned.');
      }
      state = state.copyWith(status: AuthStatus.success);
    } on AuthException catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: _mapAuthError(e.message),
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  // ── Sign In ───────────────────────────────────────────────────────────────
  Future<void> signIn({required String email, required String password}) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      await _client.auth.signInWithPassword(email: email, password: password);
      state = state.copyWith(status: AuthStatus.success);
    } on AuthException catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: _mapAuthError(e.message),
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  // ── Sign Out ──────────────────────────────────────────────────────────────
  Future<void> signOut() async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      await _client.auth.signOut();
      state = state.copyWith(status: AuthStatus.idle);
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  // ── Reset Password ────────────────────────────────────────────────────────
  Future<void> sendPasswordReset(String email) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      await _client.auth.resetPasswordForEmail(email);
      state = state.copyWith(status: AuthStatus.success);
    } on AuthException catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: _mapAuthError(e.message),
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  // ── Reset state ───────────────────────────────────────────────────────────
  void reset() => state = const AuthState2();

  // ── Error message localisation (Arabic/French handled by caller) ──────────
  String _mapAuthError(String raw) {
    if (raw.contains('Invalid login credentials')) {
      return 'البريد الإلكتروني أو كلمة المرور غير صحيحة.';
    }
    if (raw.contains('User already registered')) {
      return 'هذا البريد الإلكتروني مسجل بالفعل.';
    }
    if (raw.contains('Email not confirmed')) {
      return 'يرجى تأكيد بريدك الإلكتروني أولاً.';
    }
    if (raw.contains('Password should be at least')) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل.';
    }
    return raw;
  }
}
