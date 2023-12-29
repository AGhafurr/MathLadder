import 'package:flutter/material.dart';

import '../../widgets/boarding_content.dart';
import '../auth/sign_in/sign_in_screen.dart';

final List _pages = <Widget>[
  const BoardingContent(
    imagePath: "assets/images/boarding1.png",
    title: "ArithmoQues",
    description:
        "Welcome to ArithmoQuest! Prepare to embark on an exhilarating journey through the realm of numbers. Solve puzzles, conquer challenges, and ascend the MathLadder to prove your arithmetic prowess!",
  ),
  const BoardingContent(
    imagePath: "assets/images/boarding2.png",
    title: "Numeric Ascent: The MathLadder Adventure",
    description:
        "Numeric Ascent beckons! Join this thrilling adventure and navigate through mathematical challenges at every step. Climb the MathLadder, face numerical trials, and emerge as a math conqueror!",
  ),
  const BoardingContent(
    imagePath: "assets/images/boarding3.png",
    title: "MathMystic: Journey through Numbers",
    description:
        "Enter the world of MathMystic, where magic meets numbers. Explore the enchanted realm of mathematical puzzles, unlock secrets, and ascend the MathLadder to unveil the mysteries hidden within numerical calculations.",
  ),
];

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: _pages.length,
        itemBuilder: (BuildContext context, int index) {
          return _pages[index];
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_pageController.page != _pages.length - 1) {
            // Jika belum sampai halaman terakhir, pindah ke halaman berikutnya
            _pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return const SignInScreen();
              }),
            );
          }
        },
        child: const Text(
          "Next",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Vollkorn',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
