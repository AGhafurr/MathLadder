import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../home/navbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
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
              onPressed: () {},
              color: Colors.black,
            ),
          ],
          title: const Text(
            "My Account",
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Vollkorn',
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
                        color:
                            Colors.white, // Ganti dengan warna yang diinginkan
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.exit_to_app_outlined,
                          color: Colors.red,
                        ),
                        iconSize: 36,
                        onPressed: () {
                          authProvider.signOut();
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
                const Text(
                  "IVAN ALLY RAMADHAN",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Vollkorn',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "E-mail : ivan@gmail.com",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Vollkorn',
                  ),
                ),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const Navbar();
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
                      fontFamily: 'Vollkorn',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}