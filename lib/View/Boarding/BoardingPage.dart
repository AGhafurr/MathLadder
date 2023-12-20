import 'package:flutter/material.dart';
import 'package:math_ladder/View/Login/LoginPage.dart';

class BoardingPage extends StatefulWidget {
  const BoardingPage({Key? key}) : super(key: key);

  @override
  _BoardingPageState createState() => _BoardingPageState();
}

class _BoardingPageState extends State<BoardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  final List<Widget> _pages = [
    // Daftar halaman boarding
    BoardingContent(
      imagePath: "assets/images/boarding1.png",
      title: "ArithmoQues",
      description:
          "Welcome to ArithmoQuest! Prepare to embark on an exhilarating journey through the realm of numbers. Solve puzzles, conquer challenges, and ascend the MathLadder to prove your arithmetic prowess!",
    ),
    BoardingContent(
      imagePath: "assets/images/boarding2.png",
      title: "Numeric Ascent: The MathLadder Adventure",
      description:
          "Numeric Ascent beckons! Join this thrilling adventure and navigate through mathematical challenges at every step. Climb the MathLadder, face numerical trials, and emerge as a math conqueror!",
    ),
    BoardingContent(
      imagePath: "assets/images/boarding3.png",
      title: "MathMystic: Journey through Numbers",
      description:
          "Enter the world of MathMystic, where magic meets numbers. Explore the enchanted realm of mathematical puzzles, unlock secrets, and ascend the MathLadder to unveil the mysteries hidden within numerical calculations.",
    ),
    // Tambahkan halaman boarding lainnya sesuai kebutuhan
  ];

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
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LoginPage();
            }));
          }
        },
        child: Text(
          "Next",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Vollkorn',
          ),
        ),
      ),
    );
  }
}

class BoardingContent extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const BoardingContent({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: SizedBox()),
          Image.asset(
            imagePath,
            height: 300,
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 30, fontFamily: 'Unlock'),
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Vollkorn',
                  ),
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    // Aksi saat tombol "Skip" ditekan
                    // Misalnya: Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NextPage()));
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(fontFamily: 'Vollkorn'),
                  ),
                ),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
