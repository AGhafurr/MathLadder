import 'package:flutter/material.dart';

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
        children: <Widget>[
          const Expanded(child: SizedBox()),
          Image.asset(
            imagePath,
            height: 300,
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 100,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 30,
                    fontFamily: 'Unlock',
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'Vollkorn',
                  ),
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    // Aksi saat tombol "Skip" ditekan
                    // Misalnya: Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NextPage()));
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(fontFamily: 'Vollkorn'),
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
