import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../features/gamePage/game_page.dart';
import '../gamePage/winner_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authController = Get.put(AuthController());

  String formatTimeDifference(String rawDate) {
    DateTime dateTime = DateTime.parse(rawDate);
    DateTime now = DateTime.now();

    Duration difference = now.difference(dateTime);

    if (difference.inDays >= 365) {
      int years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays >= 30) {
      int months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays >= 7) {
      int weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'just now';
    }
  }

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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Obx(() {
                                  return authController.user['id'] == null
                                      ? const Text('0')
                                      : Text(
                                          '${authController.user['points']['point']}',
                                          style: const TextStyle(
                                            color: Color(0xff6FA6FF),
                                            fontSize: 68,
                                            fontFamily: 'Vollkorn',
                                          ),
                                        );
                                }),
                                const SizedBox(width: 10),
                                const Text(
                                  "Point",
                                  style: TextStyle(
                                    color: Color(0xff6FA6FF),
                                    fontSize: 14,
                                    fontFamily: 'Vollkorn',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() {
                                  return authController.user['id'] == null
                                      ? const Text('')
                                      : Text(
                                          '${formatTimeDifference(authController.user['points']['created_at'])}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: 'Vollkorn',
                                          ),
                                        );
                                }),
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
                      _buildCustomButton(context, "NOVICE",
                          const GamePage(dificuty: "Beginner")),
                      const SizedBox(height: 20),
                      _buildCustomButton(
                          context, "BEGINNER", const WinnerPage()),
                      const SizedBox(height: 20),
                      _buildCustomButton(context, "LEARNER",
                          const GamePage(dificuty: "Intermediate")),
                      const SizedBox(height: 20),
                      _buildCustomButton(context, "APPRENTICE",
                          const GamePage(dificuty: "Advanced")),
                      const SizedBox(height: 20),
                      _buildCustomButton(context, "INTERMEDIATE",
                          const GamePage(dificuty: "Advanced")),
                      const SizedBox(height: 20),
                      _buildCustomButton(context, "PROFICIENCE",
                          const GamePage(dificuty: "Advanced")),
                      const SizedBox(height: 20),
                      _buildCustomButton(context, "ADVANCED",
                          const GamePage(dificuty: "Advanced")),
                      const SizedBox(height: 20),
                      _buildCustomButton(context, "EXPERT",
                          const GamePage(dificuty: "Advanced")),
                      const SizedBox(height: 20),
                      _buildCustomButton(context, "MASTER",
                          const GamePage(dificuty: "Advanced")),
                      const SizedBox(height: 20),
                      _buildCustomButton(context, "VIRTUOS",
                          const GamePage(dificuty: "Advanced")),
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
  }
}
