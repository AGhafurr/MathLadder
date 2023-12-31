import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'controllers/auth_controller.dart';
import 'features/home/navbar.dart';
import 'features/boarding/boarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://eskwxcxzwbacotezhxtk.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVza3d4Y3h6d2JhY290ZXpoeHRrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMwNTQwNTcsImV4cCI6MjAxODYzMDA1N30.qT33GlY4ZmXN9MTDvXQeBYgnTABGUSuCdBNqbOsLUao',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());

    return GetMaterialApp(
      title: 'Math Ladder',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xffEDF6FF),
      ),
      debugShowCheckedModeBanner: false,
      home: Obx(() {
        return authController.session.value == null
            ? const BoardingScreen()
            : const Navbar();
      }),
    );
  }
}
