import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/auth_controller.dart';
import 'features/home/navbar.dart';
import 'features/boarding/boarding_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());

    return MaterialApp(
      title: 'Math Ladder',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xffEDF6FF),
      ),
      debugShowCheckedModeBanner: false,
      home: Obx(() {
        return authController.isLoggedIn.value
            ? const Navbar()
            : const BoardingScreen();
      }),
    );
  }
}
