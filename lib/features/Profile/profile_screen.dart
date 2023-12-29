import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import './edit_profile_screen.dart';
import '../Information/information_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xffFFFFFF),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.question_mark_outlined,
              color: Color(0xff6FA6FF),
            ),
            iconSize: 36,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const InformationPage()),
              );
            },
            color: Colors.black,
          ),
        ],
        title: const Text(
          "My Account",
          style: TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Container(
            margin: const EdgeInsets.only(left: 16),
            child: Image.asset("assets/images/login.png")),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white, // Ganti dengan warna yang diinginkan
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.exit_to_app_outlined,
                        color: Colors.red,
                      ),
                      iconSize: 36,
                      onPressed: () {
                        authController.signOut();
                      },
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const CircleAvatar(
                radius: 90,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
              const SizedBox(height: 20),
              Obx(() {
                return Text(
                  '${authController.user['username']}',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 25,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
              const SizedBox(height: 15),
              Obx(() {
                return Text(
                  '${authController.user['email']}',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                );
              }),
              const SizedBox(height: 40),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const EditProfile();
                    }),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color(0xff5F54A3);
                      }
                      return const Color(0xff6FA6FF);
                    },
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 10,
                    ),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                child: const Text(
                  "Edit Profil",
                  style: TextStyle(
                    color: Color(0xffFDFDFD),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
