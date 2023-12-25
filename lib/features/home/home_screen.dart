// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../features/gamePage/game_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget _buildCustomButton(BuildContext context, text, Widget page) {
    return SizedBox(
      width: 330,
      height: 70,
      child: TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return page;
          }));
        },
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all<Size>(
            const Size(330, 70),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return const Color(0xff6FA6FF);
              }
              return const Color(0xffFFFFFF);
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Vollkorn',
          ),
        ),
      ),
    );
  }

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
            "Hai Username",
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
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(45),
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "1,876",
                                    style: TextStyle(
                                      color: Color(0xff6FA6FF),
                                      fontSize: 68,
                                      fontFamily: 'Vollkorn',
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Point",
                                    style: TextStyle(
                                      color: Color(0xff6FA6FF),
                                      fontSize: 14,
                                      fontFamily: 'Vollkorn',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "last score 2 hours ago",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'Vollkorn',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              "Grade",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: 'Vollkorn',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildCustomButton(context, "NOVICE", const GamePage()),
                        const SizedBox(height: 20),
                        _buildCustomButton(
                            context, "BEGINNER", const GamePage()),
                        const SizedBox(height: 20),
                        _buildCustomButton(
                            context, "LEARNER", const GamePage()),
                        const SizedBox(height: 20),
                        _buildCustomButton(
                            context, "APPRENTICE", const GamePage()),
                        const SizedBox(height: 20),
                        _buildCustomButton(
                            context, "INTERMEDIATE", const GamePage()),
                        const SizedBox(height: 20),
                        _buildCustomButton(
                            context, "PROFICIENCE", const GamePage()),
                        const SizedBox(height: 20),
                        _buildCustomButton(
                            context, "ADVANCED", const GamePage()),
                        const SizedBox(height: 20),
                        _buildCustomButton(context, "EXPERT", const GamePage()),
                        const SizedBox(height: 20),
                        _buildCustomButton(context, "MASTER", const GamePage()),
                        const SizedBox(height: 20),
                        _buildCustomButton(
                            context, "VIRTUOS", const GamePage()),
                        const SizedBox(height: 20),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
