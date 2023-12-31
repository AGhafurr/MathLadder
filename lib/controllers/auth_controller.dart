import 'dart:async';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../features/home/navbar.dart';
import '../features/auth/sign_in/sign_in_screen.dart';

class AuthController extends GetxController {
  final supabase = Supabase.instance.client;
  final authChangeEvent = Rx<AuthChangeEvent?>(null);
  final session = Rx<Session?>(null);
  late StreamSubscription<AuthState> authSubscription;
  final user = {}.obs;

  @override
  void onInit() {
    super.onInit();
    initAuthListener();
  }

  void initAuthListener() {
    authSubscription = supabase.auth.onAuthStateChange.listen((data) async {
      try {
        final AuthChangeEvent event = data.event;
        if (event == AuthChangeEvent.initialSession) {
          session.value = data.session;
          if (session.value == null) return;
          user.value = await getUserData(id: data.session!.user.id);
          Get.offAll(() {
            return const Navbar();
          });
        }
        if (event == AuthChangeEvent.signedIn) {
          session.value = data.session;
          if (session.value == null) return;
          user.value = await getUserData(id: data.session!.user.id);
          Get.offAll(() {
            return const Navbar();
          });
        }
        if (event == AuthChangeEvent.signedOut) {
          if (session.value == null) return;
          session.value = data.session;
          user.value = {};
          Get.offAll(() {
            return const SignInScreen();
          });
        }
      } catch (error) {
        rethrow;
      }
    });
  }

  Future<Map> getUserData({required String id}) async {
    try {
      final data =
          await supabase.from('users').select('*, points(*)').eq('id', id);
      print(data);
      return data[0];
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final data = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      await supabase.from('users').insert({
        'id': data.session?.user.id,
        'username': username,
        'email': data.session?.user.email,
      });
      await supabase.from('points').insert({
        'id': data.session?.user.id,
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      print(error);
    }
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (error) {
      print(error);
    }
  }

  @override
  void onClose() {
    super.onClose();
    authSubscription.cancel();
  }
}
