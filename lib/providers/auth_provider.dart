import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier {
  final SupabaseClient _supabase;
  late Session? _session;
  late StreamSubscription<AuthState> _authSubscription;

  AuthProvider(this._supabase) {
    _authSubscription = listenToAuthStatus();
  }

  Session? get session => _session;

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    await _supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut(scope: SignOutScope.local);
  }

  StreamSubscription<AuthState> listenToAuthStatus() {
    return _supabase.auth.onAuthStateChange.listen((data) {
      final Session? session = data.session;
      final AuthChangeEvent event = data.event;

      if (event == AuthChangeEvent.initialSession) {
        _session = session;
      } else if (event == AuthChangeEvent.signedIn) {
        _session = session;
      } else if (event == AuthChangeEvent.signedOut) {
        _session = null;
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }
}
